<%@ Control Language="vb" AutoEventWireup="false" Explicit="True" Inherits="DotNetNuke.UI.Containers.Container" %>
<%@ Register TagPrefix="dnn" TagName="TITLE" Src="~/Admin/Containers/Title.ascx" %>
<%@ Register TagPrefix="dnn" TagName="VISIBILITY" Src="~/Admin/Containers/Visibility.ascx" %>
<div class="heading heading-primary heading-border heading-bottom-border">
    <h3 class="heading-primary">
        <dnn:TITLE runat="server" id="dnnTITLE" />
    </h3>
</div>
<div id="ContentPane" runat="server">
</div>
<div class="clearfix">
</div>
