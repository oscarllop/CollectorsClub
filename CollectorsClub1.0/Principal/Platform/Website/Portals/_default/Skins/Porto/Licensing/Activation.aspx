<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Activation.aspx.cs" Inherits="Mandeeps.DNN.Skins.Porto.Licensing.Activation" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Activation</title>
    <style>
        .form-control {
            display: inline-block !important;
        }
    </style>
    <link href="//fonts.googleapis.com/css?family=Open+Sans:300,400,600,700,800%7CShadows+Into+Light"
        rel="stylesheet" type="text/css" />
</head>
<body>
    <div class="body">
        <div class="container" style="margin-top: 25px;">
            <form id="form1" runat="server">
                <asp:Image ImageUrl="~/Portals/_default/Skins/Porto/Licensing/Images/Logo.png" ID="Logo" runat="server" />
                <hr />
                <div id="LicenseManager" runat="server" visible="false" class="center">
                    <div class="text-left">
                        <h4>
                            <asp:Label ID="Label4" runat="server" Text="License Manager"></asp:Label></h4>
                        <asp:Label ID="Label5" runat="server" Style="font-weight: bold;"></asp:Label>
                    </div>
                    <br />
                    <asp:Label ID="Label6" runat="server" Style="font-weight: bold; margin-bottom: 5px; display: inline-block;" Text="Selected Edition" />
                    <br />
                    <asp:DropDownList ID="ddlEdition" CssClass="form-control" Width="180" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlEdition_SelectedIndexChanged">
                    </asp:DropDownList>
                    <br />
                    <br />
                    <br />
                    <asp:LinkButton ID="ibActivate" runat="server" OnClick="ibActivate_Click" Text="Activate" CssClass="btn btn-success" />&nbsp;&nbsp;
                    <asp:LinkButton ID="ibFinish" runat="server" OnClick="ibFinish_Click" Text="Continue Trial" CssClass="btn btn-default" />
                </div>
                <div id="ActivationManager" runat="server" visible="false">
                    <h4>
                        <asp:Label ID="lTitle" runat="server" Text="Activation Manager"></asp:Label></h4>
                    <asp:Label ID="lStatus" runat="server"></asp:Label><br /><br />
                    <asp:LinkButton ID="bContinue" runat="server" Text="Continue" CssClass="btn btn-success" Visible="False" OnClick="bContinue_Click" />
                    <asp:MultiView ID="mView" runat="server" ActiveViewIndex="0">
                        <asp:View ID="viewMenu" runat="server">
                            <div class="text-center">
                                <asp:HyperLink ID="bPurchaseKeyLink" runat="server" Text="Step 1: Purchase License" CssClass="btn btn-success" />&nbsp;&nbsp;
                                <asp:LinkButton ID="bRequestKey" runat="server" Text="Step 2: Request Activation Key" CssClass="btn btn-info" OnClick="bRequestKey_Click" />&nbsp;&nbsp;
                                <asp:LinkButton ID="bApplyKey" runat="server" Text="Step 3: Apply Activation Key" CssClass="btn btn-info" OnClick="bApplyKey_Click" />
                                <br />
                                <br />
                                <asp:Label ID="lEdition" runat="server" Font-Size="12px"></asp:Label>
                                <br />
                                <br />
                                <br />
                                <asp:HyperLink ID="bAMCancel" Text="Cancel" runat="server" CssClass="btn btn-default"></asp:HyperLink>
                            </div>
                        </asp:View>
                        <asp:View ID="viewRequestKey" runat="server">
                            <div class="text-center">
                                <asp:Label ID="Label1" runat="server" Style="font-weight: bold; margin-bottom: 5px; display: inline-block;" Text="Email"></asp:Label>
                                <br />
                                <asp:TextBox ID="tbEmail" runat="server" Width="300px" CssClass="form-control"></asp:TextBox>
                                <br />
                                <br />
                                <br />
                                <asp:LinkButton ID="bRequestKeySubmit" runat="server" Text="Request Activation Key" CssClass="btn btn-success" OnClick="bRequestKeySubmit_Click" />&nbsp;&nbsp;
                                <asp:LinkButton ID="bRequestKeyCancel" runat="server" OnClick="bCancel_Click" CssClass="btn btn-default" Text="Cancel" />
                            </div>
                            <div class="text-left">
                                <asp:Label ID="lactivateEdition" runat="server"></asp:Label>
                                <br />
                                <asp:Label ID="lSerialKey" Text="Edition:" runat="server"></asp:Label>
                                <asp:Panel ID="panelManualActivation" Visible="false" runat="server">
                                    <br />
                                    <br />
                                    <asp:LinkButton runat="server" ID="RequestActivation" CssClass="mbutton" OnClick="RequestActivation_Click"
                                        Text="Activate Online" />
                                </asp:Panel>
                            </div>
                        </asp:View>
                        <asp:View ID="viewApplyKey" runat="server">
                            <div class="text-center">
                                <asp:Label ID="Label2" runat="server" Style="font-weight: bold; margin-bottom: 5px; display: inline-block;" Text="Activation Key"></asp:Label>
                                <br />
                                <asp:TextBox ID="tbActivationKey" runat="server" Width="300px" CssClass="form-control"></asp:TextBox>
                                <br />
                                <br />
                                <br />
                                <asp:LinkButton ID="bApplyKeySubmit" runat="server" CssClass="btn btn-success" Text="Apply Activation Key" OnClick="bApplyKeySubmit_Click" />&nbsp;&nbsp;
                                <asp:LinkButton ID="bApplyKeyCancel" runat="server" CssClass="btn btn-default" Text="Cancel" OnClick="bCancel_Click" />
                            </div>
                        </asp:View>
                        <asp:View ID="viewAvailableEditions" runat="server">
                            <div class="text-center">
                                <asp:Label ID="Label3" runat="server" Style="font-weight: bold; margin-bottom: 5px; display: inline-block;" Text="Select Edition" />
                                <br />
                                <asp:DropDownList ID="ddlAvailableEditions" Width="180" CssClass="form-control" runat="server">
                                </asp:DropDownList>
                                <br />
                                <br />
                                <br />
                                <asp:LinkButton ID="bAvailableEditionsSubmit" runat="server" OnClick="bAvailableEditionsSubmit_Click" />&nbsp;&nbsp;
                                <asp:LinkButton ID="bAvailableEditionsCancel" runat="server" OnClick="bCancel_Click" />
                            </div>
                        </asp:View>
                    </asp:MultiView>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
