<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Header2.ascx.cs" Inherits="Mandeeps.DNN.Skins.Porto.Header2" %>
<%@ Register TagPrefix="dnn" TagName="LANGUAGE" Src="~/Admin/Skins/Language.ascx" %>
<%@ Register TagPrefix="dnn" TagName="LOGO" Src="~/Admin/Skins/Logo.ascx" %>
<%@ Register TagPrefix="dnn" TagName="SEARCH" Src="~/Admin/Skins/Search.ascx" %>
<%@ Register TagPrefix="dnn" TagName="USER" Src="~/Admin/Skins/User.ascx" %>
<%@ Register TagPrefix="dnn" TagName="LOGIN" Src="~/Admin/Skins/Login.ascx" %>
<%@ Register TagPrefix="dnn" TagName="MENU" Src="~/DesktopModules/DDRMenu/Menu.ascx" %>
<header class="flat-menu clean-top">
<div class="header-top">
    <div class="container">
    <div class="search">
        <div class="input-group">
            <dnn:search id="dnnSearch" runat="server" showsite="false" showweb="false" enabletheming="true"
                submit="&nbsp;" cssclass="icon-search" />
        </div>
    </div>
        <div id="login">
            <dnn:user id="dnnUser" runat="server" legacymode="false" />
            <dnn:login id="dnnLogin" cssclass="LoginLink" runat="server" legacymode="false" />
        </div>
        <div class="social-icons">
            <ul class="social-icons">
                <li class="facebook"><a href="http://www.facebook.com/" target="_blank" title="Facebook">
                    Facebook</a></li>
                <li class="twitter"><a href="http://www.twitter.com/" target="_blank" title="Twitter">
                    Twitter</a></li>
                <li class="linkedin"><a href="http://www.linkedin.com/" target="_blank" title="Linkedin">
                    Linkedin</a></li>
            </ul>
        </div>
    </div>
</div>
<div class="container">
    <h1 class="logo">
        <dnn:logo runat="server" id="LOGO1" />
    </h1>
</div>
<div class="navbar-collapse nav-main-collapse collapse">
    <div class="container">
        <dnn:menu id="MENU" menustyle="Resources/Menu" runat="server" class="nav nav-pills nav-main">
        </dnn:menu>
    </div>
</div>
</header> 