<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Header5.ascx.cs" Inherits="Mandeeps.DNN.Skins.Porto.Header5" %>
<%@ Register TagPrefix="dnn" TagName="LANGUAGE" Src="~/Admin/Skins/Language.ascx" %>
<%@ Register TagPrefix="dnn" TagName="LOGO" Src="~/Admin/Skins/Logo.ascx" %>
<%@ Register TagPrefix="dnn" TagName="SEARCH" Src="~/Admin/Skins/Search.ascx" %>
<%@ Register TagPrefix="dnn" TagName="USER" Src="~/Admin/Skins/User.ascx" %>
<%@ Register TagPrefix="dnn" TagName="LOGIN" Src="~/Admin/Skins/Login.ascx" %>
<%@ Register TagPrefix="dnn" TagName="MENU" Src="~/DesktopModules/DDRMenu/Menu.ascx" %>
<header class="clean-top center">
<div class="header-top">
    <div class="container">
        <div class="search">
            <div class="control-group">
                <dnn:search id="dnnSearch" runat="server" showsite="false" showweb="false" enabletheming="true"
                    submit="&nbsp;" cssclass="icon-search" />
            </div>
        </div>
        <div id="login">
            <dnn:user id="dnnUser" runat="server" legacymode="false" />
            <dnn:login id="dnnLogin" cssclass="LoginLink" runat="server" legacymode="false" />
        </div>
        <div class="language">
            <dnn:language runat="server" id="dnnLANGUAGE" showmenu="False" showlinks="True" />
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