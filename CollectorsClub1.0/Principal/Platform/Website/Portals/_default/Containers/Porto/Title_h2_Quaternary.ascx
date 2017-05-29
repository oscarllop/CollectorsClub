<%@ Control Language="vb" AutoEventWireup="false" Explicit="True" Inherits="DotNetNuke.UI.Containers.Container" %>
<%@ Register TagPrefix="dnn" TagName="TITLE" Src="~/Admin/Containers/Title.ascx" %>
<%@ Register TagPrefix="dnn" TagName="VISIBILITY" Src="~/Admin/Containers/Visibility.ascx" %>
<div class="heading heading-quaternary heading-border heading-bottom-border">
    <h2 class="heading-quaternary">
        <dnn:TITLE runat="server" id="dnnTITLE" />
    </h2>
</div>
<div id="ContentPane" runat="server">
</div>
<div class="clearfix">
</div>
