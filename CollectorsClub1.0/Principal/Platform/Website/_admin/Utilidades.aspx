<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Utilidades.aspx.cs" Inherits="Utilidades" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
			Cadena a codificar: <asp:TextBox ID="CadenaACodificar" runat="server" Columns="200" Rows="5" TextMode="MultiLine" /> <br />
			Cadena resultante: <asp:TextBox ID="CadenaResultante" runat="server" Columns="200" Rows="5" TextMode="MultiLine" /> <br />
			<asp:Button ID="Codificar" runat="server" Text="Codificar" OnClick="Codificar_Click" />
    </div> 
    </form>
</body>
</html>
