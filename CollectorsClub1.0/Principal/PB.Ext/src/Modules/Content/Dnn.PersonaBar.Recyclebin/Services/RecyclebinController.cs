#region Copyright

// DotNetNuke� - http://www.dotnetnuke.com
// Copyright (c) 2002-2016
// by DotNetNuke Corporation
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated 
// documentation files (the "Software"), to deal in the Software without restriction, including without limitation 
// the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and 
// to permit persons to whom the Software is furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in all copies or substantial portions 
// of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED 
// TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL 
// THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF 
// CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
// DEALINGS IN THE SOFTWARE.

#endregion

using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Web.Http;
using Dnn.PersonaBar.Library;
using DotNetNuke.Common;
using DotNetNuke.Entities.Modules;
using DotNetNuke.Entities.Tabs;
using DotNetNuke.Web.Api;
using Dnn.PersonaBar.Library.Attributes;
using Dnn.PersonaBar.Recyclebin.Components;
using Dnn.PersonaBar.Recyclebin.Components.Dto;
using DotNetNuke.Entities.Users;

namespace Dnn.PersonaBar.Recyclebin.Services
{
    [MenuPermission(MenuName = "Dnn.Recyclebin")]
    public class RecyclebinController : PersonaBarApiController
    {
        [HttpGet]
        public HttpResponseMessage GetDeletedPageList()
        {
            var tabs = Components.RecyclebinController.Instance.GetDeletedTabs();
            var deletedtabs = from t in tabs
                select ConvertToPageItem(t, tabs);
            return Request.CreateResponse(HttpStatusCode.OK, deletedtabs);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public HttpResponseMessage RemovePage(List<PageItem> pages)
        {
            var errors = new StringBuilder();

            Components.RecyclebinController.Instance.DeleteTabs(pages, errors);
            
            if (errors.Length > 0)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new { Status = 1, 
                    Message = string.Format(Components.RecyclebinController.Instance.LocalizeString("Service_RemoveTabModuleError"), errors) });
            }

            return Request.CreateResponse(HttpStatusCode.OK, new { Status = 0 });
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public HttpResponseMessage RemoveModule(List<ModuleItem> modules)
        {
            var errors = new StringBuilder();

            Components.RecyclebinController.Instance.DeleteModules(modules, errors);

            if (errors.Length > 0)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new
                {
                    Status = 1,
                    Message = string.Format(Components.RecyclebinController.Instance.LocalizeString("Service_RemoveTabModuleError"), errors)
                });
            }

            return Request.CreateResponse(HttpStatusCode.OK, new { Status = 0 });
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public HttpResponseMessage RemoveUser(List<UserItem> users)
        {
            var errors = new StringBuilder();

            Components.RecyclebinController.Instance.DeleteUsers(users);

            if (errors.Length > 0)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new
                {
                    Status = 1,
                    Message = string.Format(Components.RecyclebinController.Instance.LocalizeString("Service_RemoveUserError"), errors)
                });
            }

            return Request.CreateResponse(HttpStatusCode.OK, new { Status = 0 });
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public HttpResponseMessage RestorePage(List<PageItem> pages)
        {
            var errors = new StringBuilder();
            if (pages != null && pages.Any())
            {
                foreach (var tab in pages.Select(page => TabController.Instance.GetTab(page.Id, PortalSettings.PortalId)))
                {
                    if (tab == null)
                    {
                        return Request.CreateResponse(HttpStatusCode.NotFound);
                    }
                    string resultmessage;
                    Components.RecyclebinController.Instance.RestoreTab(tab, out resultmessage);
                    errors.Append(resultmessage);
                }
            }
            return errors.Length > 0 ? Request.CreateResponse(HttpStatusCode.OK, new { Status = 1, Message = string.Format(Components.RecyclebinController.Instance.LocalizeString("Service_RestoreTabModuleError"), errors) }) 
                : Request.CreateResponse(HttpStatusCode.OK, new { Status = 0 });
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public HttpResponseMessage RestoreModule(List<ModuleItem> modules)
        {   
            //modules dic stores module.Key=moduleId, module.Value=pageId;
            var result = true;
            var errors = new StringBuilder();
            if (modules != null && modules.Any())
            {
                foreach (var module in modules)
                {
                    var tab = TabController.Instance.GetTab(module.TabID, PortalSettings.PortalId);
                    if (tab == null)
                    {
                        return Request.CreateResponse(HttpStatusCode.NotFound);
                    }
                    string resultmessage;
                    result = Components.RecyclebinController.Instance.RestoreModule(module.Id, module.TabID, out resultmessage);
                    errors.Append(resultmessage);

                }
            }
            if (!result)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new { Status = 1, Message = errors });
            }
            return Request.CreateResponse(HttpStatusCode.OK, new { Status = 0 });
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public HttpResponseMessage RestoreUser(List<UserItem> users)
        {
            var errors = new StringBuilder();
            if (users != null && users.Any())
            {
                foreach (var user in users.Select(u => UserController.Instance.GetUserById(PortalSettings.PortalId, u.Id)))
                {
                    if (user == null)
                    {
                        return Request.CreateResponse(HttpStatusCode.NotFound);
                    }
                    string resultmessage;
                    Components.RecyclebinController.Instance.RestoreUser(user, out resultmessage);
                    errors.Append(resultmessage);
                }
            }
            return errors.Length > 0 ? Request.CreateResponse(HttpStatusCode.OK, new { Status = 1, Message = string.Format(Components.RecyclebinController.Instance.LocalizeString("Service_RestoreTabModuleError"), errors) })
                : Request.CreateResponse(HttpStatusCode.OK, new { Status = 0 });
        }

        [HttpGet]
        public HttpResponseMessage GetDeletedModuleList()
        {
            var mods = Components.RecyclebinController.Instance.GetDeletedModules();
            var deletedmodules = from t in mods select ConvertToModuleItem(t);
            return Request.CreateResponse(HttpStatusCode.OK, deletedmodules);
        }

        [HttpGet]
        public HttpResponseMessage GetDeletedUserList()
        {
            var users = Components.RecyclebinController.Instance.GetDeletedUsers();
            var deletedusers = from t in users select ConvertToUserItem(t);
            return Request.CreateResponse(HttpStatusCode.OK, deletedusers);
        }

        [HttpGet]
        public HttpResponseMessage EmptyRecycleBin()
        {
            var deletedTabs = Components.RecyclebinController.Instance.GetDeletedTabs();
            var deletedModules = Components.RecyclebinController.Instance.GetDeletedModules();
            var deletedUsers = Components.RecyclebinController.Instance.GetDeletedUsers();
            var errors = new StringBuilder();

            Components.RecyclebinController.Instance.DeleteModules(deletedModules, errors);

            Components.RecyclebinController.Instance.DeleteTabs(deletedTabs, errors, true);

            Components.RecyclebinController.Instance.DeleteUsers(deletedUsers);

            if (errors.Length > 0)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new
                {
                    Status = 1,
                    Message =
                        string.Format(
                            Components.RecyclebinController.Instance.LocalizeString("Service_EmptyRecycleBinError"),
                            errors)
                });
            }

            return Request.CreateResponse(HttpStatusCode.OK, new {Status = 0});
        }

        #region Private Methods

        private PageItem ConvertToPageItem(TabInfo tab, IEnumerable<TabInfo> portalTabs)
        {
            return new PageItem
            {
                       Id = tab.TabID,
                       Name = tab.LocalizedTabName,
                       Url = tab.FullUrl,
                       ChildrenCount = portalTabs != null ? portalTabs.Count(ct => ct.ParentId == tab.TabID) : 0,
                       PublishDate = tab.CreatedOnDate.ToString("MM/dd/yyyy"),
                       Status = Components.RecyclebinController.Instance.GetTabStatus(tab),
                       ParentId = tab.ParentId,
                       Level = tab.Level,
                       IsSpecial = TabController.IsSpecialTab(tab.TabID, PortalSettings),
                       TabPath = tab.TabPath.Replace("//","/"),
                       LastModifiedOnDate = tab.LastModifiedOnDate.ToString("MM/dd/yyyy h:mm:ss tt", CultureInfo.CreateSpecificCulture(tab.CultureCode ?? "en-US")),
                       FriendlyLastModifiedOnDate = tab.LastModifiedOnDate.ToString("MM/dd/yyyy h:mm:ss tt", CultureInfo.CreateSpecificCulture(tab.CultureCode ?? "en-US")),
                       UseDefaultSkin = UseDefaultSkin(tab)
                   };
        }

        private bool UseDefaultSkin(TabInfo tab)
        {
            return !string.IsNullOrEmpty(tab.SkinSrc) && tab.SkinSrc.Equals(PortalSettings.DefaultPortalSkin, StringComparison.InvariantCultureIgnoreCase);
        }

        private ModuleItem ConvertToModuleItem(ModuleInfo mod)
        {
            var tab = TabController.Instance.GetTab(mod.TabID, PortalSettings.PortalId);
            return new ModuleItem
            {
                Id = mod.ModuleID,
                Title = mod.ModuleTitle,
                TabModuleId = mod.TabModuleID,
                PortalId = mod.PortalID,
                TabName = tab.TabName,
                TabID = tab.TabID,
                TabDeleted = tab.IsDeleted,
                LastModifiedOnDate = mod.LastModifiedOnDate.ToString("MM/dd/yyyy h:mm:ss tt", CultureInfo.CreateSpecificCulture(mod.CultureCode ?? "en-US")),
                FriendlyLastModifiedOnDate = mod.LastModifiedOnDate.ToString("MM/dd/yyyy h:mm:ss tt", CultureInfo.CreateSpecificCulture(mod.CultureCode ?? "en-US"))
            };
        }

        private UserItem ConvertToUserItem(UserInfo user)
        {
            return new UserItem
            {
                Id = user.UserID,
                Username = user.Username,
                PortalId = user.PortalID,
                DisplayName = user.DisplayName,
                Email = user.Email,
                LastModifiedOnDate = user.LastModifiedOnDate.ToString("MM/dd/yyyy h:mm:ss tt", CultureInfo.CreateSpecificCulture(user.Profile.PreferredLocale ?? "en-US")),
                FriendlyLastModifiedOnDate = user.LastModifiedOnDate.ToString("MM/dd/yyyy h:mm:ss tt", CultureInfo.CreateSpecificCulture(user.Profile.PreferredLocale ?? "en-US"))
            };
        }

        #endregion
    }
}
