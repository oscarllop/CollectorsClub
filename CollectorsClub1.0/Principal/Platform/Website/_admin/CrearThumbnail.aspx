<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CrearThumbnail.aspx.cs" Inherits="CrearThumbnail" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title></title>
</head>
<body>
	<form id="form1" runat="server">
		<div>
			<%--<asp:ScriptManager ID="SM1" runat="server" AsyncPostBackErrorMessage="Error" />
			<asp:UpdatePanel runat="server">
				<ContentTemplate>--%>
			<div>
				<asp:Button ID="CrearThumbnailsEmpresas" runat="server" Text="Crear thumbnails empresas" OnClick="CrearThumbnailsEmpresas_Click" />
				<asp:TextBox ID="AnchoEmpresas" runat="server" AutoPostBack="true" Text="250" />
				<asp:TextBox ID="AltoEmpresas" runat="server" AutoPostBack="true" Text="500" />
			</div>
			<div>
				<asp:Button ID="CrearThumbnailsEntidadesColaboradoras" runat="server" Text="Crear thumbnails entidades colaboradoras" OnClick="CrearThumbnailsEntidadesColaboradoras_Click" />
				<asp:TextBox ID="AnchoEntidadesColaboradoras" runat="server" AutoPostBack="true" Text="250" />
				<asp:TextBox ID="AltoEntidadesColaboradoras" runat="server" AutoPostBack="true" Text="500" />
			</div>
			<div>
				<asp:Button ID="CrearThumbnailsFotos" runat="server" Text="Crear thumbnails fotos" OnClick="CrearThumbnailsFotos_Click" />
				<asp:TextBox ID="AnchoFotos" runat="server" AutoPostBack="true" Text="420" />
				<asp:TextBox ID="AltoFotos" runat="server" AutoPostBack="true" Text="600" />
			</div>
			<div>
				<asp:Button ID="CrearThumbnailsHoteles" runat="server" Text="Crear thumbnails hoteles" OnClick="CrearThumbnailsHoteles_Click" />
				<asp:TextBox ID="AnchoHoteles" runat="server" AutoPostBack="true" Text="150" />
				<asp:TextBox ID="AltoHoteles" runat="server" AutoPostBack="true" Text="300" />
			</div>
			<div>
				<asp:Button ID="CrearThumbnailsNoticias" runat="server" Text="Crear thumbnails noticias" OnClick="CrearThumbnailsNoticias_Click" />
				<asp:TextBox ID="AnchoNoticias" runat="server" AutoPostBack="true" Text="420" />
				<asp:TextBox ID="AltoNoticias" runat="server" AutoPostBack="true" Text="600" />
			</div>
			<div>
				<asp:Button ID="CrearThumbnailsPatrocinadores" runat="server" Text="Crear thumbnails patrocinadores" OnClick="CrearThumbnailsPatrocinadores_Click" />
				<asp:TextBox ID="AnchoPatrocinadores" runat="server" AutoPostBack="true" Text="250" />
				<asp:TextBox ID="AltoPatrocinadores" runat="server" AutoPostBack="true" Text="500" />
			</div>
			<div>
				<asp:Button ID="CrearThumbnailsPersonas" runat="server" Text="Crear thumbnails personas" OnClick="CrearThumbnailsPersonas_Click" />
				<asp:TextBox ID="AnchoPersonas" runat="server" AutoPostBack="true" Text="260" />
				<asp:TextBox ID="AltoPersonas" runat="server" AutoPostBack="true" Text="260" />
			</div>
			<div>
				<asp:Button ID="CrearThumbnailsSeminarios" runat="server" Text="Crear thumbnails seminarios" OnClick="CrearThumbnailsSeminarios_Click" />
				<asp:TextBox ID="AnchoSeminarios" runat="server" AutoPostBack="true" Text="900" />
				<asp:TextBox ID="AltoSeminarios" runat="server" AutoPostBack="true" Text="350" />
			</div>
			<div>
				<asp:Button ID="CrearThumbnailsTestimoniales" runat="server" Text="Crear thumbnails testimoniales" OnClick="CrearThumbnailsTestimoniales_Click" />
				<asp:TextBox ID="AnchoTestimoniales" runat="server" AutoPostBack="true" Text="260" />
				<asp:TextBox ID="AltoTestimoniales" runat="server" AutoPostBack="true" Text="260" />
			</div>

			<hr />
			<div>
				<asp:Button ID="Crear" runat="server" Text="Crear" OnClick="Crear_Click" />
			</div>
			<div>
				<asp:Label ID="Error" runat="server" Text="" />
			</div>
			<div>
				<asp:TextBox ID="RutaImagen" runat="server" OnTextChanged="RutaImagen_TextChanged" AutoPostBack="true" Style="width: 100%" />
			</div>
			<div>
				<asp:TextBox ID="Ancho" runat="server" AutoPostBack="true" Text="420" />
			</div>
			<div>
				<asp:TextBox ID="Alto" runat="server" AutoPostBack="true" Text="600" />
			</div>
			<div>
				<asp:Image ID="ImagenInicial" runat="server" />
			</div>
			<div>
				<asp:TextBox ID="RutaThumbnail1" runat="server" OnTextChanged="RutaThumbnail1_TextChanged" AutoPostBack="true" Style="width: 100%" />
			</div>
			<div>
				<asp:Image ID="ImagenThumbnail1" runat="server" />
			</div>
			<div>
				<asp:TextBox ID="RutaThumbnail2" runat="server" OnTextChanged="RutaThumbnail2_TextChanged" AutoPostBack="true" Style="width: 100%" />
			</div>
			<div>
				<asp:Image ID="ImagenThumbnail2" runat="server" />
			</div>
			<%--				</ContentTemplate>
			</asp:UpdatePanel>--%>
		</div>
	</form>
</body>
</html>
