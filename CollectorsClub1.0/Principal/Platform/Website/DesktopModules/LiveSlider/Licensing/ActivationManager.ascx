<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ActivationManager.ascx.cs"
    Inherits="Mandeeps.DNN.Modules.LiveSlider.Licensing.ActivationManager" %>
<style type="text/css">
    a.mbutton
    {
        font-family: Helvetica,Arial,sans-serif;
        padding: 5px 10px;
        background: #818181;
        filter: progid:DXImageTransform.Microsoft.gradient(startColorstr=#818181, endColorstr=#656565);
        -ms-filter: "progid:DXImageTransform.Microsoft.gradient(startColorstr=#818181, endColorstr=#656565)";
        background: -webkit-gradient(linear, left top, left bottom, from(#818181), to(#656565));
        background: -moz-linear-gradient(center top , #818181 0%, #656565 100%) repeat scroll 0 0 transparent;
        border-color: #FFFFFF;
        border-radius: 3px;
        color: #FFFFFF;
        font-weight: bold;
        text-decoration: none;
        color: #fff;
        text-shadow: 0 1px 1px #000000;
    }
    a.mbutton:hover
    {
        background: #4E4E4E;
        color: #ffffff;
        text-decoration: none;
    }
    a.mbutton2
    {
        font-weight: bold;
        padding: 8px;
        text-decoration: none;
        color: #003366;
    }
    a.mbutton2:hover
    {
        text-decoration: underline;
        color: #000;
    }
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
        <asp:Label ID="lTitle" runat="server" Text="Activation Manager" CssClass="MHead"></asp:Label>
        <br />
        <br />
        <asp:Label ID="lStatus" runat="server"></asp:Label>
    </div>
    <asp:ImageButton ID="bContinue" runat="server" ImageUrl="~/ActivationManager/Continue.gif"
        Visible="False" OnClick="bContinue_Click" />
    <asp:MultiView ID="mView" runat="server" ActiveViewIndex="0">
        <asp:View ID="viewMenu" runat="server">
            <div style="text-align: center">
                <br />
                <a id="bPurchaseKeyLink" runat="server" href="#">
                    <img id="bPurchaseKeyImage" src="~/ActivationManager/PurchaseKey.jpg" alt="Purchase License"
                        runat="server" border="0" /></a> &nbsp;&nbsp;&nbsp;&nbsp;
                <asp:ImageButton ID="bRequestKey" runat="server" ImageUrl="~/ActivationManager/RequestKey.gif"
                    OnClick="bRequestKey_Click" />
                &nbsp;&nbsp;&nbsp;&nbsp;
                <asp:ImageButton ID="bApplyKey" runat="server" ImageUrl="~/ActivationManager/ApplyKey.gif"
                    OnClick="bApplyKey_Click" />
                <br />
                <br />
                <asp:Label ID="lEdition" runat="server" Font-Size="8pt"></asp:Label>
                <br />
                <br />
                <br />
                <asp:ImageButton ID="ibAMCancel" runat="server" ImageUrl="~/images/lt.gif" OnClick="ibAMCancel_Click" />
                <asp:LinkButton ID="bAMCancel" runat="server" CssClass="MCommandButton" ResourceKey="Cancel"
                    OnClick="bAMCancel_Click">Cancel</asp:LinkButton>
            </div>
        </asp:View>
        <asp:View ID="viewRequestKey" runat="server">
            <div style="text-align: center">
                <br />
                <asp:Label ID="Label1" runat="server" CssClass="MSubHead" Text="Email:"></asp:Label>
                &nbsp;<asp:TextBox ID="tbEmail" runat="server" Width="300px" CssClass="NormalTextBox"></asp:TextBox>
                &nbsp;<br />
                <br />
                <asp:LinkButton ID="bRequestKeySubmit" runat="server" Text="Request Activation Key"
                    CssClass="mbutton" OnClick="bRequestKeySubmit_Click" />
                &nbsp;<asp:LinkButton ID="bRequestKeyCancel" runat="server" OnClick="bCancel_Click"
                    CssClass="mbutton2" Text="Cancel" />
            </div>
            <div style="text-align: left">
                <br />
                <br />
                <asp:Label ID="lactivateEdition" runat="server"></asp:Label>
                <br />
                <br />
                <asp:Label ID="lSerialKey" Text="Edition:" runat="server"></asp:Label>
                <asp:Panel ID="panelManualActivation" Visible="false" runat="server">
                    <br />
                    <br />
                    <asp:LinkButton runat="server" ID="RequestActivation" CssClass="mbutton" OnClick="RequestActivation_Click"
                        Text="Activate Online" />
                    <br />
                    <br />
                    <br />
                </asp:Panel>
            </div>
        </asp:View>
        <asp:View ID="viewApplyKey" runat="server">
            <div style="text-align: center">
                <br />
                <asp:Label ID="Label2" runat="server" CssClass="MSubHead" Text="Activation Key:"></asp:Label>
                &nbsp;<asp:TextBox ID="tbActivationKey" runat="server" Width="300px" CssClass="NormalTextBox"></asp:TextBox>
                &nbsp;<br />
                <br />
                <asp:LinkButton ID="bApplyKeySubmit" runat="server" CssClass="mbutton" Text="Apply Activation Key"
                    OnClick="bApplyKeySubmit_Click" />
                &nbsp;<asp:LinkButton ID="bApplyKeyCancel" runat="server" CssClass="mbutton2" Text="Cancel"
                    OnClick="bCancel_Click" />
            </div>
        </asp:View>
        <asp:View ID="viewAvailableEditions" runat="server">
            <div style="text-align: center">
                <br />
                <asp:Label ID="Label3" runat="server" CssClass="MSubHead" Text="Select Edition" />
                &nbsp;
                <asp:DropDownList ID="ddlAvailableEditions" runat="server">
                </asp:DropDownList>
                <br />
                <br />
                <asp:ImageButton ID="bAvailableEditionsSubmit" runat="server" ImageUrl="~/ActivationManager/Submit.gif"
                    OnClick="bAvailableEditionsSubmit_Click" />
                &nbsp;<asp:ImageButton ID="bAvailableEditionsCancel" runat="server" ImageUrl="~/ActivationManager/Cancel.gif"
                    OnClick="bCancel_Click" />
            </div>
        </asp:View>
    </asp:MultiView>
</div>
