<%@ Control Language="vb" AutoEventWireup="false" Explicit="True" Inherits="DotNetNuke.UI.Containers.Container" %>
<%@ Register TagPrefix="dnn" TagName="TITLE" Src="~/Admin/Containers/Title.ascx" %>
<%@ Register TagPrefix="dnn" TagName="VISIBILITY" Src="~/Admin/Containers/Visibility.ascx" %>
<div class="heading-quaternary">
    <h1 class="heading-quaternary">
        <dnn:TITLE runat="server" id="dnnTITLE" />
    </h1></div>
</div>
<div id="ContentPane" runat="server">
</div>
<div class="clearfix">
</div>
