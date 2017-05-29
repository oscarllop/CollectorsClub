<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="LicenseManager.ascx.cs"
    Inherits="Mandeeps.DNN.Modules.LiveSlider.Licensing.LicenseManager" %>
    <style type="text/css">
    .MNormal
    {
        font-family: Tahoma, Arial, Helvetica;
        font-size: 11px;
        font-weight: normal;
    }
    .MNormalBold
    {
        font-family: Tahoma, Arial, Helvetica;
        font-size: 11px;
        font-weight: bold;
    }
    .MNormalRed
    {
        font-family: Tahoma, Arial, Helvetica;
        font-size: 12px;
        font-weight: bold;
        color: #ff0000;
    }
    .MHead
    {
        font-family: Tahoma, Arial, Helvetica;
        font-size: 20px;
        font-weight: normal;
        color: #333333;
    }
    .MSubHead
    {
        font-family: Tahoma, Arial, Helvetica;
        font-size: 11px;
        font-weight: bold;
        color: #003366;
    }
    .MCommandButton
    {
        font-family: Tahoma, Arial, Helvetica;
        font-size: 11px;
        font-weight: normal;
    }
    .MNormalTextBox
    {
        font-family: Tahoma, Arial, Helvetica;
        font-size: 12px;
        font-weight: normal;
    }
</style>
<div style="text-align: center;">
    <div style="text-align: left">
        <asp:Label ID="lTitle" runat="server" Text="License Manager" CssClass="MHead"></asp:Label>
        <br />
        <br />
        <asp:Label ID="lStatus" runat="server" CssClass="MSubHead"></asp:Label>
    </div>
    <br />
    <asp:Label ID="lEdition" runat="server" CssClass="MSubHead" 
        Text="Selected Edition"/>
    &nbsp;
    <asp:DropDownList ID="ddlEdition" runat="server" AutoPostBack="True" 
        onselectedindexchanged="ddlEdition_SelectedIndexChanged">
    </asp:DropDownList>
    &nbsp;<asp:HyperLink ID="hlEdition" runat="server" CssClass="MNormal" 
        style="font-size:10px" Target="_blank">Help Me Choose?</asp:HyperLink>
    <br />
    <br />
    <asp:ImageButton ID="ibActivate" runat="server" onclick="ibActivate_Click" />
    &nbsp;&nbsp;
    <asp:ImageButton ID="ibFinish" runat="server" onclick="ibFinish_Click" />

    &nbsp;</div>
