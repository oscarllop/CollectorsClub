<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="Mandeeps.DNN.Modules.PortoMegaMenu.View" %>
<%@ Register TagPrefix="dnn" TagName="TextEditor" Src="~/controls/TextEditor.ascx" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/Labelcontrol.ascx" %>
<div id="PortoMegaMenu" class="porto_mega_menu">
    <table width="100%" cellpadding="3" cellspacing="3" style="position: relative;">
        <tr>
            <td width="190">
                <dnn:Label Suffix=":" ID="lPages" runat="server" ResourceKey="lPages" />
            </td>
            <td>
                <asp:DropDownList ID="ddlPages" Style="width: 200px" runat="server" OnSelectedIndexChanged="ddlPages_SelectedIndexChanged"
                    AutoPostBack="true">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td>&nbsp;
            </td>
            <td>&nbsp;
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label Suffix=":" ID="lColor" runat="server" resourcekey="lColor"></asp:Label>
            </td>
            <td>
                <asp:DropDownList ID="ddlColor" Style="width: 200px" runat="server">
                    <asp:ListItem Text="Default" Value="0"></asp:ListItem>
                    <asp:ListItem Text="Primary" Value="1"></asp:ListItem>
                    <asp:ListItem Text="Secondary" Value="2"></asp:ListItem>
                    <asp:ListItem Text="Tertiary" Value="3"></asp:ListItem>
                    <asp:ListItem Text="Quaternary" Value="4"></asp:ListItem>
                    <asp:ListItem Text="Dark" Value="5"></asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td>&nbsp;
            </td>
            <td>&nbsp;
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label Suffix=":" ID="lMenuStyle" runat="server" resourcekey="lMenuStyle"></asp:Label></td>
            <td>
                <asp:DropDownList ID="ddlMenuStyle" Style="width: 200px" runat="server" CssClass="ddlMenuStyle">
                    <asp:ListItem Text="Regular Menu" Value="0"></asp:ListItem>
                    <asp:ListItem Text="Mega Menu" Value="1"></asp:ListItem>
                    <asp:ListItem Text="Custom Menu" Value="2"></asp:ListItem>
                </asp:DropDownList></td>
        </tr>

        <tr style="display: none;">
            <td>
                <dnn:Label Suffix=":" ID="lTitle" runat="server" ResourceKey="lTitle" />
            </td>
            <td>
                <asp:TextBox ID="tbTitle" Style="width: 200px;" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>&nbsp;
            </td>
            <td>&nbsp;
            </td>
        </tr>
        <tr class="row-slider">
            <td>
                <dnn:Label Suffix=":" ID="lColumns" runat="server" ResourceKey="lColumns" />
            </td>
            <td>
                <div class="slider" style="width: 200px">
                </div>
                <asp:TextBox ID="tbColumns" CssClass="value" Style="width: 50px; margin-top: 15px;"
                    runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr class="row-slider">
            <td>&nbsp;
            </td>
            <td>&nbsp;
            </td>
        </tr>
        <tr class="row-fullwidth">
            <td>
                <asp:Label Suffix=":" ID="lEnableFullWidth" runat="server" resourcekey="lEnableFullWidth"></asp:Label>
            </td>
            <td>
                <asp:CheckBox ID="cbEnableFullWidth" runat="server" />
            </td>
        </tr>
        <tr class="row-fullwidth">
            <td>&nbsp;
            </td>
            <td>&nbsp;
            </td>
        </tr>
        <tr class="row-wrapbuttons">
            <td></td>
            <td style="text-align: center" class="wrap-buttons">
                <asp:LinkButton ID="lbShowLeftContent" CssClass="addleftcont btn btn-default" runat="server"
                    resourcekey="lbleft"></asp:LinkButton>
                <asp:LinkButton ID="lbHideLeftContent" CssClass="removeleftcont btn btn-default"
                    runat="server" resourcekey="lbhideleft"></asp:LinkButton>
                <ul class="box_wrapper">
                    <li class="box-leftcont">
                        <asp:Label ID="LeftContent" runat="server" resourcekey="lContent"></asp:Label>
                    </li>
                    <li class="box1">
                        <asp:Label ID="lMenuItem1" runat="server" resourcekey="lMenuItem"></asp:Label>
                    </li>
                    <li class="box2">
                        <asp:Label ID="lMenuItem2" runat="server" resourcekey="lMenuItem"></asp:Label>
                    </li>
                    <li class="box3">
                        <asp:Label ID="lMenuItem3" runat="server" resourcekey="lMenuItem"></asp:Label>
                    </li>
                    <li class="box4">
                        <asp:Label ID="lMenuItem4" runat="server" resourcekey="lMenuItem"></asp:Label>
                    </li>
                    <li class="box-rightcont">
                        <asp:Label ID="RightContent" runat="server" resourcekey="rContent"></asp:Label>
                    </li>
                </ul>
                <asp:LinkButton ID="lbShowRightContent" CssClass="addrightcont btn btn-default" runat="server"
                    resourcekey="lbright"></asp:LinkButton>
                <asp:LinkButton ID="lbHideRightContent" CssClass="removerightcont btn btn-default"
                    runat="server" resourcekey="lbhideright"></asp:LinkButton>
            </td>
        </tr>
        <tr class="row-wrapbuttons">
            <td>&nbsp;
            </td>
            <td>&nbsp;
            </td>
        </tr>
        <tr class="row-addleftcont">
            <td>
                <dnn:Label Suffix=":" ID="lLeftContent" runat="server" ResourceKey="lblleft" />
            </td>
            <td>
                <dnn:TextEditor id="tbLeftContent" runat="server" width="100%" height="400">
                </dnn:TextEditor>
            </td>
        </tr>
        <tr class="row-addleftcont">
            <td>&nbsp;
            </td>
            <td>&nbsp;
            </td>
        </tr>
        <tr class="row-addrightcont">
            <td>
                <dnn:Label Suffix=":" ID="lRightContent" runat="server" ResourceKey="lblright" />
            </td>
            <td>
                <dnn:TextEditor id="tbRightContent" runat="server" width="100%" height="400">
                </dnn:TextEditor>
            </td>
        </tr>
        <tr class="row-addrightcont">
            <td>&nbsp;
            </td>
            <td>&nbsp;
            </td>
        </tr>
    </table>
    <asp:LinkButton ID="lbSave" runat="server" resourcekey="lbSave" CssClass="mbutton"
        OnClick="lbSave_Click"></asp:LinkButton>
    <div class="hf-left">
        <asp:HiddenField ID="hfLeftContent" runat="server" Value="0" />
    </div>
    <div class="hf-right">
        <asp:HiddenField ID="hfRightContent" runat="server" Value="0" />
    </div>
</div>
