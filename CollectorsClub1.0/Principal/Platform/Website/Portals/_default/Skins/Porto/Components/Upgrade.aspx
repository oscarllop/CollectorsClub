<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Upgrade.aspx.cs" Inherits="Mandeeps.DNN.Skins.Porto.Upgrade" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Upgrade</title>
    <style>
        input.btn-primary {
            background-color: #0088cc;
        }

            input.btn-primary:hover {
                background-color: #0099e6;
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
                <h1>Thank you for upgrading to Porto 3</h1>
                <p>Porto will <strong>automatically upgrade</strong> your existing site and all themes created with its Style Switcher for compatibility with Porto 3 with following exceptions:</p>
                <div class="alert alert-danger">
                    <ul class="list list-icons" style="margin-left: 10px;">
                        <li><em class="fa fa-check"></em>Custom social icons and/or links must be updated in appropriate ascx files. Refer to documentation for instructions.</li>
                        <li><em class="fa fa-check"></em>Any manual customization or changes made to the theme files (ascx, css stylesheets and/or javascript).
                            <br />
                            For your convenience, a <strong>backup of current theme files</strong> will be available at <strong>/portals/_default/skins/porto/backup/v2/</strong> so you can manually copy your changes to the new files.</li>
                    </ul>
                </div>
                <asp:Literal id="litErrorMessage" runat="server"></asp:Literal>
                <asp:Button ID="btnUpgrade" runat="server" CssClass="btn btn-primary" Text="Upgrade" OnClick="btnUpgrade_Click" />
            </form>
        </div>
    </div>
</body>
</html>
