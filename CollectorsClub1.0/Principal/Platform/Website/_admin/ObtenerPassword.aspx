<%@ Page Language="C#" AutoEventWireup="true" codefile="ObtenerPassword.aspx.cs" Inherits="CollectorsClub.Web._Admin.ObtenerPassword" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
			<p>
				Id Usuario GA:</p>
			<asp:textbox runat="server" id="txtIdUsuario"></asp:textbox>
			<asp:button id="btnObtenerPassword" runat="server" text="Obtener" onclick="btnObtenerPassword_Click" />
    </div>
			<div>
				<p>
					Id Usuario DNN:
				</p>
				<asp:textbox runat="server" id="txtIdUsuarioDNN"></asp:textbox>
			</div>
		</form>
</body>
</html>
