﻿using Dnn.PersonaBar.Library.Model;
using Dnn.PersonaBar.Pages.Services.Dto;
using Newtonsoft.Json.Linq;

namespace Dnn.PersonaBar.Pages.Components.Security
{
    public interface ISecurityService
    {
        bool IsVisible(MenuItem menuItem);

        JObject GetCurrentPagePermissions();

        bool IsPageAdminUser();

        bool CanManagePage(int tabId);

        bool CanDeletePage(int tabId);

        bool CanAdminPage(int tabId);

        bool CanAddPage(int tabId);

        bool CanCopyPage(int tabId);

        bool CanExportPage(int tabId);

        bool CanSavePageDetails(PageSettings pageSettings);
    }
}
