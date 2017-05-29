<%@ Control Language="vb" AutoEventWireup="false" Explicit="True" Inherits="DotNetNuke.UI.Containers.Container" %>
<%@ Register TagPrefix="dnn" TagName="TITLE" Src="~/Admin/Containers/Title.ascx" %>
<%@ Register TagPrefix="dnn" TagName="VISIBILITY" Src="~/Admin/Containers/Visibility.ascx" %>
<h1>
    <dnn:TITLE runat="server" id="dnnTITLE" />
</h1>
<div id="ContentPane" runat="server">
</div>
<div class="clearfix">
</div>
