<%@ Control Language="vb" AutoEventWireup="false" Explicit="True" Inherits="DotNetNuke.UI.Containers.Container" %>
<%@ Register TagPrefix="dnn" TagName="TITLE" Src="~/Admin/Containers/Title.ascx" %>
<%@ Register TagPrefix="dnn" TagName="VISIBILITY" Src="~/Admin/Containers/Visibility.ascx" %>
<h5 class="heading-tertiary">
    <dnn:TITLE runat="server" id="dnnTITLE" />
</h5>
<div id="ContentPane" runat="server">
</div>
<div class="clearfix">
</div>
