﻿using System;
using Dnn.PersonaBar.Library.Model;
using Dnn.PersonaBar.Pages.Services.Dto;
using DotNetNuke.ComponentModel;
using DotNetNuke.Entities.Portals;
using DotNetNuke.Entities.Tabs;
using DotNetNuke.Entities.Users;
using DotNetNuke.Framework;
using DotNetNuke.Security.Permissions;
using Newtonsoft.Json.Linq;

namespace Dnn.PersonaBar.Pages.Components.Security
{
    public class SecurityService : ISecurityService
    {
        private readonly ITabController _tabController;

        public SecurityService()
        {
            _tabController = TabController.Instance;
        }

        public static ISecurityService Instance
        {
            get
            {
                var controller = ComponentFactory.GetComponent<ISecurityService>("SecurityService");
                if (controller == null)
                {
                    ComponentFactory.RegisterComponent<ISecurityService, SecurityService>("SecurityService");
                }

                return ComponentFactory.GetComponent<ISecurityService>("SecurityService");
            }
        }

        public virtual bool IsPageAdminUser()
        {
            var user = UserController.Instance.GetCurrentUserInfo();
            return user.IsSuperUser || user.IsInRole(PortalSettings.Current?.AdministratorRoleName);
        }

        public virtual bool IsVisible(MenuItem menuItem)
        {
            return IsPageAdminUser() || IsPageAdmin();
        }

        private bool IsPageAdmin()
        {
            return //TabPermissionController.CanAddContentToPage() ||
                    TabPermissionController.CanAddPage()
                    || TabPermissionController.CanAdminPage()
                    || TabPermissionController.CanCopyPage()
                    || TabPermissionController.CanDeletePage()
                    || TabPermissionController.CanExportPage()
                    || TabPermissionController.CanImportPage()
                    || TabPermissionController.CanManagePage();
        }

        public virtual JObject GetCurrentPagePermissions()
        {
            var permissions = new JObject
            {
                {"addContentToPage", TabPermissionController.CanAddContentToPage()},
                {"addPage", TabPermissionController.CanAddPage()},
                {"adminPage", TabPermissionController.CanAdminPage()},
                {"copyPage", TabPermissionController.CanCopyPage()},
                {"deletePage", TabPermissionController.CanDeletePage()},
                {"exportPage", TabPermissionController.CanExportPage()},
                {"importPage", TabPermissionController.CanImportPage()},
                {"managePage", TabPermissionController.CanManagePage()}
            };

            return permissions;
        }

        public virtual bool CanAdminPage(int tabId)
        {
            return IsPageAdminUser() || TabPermissionController.CanAdminPage(GetTabById(tabId));
        }

        public virtual bool CanManagePage(int tabId)
        {
            return CanAdminPage(tabId) || TabPermissionController.CanManagePage(GetTabById(tabId));
        }

        public virtual bool CanDeletePage(int tabId)
        {
            return CanAdminPage(tabId) || TabPermissionController.CanDeletePage(GetTabById(tabId));
        }

        public virtual bool CanAddPage(int tabId)
        {
            return CanAdminPage(tabId) || TabPermissionController.CanAddPage(GetTabById(tabId));
        }

        public virtual bool CanCopyPage(int tabId)
        {
            return CanAdminPage(tabId) || TabPermissionController.CanCopyPage(GetTabById(tabId));
        }

        public virtual bool CanExportPage(int tabId)
        {
            return CanAdminPage(tabId) || TabPermissionController.CanExportPage(GetTabById(tabId));
        }

        public virtual bool CanSavePageDetails(PageSettings pageSettings)
        {
            var tabId = pageSettings.TabId;
            var pageType = pageSettings.PageType;
            var parentId = pageSettings.ParentId ?? 0;
            var creatingPage = parentId > 0 && tabId <= 0 && pageType == "normal";
            var updatingPage = tabId > 0 && pageType == "normal";
            var creatingTemplate = tabId <= 0 && pageSettings.TemplateTabId > 0 && pageType == "template";
            var duplicatingPage = tabId <= 0 && pageSettings.TemplateTabId > 0 && pageType == "normal";

            return (
                IsPageAdminUser() ||
                creatingPage && CanAddPage(parentId) ||
                creatingTemplate && CanExportPage(pageSettings.TemplateTabId) ||
                updatingPage && CanManagePage(tabId) ||
                duplicatingPage && CanCopyPage(pageSettings.TemplateTabId)
            );
        }

        private TabInfo GetTabById(int pageId)
        {
            var portalSettings = PortalController.Instance.GetCurrentPortalSettings();
            return pageId <= 0 ? null : _tabController.GetTab(pageId, portalSettings.PortalId, false);
        }
    }
}