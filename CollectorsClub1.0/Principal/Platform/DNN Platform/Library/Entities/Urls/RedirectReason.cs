﻿#region Copyright

// 
// DotNetNuke® - http://www.dotnetnuke.com
// Copyright (c) 2002-2017
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

namespace DotNetNuke.Entities.Urls
{
    public enum RedirectReason
    {
        Unfriendly_Url_1,
        Unfriendly_Url_2,
        Not_Lower_Case,
        Wrong_Sub_Domain,
        Custom_Redirect,
        Wrong_Portal,
        Not_Redirected,
        Deleted_Page,
        Disabled_Page,
        Spaces_Replaced,
        Wrong_Portal_Alias,
        Wrong_Portal_Alias_For_Browser_Type,
        Wrong_Portal_Alias_For_Culture,
        Wrong_Portal_Alias_For_Culture_And_Browser,
        Custom_Tab_Alias,
        Site_Root_Home,
        Secure_Page_Requested,
        Tab_External_Url,
        Tab_Permanent_Redirect,
        Host_Portal_Used,
        Alias_In_Url,
        User_Profile_Url,
        Unfriendly_Url_Child_Portal,
        Unfriendly_Url_TabId,
        Error_Event,
        No_Portal_Alias,
        Requested_404,
        Requested_404_In_Url,
        Page_404,
        Exception,
        File_Url,
        Built_In_Url,
        SiteUrls_Config_Rule,
        Diacritic_Characters,
        Module_Provider_Rewrite_Redirect,
        Module_Provider_Redirect,
        Requested_SplashPage
    }
}