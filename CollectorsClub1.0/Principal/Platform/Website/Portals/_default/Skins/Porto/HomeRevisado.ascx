<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="HomeRevisado.ascx.cs" Inherits="Mandeeps.DNN.Skins.Porto.Home" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.Client.ClientResourceManagement" Assembly="DotNetNuke.Web.Client" %>
<%@ Register TagPrefix="dnn" TagName="PRIVACY" Src="~/Admin/Skins/Privacy.ascx" %>
<%@ Register TagPrefix="dnn" TagName="TERMS" Src="~/Admin/Skins/Terms.ascx" %>
<%@ Register TagPrefix="dnn" TagName="COPYRIGHT" Src="~/Admin/Skins/Copyright.ascx" %>
<%@ Register TagPrefix="dnn" TagName="BREADCRUMB" Src="~/Admin/Skins/BreadCrumb.ascx" %>
<%@ Register TagPrefix="dnn" TagName="LANGUAGE" Src="~/Admin/Skins/Language.ascx" %>
<%@ Register TagPrefix="dnn" TagName="LOGO" Src="~/Admin/Skins/Logo.ascx" %>
<%@ Register TagPrefix="dnn" TagName="SEARCH" Src="~/Admin/Skins/Search.ascx" %>
<%@ Register TagPrefix="dnn" TagName="USER" Src="~/Admin/Skins/User.ascx" %>
<%@ Register TagPrefix="dnn" TagName="LOGIN" Src="~/Admin/Skins/Login.ascx" %>
<%@ Register TagPrefix="dnn" TagName="MENU" Src="~/DesktopModules/DDRMenu/Menu.ascx" %>
<%@ Register TagPrefix="ext" TagName="InformacionEdicion" Src="~/_extension/SkinObjects/InformacionEdicion.ascx" %>
<%@ Register TagPrefix="ext" TagName="BotetinReducido" Src="~/_extension/SkinObjects/BoletinReducido.ascx" %>
<%@ Register TagPrefix="ext" TagName="Siguenos" Src="~/_extension/SkinObjects/Siguenos.ascx" %>
<%@ Register TagPrefix="ext" TagName="Contactar" Src="~/_extension/SkinObjects/Contactar.ascx" %>
<%@ Register TagPrefix="ext" TagName="InformacionGeneral" Src="~/_extension/SkinObjects/InformacionGeneral.ascx" %>
<%@ Register TagPrefix="ext" TagName="AvisoLegal" Src="~/_extension/SkinObjects/AvisoLegal.ascx" %>
<%@ Register TagPrefix="ext" TagName="Privacidad" Src="~/_extension/SkinObjects/Privacidad.ascx" %>
<link href="//fonts.googleapis.com/css?family=Open+Sans:300,400,600,700,800%7CShadows+Into+Light" rel="stylesheet" type="text/css" />

<%-- AVISO COOKIES --%>
<div class="cookie_pc_wrapper" style="display: none;">
	<blockquote class="blockquote-primary">
		<p><%=DotNetNuke.Services.Localization.Localization.GetString("TextoMensaje", "~/App_GlobalResources/GlobalResourcesExtension.resx")%></p>
		<a id="accept-terms" href="#" class="primary">
			<%=DotNetNuke.Services.Localization.Localization.GetString("Aceptar", "~/App_GlobalResources/GlobalResourcesExtension.resx")%>
		</a>
	</blockquote>
</div>
<script type="text/javascript">
	function AceptarTerminos($) {
		if ($.cookie('accept-terms') != "true") { $(".cookie_pc_wrapper").fadeIn(); }
		$('#accept-terms').click(function (event) {
			event.preventDefault()

			$.cookie('accept-terms', 'true', { expires: 365 * 2, path: '/', domain: location.hostname });
			$(".cookie_pc_wrapper").fadeOut();
		})
	}
	if (typeof (define) === 'function' && define.amd) {
		//OLL: Esta línea es del anterior Skin, parece que solo necesito jquery y las cookies
		//require(['jquery', 'Skin/jquery.hoverIntent', 'Skin/jquery.easing', 'jquery.cookie', 'Skin/bootstrap-colorpicker.min', 'Skin/colorpicker', 'Skin/jquery.common', 'dojo/domReady!'], function ($, intent, easing, cookie, boostraspColorpicker, colorpicker, common, domReady) {
		require(['jquery', 'jquery.cookie'], function ($, cookie) {
			AceptarTerminos($);
		});
	} else {
		AceptarTerminos($);
	}
</script>
<%-- FIN AVISO COOKIES --%>

<!-- CollectorsClub Skin -->
<div class="body">
	<asp:PlaceHolder ID="phHeader1" Visible="true" runat="server">
		<header id="header">
			<div class="container">
				<%--				<h1 class="logo">
					<dnn:LOGO runat="server" ID="LOGO1" />
				</h1>--%>
				<div id="login">
					<dnn:USER ID="dnnUser" runat="server" LegacyMode="false" />
					<dnn:LOGIN ID="dnnLogin" CssClass="LoginLink" runat="server" LegacyMode="false" />
				</div>
				<button type="button" class="btn btn-responsive-nav btn-inverse" style="margin-top: 12px;" data-toggle="collapse" data-target=".nav-main-collapse">
					<em class="fa fa-bars"></em>
				</button>
				<div class="social-icons">
					<ul class="social-icons">
						<li class="behance"><a href="http://www.behance.com" target="_blank" title="Behance"></a></li>
						<li class="digg"><a href="https://www.digg.com" target="_blank" title="Digg"></a></li>
						<li class="dribbble"><a href="https://www.dribbble.com" target="_blank" title="Dribbble"></a></li>
						<li class="facebook active"><a href="https://www.facebook.com/pages/CollectorsClub/203877836315104/" target="_blank" title="Facebook"></a></li>
						<li class="flickr"><a href="https://www.flickr.com" target="_blank" title="Flickr"></a></li>
						<li class="forrst"><a href="https://www.forrest.com" target="_blank" title="Forrst"></a></li>
						<li class="foursquare"><a href="http://www.foursquare.com" target="_blank" title="Foursquare"></a></li>
						<li class="github"><a href="http://www.github.com" target="_blank" title="Github"></a></li>
						<li class="googleplus"><a href="https://www.googleplus.com" target="_blank" title="Googleplus"></a></li>
						<li class="html5"><a href="https://www.html5.com" target="_blank" title="HTML5"></a></li>
						<li class="icloud"><a href="https://www.icloud.com" target="_blank" title="Icloud"></a></li>
						<li class="instagram"><a href="http://www.instagram.com" target="_blank" title="Instagram"></a></li>
						<li class="lastfm"><a href="https://www.lastfm.com" target="_blank" title="Lastfm"></a></li>
						<li class="linkedin active"><a href="http://www.linkedin.com/pub/CollectorsClub/33/b77/980" target="_blank" title="Linkedin"></a></li>
						<li class="myspace"><a href="https://www.myspace.com" target="_blank" title="Myspace"></a></li>
						<li class="mail"><a href="http://www.mail.com" target="_blank" title="Mail"></a></li>
						<li class="paypal"><a href="http://www.paypal.com" target="_blank" title="Paypal"></a></li>
						<li class="picasa"><a href="http://www.picasa.com" target="_blank" title="Picasa"></a></li>
						<li class="pinterest"><a href="http://www.pinterest.com" target="_blank" title="Pinterest"></a></li>
						<li class="reddit"><a href="http://www.reddit.com" target="_blank" title="Reddit"></a></li>
						<li class="rss"><a href="http://www.rss.com" target="_blank" title="RSS"></a></li>
						<li class="skype"><a href="http://www.skype.com" target="_blank" title="Skype"></a></li>
						<li class="stumbleupon"><a href="http://www.stumbleupon.com" target="_blank" title="Stumbleupon"></a></li>
						<li class="tumblr"><a href="http://www.tumblr.com" target="_blank" title="Tumblr"></a></li>
						<li class="twitter active"><a href="https://twitter.com/#!/CollectorsClub" target="_blank" title="Twitter"></a></li>
						<li class="vimeo"><a href="http://www.vimeo.com" target="_blank" title="Vimeo"></a></li>
						<li class="vk"><a href="http://www.vk.com" target="_blank" title="Vk"></a></li>
						<li class="wordpress"><a href="http://www.wordpress.com" target="_blank" title="Wordpress"></a></li>
						<li class="yahoo"><a href="http://www.yahoo.com" target="_blank" title="Yahoo"></a></li>
						<li class="youtube"><a href="http://www.youtube.com" target="_blank" title="Youtube"></a></li>
						<li class="yelp"><a href="http://www.yelp.com" target="_blank" title="Yelp"></a></li>
						<li class="zerply"><a href="http://www.zerply.com" target="_blank" title="Zerply"></a></li>
					</ul>
				</div>
				<ext:InformacionEdicion ID="InformacionEdicion" runat="server" />
				<div class="search">
					<div class="input-group">
						<dnn:SEARCH ID="dnnSearch" runat="server" ShowSite="false" ShowWeb="false" EnableTheming="true"
							Submit="&nbsp;" CssClass="icon-search" />
					</div>
				</div>
			</div>
			<div class="navbar-collapse nav-main-collapse collapse">
				<div class="container">
				<div class="language CollectorsClub">
					<dnn:LANGUAGE runat="server" ID="dnnLANGUAGE" ShowMenu="False" ShowLinks="True" />
				</div>
					<dnn:MENU ID="MENU" MenuStyle="Resources/Menu" runat="server" NodeManipulator="Mandeeps.DNN.Modules.PortoMegaMenu.Components.NodeManipulator, Mandeeps.DNN.Modules.PortoMegaMenu" class="nav nav-pills nav-main">
					</dnn:MENU>
				</div>
			</div>
		</header>
	</asp:PlaceHolder>
	<asp:PlaceHolder ID="phHeader2" Visible="false" runat="server">
		<header id="header" class="flat-menu clean-top">
			<div class="header-top">
				<div class="container">
					<%--                    <div class="search">
                        <div class="input-group">
                            <dnn:SEARCH ID="Search1" runat="server" ShowSite="false" ShowWeb="false" EnableTheming="true"
                                Submit="&nbsp;" CssClass="icon-search" />
                        </div>
                    </div>--%>
					<div id="login">
						<dnn:USER ID="User1" runat="server" LegacyMode="false" />
						<dnn:LOGIN ID="Login1" CssClass="LoginLink" runat="server" LegacyMode="false" />
					</div>
					<div class="social-icons">
						<ul class="social-icons">
							<li class="behance"><a href="http://www.behance.com" target="_blank" title="Behance"></a></li>
							<li class="digg"><a href="https://www.digg.com" target="_blank" title="Digg"></a></li>
							<li class="dribbble"><a href="https://www.dribbble.com" target="_blank" title="Dribbble"></a></li>
							<li class="facebook active"><a href="http://www.facebook.com" target="_blank" title="Facebook"></a></li>
							<li class="flickr"><a href="https://www.flickr.com" target="_blank" title="Flickr"></a></li>
							<li class="forrst"><a href="https://www.forrest.com" target="_blank" title="Forrst"></a></li>
							<li class="foursquare"><a href="http://www.foursquare.com" target="_blank" title="Foursquare"></a></li>
							<li class="github"><a href="http://www.github.com" target="_blank" title="Github"></a></li>
							<li class="googleplus"><a href="https://www.googleplus.com" target="_blank" title="Googleplus"></a></li>
							<li class="html5"><a href="https://www.html5.com" target="_blank" title="HTML5"></a></li>
							<li class="icloud"><a href="https://www.icloud.com" target="_blank" title="Icloud"></a></li>
							<li class="instagram"><a href="http://www.instagram.com" target="_blank" title="Instagram"></a></li>
							<li class="lastfm"><a href="https://www.lastfm.com" target="_blank" title="Lastfm"></a></li>
							<li class="linkedin active"><a href="https://www.linkedin.com" target="_blank" title="Linkedin"></a></li>
							<li class="myspace"><a href="https://www.myspace.com" target="_blank" title="Myspace"></a></li>
							<li class="mail"><a href="http://www.mail.com" target="_blank" title="Mail"></a></li>
							<li class="paypal"><a href="http://www.paypal.com" target="_blank" title="Paypal"></a></li>
							<li class="picasa"><a href="http://www.picasa.com" target="_blank" title="Picasa"></a></li>
							<li class="pinterest"><a href="http://www.pinterest.com" target="_blank" title="Pinterest"></a></li>
							<li class="reddit"><a href="http://www.reddit.com" target="_blank" title="Reddit"></a></li>
							<li class="rss"><a href="http://www.rss.com" target="_blank" title="RSS"></a></li>
							<li class="skype"><a href="http://www.skype.com" target="_blank" title="Skype"></a></li>
							<li class="stumbleupon"><a href="http://www.stumbleupon.com" target="_blank" title="Stumbleupon"></a></li>
							<li class="tumblr"><a href="http://www.tumblr.com" target="_blank" title="Tumblr"></a></li>
							<li class="twitter active"><a href="http://www.twitter.com" target="_blank" title="Twitter"></a></li>
							<li class="vimeo"><a href="http://www.vimeo.com" target="_blank" title="Vimeo"></a></li>
							<li class="vk"><a href="http://www.vk.com" target="_blank" title="Vk"></a></li>
							<li class="wordpress"><a href="http://www.wordpress.com" target="_blank" title="Wordpress"></a></li>
							<li class="yahoo"><a href="http://www.yahoo.com" target="_blank" title="Yahoo"></a></li>
							<li class="youtube"><a href="http://www.youtube.com" target="_blank" title="Youtube"></a></li>
							<li class="yelp"><a href="http://www.yelp.com" target="_blank" title="Yelp"></a></li>
							<li class="zerply"><a href="http://www.zerply.com" target="_blank" title="Zerply"></a></li>
						</ul>
					</div>
					<div class="language">
						<dnn:LANGUAGE runat="server" ID="Language1" ShowMenu="False" ShowLinks="True" />
					</div>
				</div>
			</div>
			<div class="container">
				<h1 class="logo">
					<dnn:LOGO runat="server" ID="LOGO2" />
				</h1>
				<button type="button" onclick="return false" class="btn btn-responsive-nav btn-inverse" data-toggle="collapse"
					data-target=".nav-main-collapse">
					<em class="fa fa-bars"></em>
				</button>
			</div>
			<div class="navbar-collapse nav-main-collapse collapse">
				<div class="container">
					<dnn:MENU ID="MENU1" MenuStyle="Resources/Menu" runat="server" NodeManipulator="Mandeeps.DNN.Modules.PortoMegaMenu.Components.NodeManipulator, Mandeeps.DNN.Modules.PortoMegaMenu"
						class="nav nav-pills nav-main">
					</dnn:MENU>
				</div>
			</div>
		</header>
	</asp:PlaceHolder>
	<asp:PlaceHolder ID="phHeader3" Visible="false" runat="server">
		<header id="header" class="colored flat-menu">
			<div class="header-top">
				<div class="container">
					<div class="social-icons">
						<ul class="social-icons">
							<li class="behance"><a href="http://www.behance.com" target="_blank" title="Behance"></a></li>
							<li class="digg"><a href="https://www.digg.com" target="_blank" title="Digg"></a></li>
							<li class="dribbble"><a href="https://www.dribbble.com" target="_blank" title="Dribbble"></a></li>
							<li class="facebook active"><a href="http://www.facebook.com" target="_blank" title="Facebook"></a></li>
							<li class="flickr"><a href="https://www.flickr.com" target="_blank" title="Flickr"></a></li>
							<li class="forrst"><a href="https://www.forrest.com" target="_blank" title="Forrst"></a></li>
							<li class="foursquare"><a href="http://www.foursquare.com" target="_blank" title="Foursquare"></a></li>
							<li class="github"><a href="http://www.github.com" target="_blank" title="Github"></a></li>
							<li class="googleplus"><a href="https://www.googleplus.com" target="_blank" title="Googleplus"></a></li>
							<li class="html5"><a href="https://www.html5.com" target="_blank" title="HTML5"></a></li>
							<li class="icloud"><a href="https://www.icloud.com" target="_blank" title="Icloud"></a></li>
							<li class="instagram"><a href="http://www.instagram.com" target="_blank" title="Instagram"></a></li>
							<li class="lastfm"><a href="https://www.lastfm.com" target="_blank" title="Lastfm"></a></li>
							<li class="linkedin active"><a href="https://www.linkedin.com" target="_blank" title="Linkedin"></a></li>
							<li class="myspace"><a href="https://www.myspace.com" target="_blank" title="Myspace"></a></li>
							<li class="mail"><a href="http://www.mail.com" target="_blank" title="Mail"></a></li>
							<li class="paypal"><a href="http://www.paypal.com" target="_blank" title="Paypal"></a></li>
							<li class="picasa"><a href="http://www.picasa.com" target="_blank" title="Picasa"></a></li>
							<li class="pinterest"><a href="http://www.pinterest.com" target="_blank" title="Pinterest"></a></li>
							<li class="reddit"><a href="http://www.reddit.com" target="_blank" title="Reddit"></a></li>
							<li class="rss"><a href="http://www.rss.com" target="_blank" title="RSS"></a></li>
							<li class="skype"><a href="http://www.skype.com" target="_blank" title="Skype"></a></li>
							<li class="stumbleupon"><a href="http://www.stumbleupon.com" target="_blank" title="Stumbleupon"></a></li>
							<li class="tumblr"><a href="http://www.tumblr.com" target="_blank" title="Tumblr"></a></li>
							<li class="twitter active"><a href="http://www.twitter.com" target="_blank" title="Twitter"></a></li>
							<li class="vimeo"><a href="http://www.vimeo.com" target="_blank" title="Vimeo"></a></li>
							<li class="vk"><a href="http://www.vk.com" target="_blank" title="Vk"></a></li>
							<li class="wordpress"><a href="http://www.wordpress.com" target="_blank" title="Wordpress"></a></li>
							<li class="yahoo"><a href="http://www.yahoo.com" target="_blank" title="Yahoo"></a></li>
							<li class="youtube"><a href="http://www.youtube.com" target="_blank" title="Youtube"></a></li>
							<li class="yelp"><a href="http://www.yelp.com" target="_blank" title="Yelp"></a></li>
							<li class="zerply"><a href="http://www.zerply.com" target="_blank" title="Zerply"></a></li>
						</ul>
					</div>
					<%--                    <div class="search">
                        <div class="control-group">
                            <dnn:SEARCH ID="Search2" runat="server" ShowSite="false" ShowWeb="false" EnableTheming="true"
                                Submit="&nbsp;" CssClass="icon-search" />
                        </div>
                    </div>--%>
					<div id="login">
						<dnn:USER ID="User2" runat="server" LegacyMode="false" />
						<dnn:LOGIN ID="Login2" CssClass="LoginLink" runat="server" LegacyMode="false" />
					</div>
					<div class="language">
						<dnn:LANGUAGE runat="server" ID="Language2" ShowMenu="False" ShowLinks="True" />
					</div>
				</div>
			</div>
			<div class="container">
				<h1 class="logo">
					<dnn:LOGO runat="server" ID="LOGO3" />
				</h1>
				<button type="button" class="btn btn-responsive-nav btn-inverse" data-toggle="collapse" data-target=".nav-main-collapse">
					<em class="fa fa-bars"></em>
				</button>
			</div>
			<div class="navbar-collapse nav-main-collapse collapse">
				<div class="container">
					<dnn:MENU ID="MENU2" MenuStyle="Resources/Menu" runat="server" NodeManipulator="Mandeeps.DNN.Modules.PortoMegaMenu.Components.NodeManipulator, Mandeeps.DNN.Modules.PortoMegaMenu" class="nav nav-pills nav-main">
					</dnn:MENU>
				</div>
			</div>
		</header>
	</asp:PlaceHolder>
	<asp:PlaceHolder ID="phHeader4" Visible="false" runat="server">
		<header id="header" class="colored flat-menu darken-top-border">
			<div class="header-top">
				<div class="container">
					<div class="social-icons">
						<ul class="social-icons">
							<li class="behance"><a href="http://www.behance.com" target="_blank" title="Behance"></a></li>
							<li class="digg"><a href="https://www.digg.com" target="_blank" title="Digg"></a></li>
							<li class="dribbble"><a href="https://www.dribbble.com" target="_blank" title="Dribbble"></a></li>
							<li class="facebook active"><a href="http://www.facebook.com" target="_blank" title="Facebook"></a></li>
							<li class="flickr"><a href="https://www.flickr.com" target="_blank" title="Flickr"></a></li>
							<li class="forrst"><a href="https://www.forrest.com" target="_blank" title="Forrst"></a></li>
							<li class="foursquare"><a href="http://www.foursquare.com" target="_blank" title="Foursquare"></a></li>
							<li class="github"><a href="http://www.github.com" target="_blank" title="Github"></a></li>
							<li class="googleplus"><a href="https://www.googleplus.com" target="_blank" title="Googleplus"></a></li>
							<li class="html5"><a href="https://www.html5.com" target="_blank" title="HTML5"></a></li>
							<li class="icloud"><a href="https://www.icloud.com" target="_blank" title="Icloud"></a></li>
							<li class="instagram"><a href="http://www.instagram.com" target="_blank" title="Instagram"></a></li>
							<li class="lastfm"><a href="https://www.lastfm.com" target="_blank" title="Lastfm"></a></li>
							<li class="linkedin active"><a href="https://www.linkedin.com" target="_blank" title="Linkedin"></a></li>
							<li class="myspace"><a href="https://www.myspace.com" target="_blank" title="Myspace"></a></li>
							<li class="mail"><a href="http://www.mail.com" target="_blank" title="Mail"></a></li>
							<li class="paypal"><a href="http://www.paypal.com" target="_blank" title="Paypal"></a></li>
							<li class="picasa"><a href="http://www.picasa.com" target="_blank" title="Picasa"></a></li>
							<li class="pinterest"><a href="http://www.pinterest.com" target="_blank" title="Pinterest"></a></li>
							<li class="reddit"><a href="http://www.reddit.com" target="_blank" title="Reddit"></a></li>
							<li class="rss"><a href="http://www.rss.com" target="_blank" title="RSS"></a></li>
							<li class="skype"><a href="http://www.skype.com" target="_blank" title="Skype"></a></li>
							<li class="stumbleupon"><a href="http://www.stumbleupon.com" target="_blank" title="Stumbleupon"></a></li>
							<li class="tumblr"><a href="http://www.tumblr.com" target="_blank" title="Tumblr"></a></li>
							<li class="twitter active"><a href="http://www.twitter.com" target="_blank" title="Twitter"></a></li>
							<li class="vimeo"><a href="http://www.vimeo.com" target="_blank" title="Vimeo"></a></li>
							<li class="vk"><a href="http://www.vk.com" target="_blank" title="Vk"></a></li>
							<li class="wordpress"><a href="http://www.wordpress.com" target="_blank" title="Wordpress"></a></li>
							<li class="yahoo"><a href="http://www.yahoo.com" target="_blank" title="Yahoo"></a></li>
							<li class="youtube"><a href="http://www.youtube.com" target="_blank" title="Youtube"></a></li>
							<li class="yelp"><a href="http://www.yelp.com" target="_blank" title="Yelp"></a></li>
							<li class="zerply"><a href="http://www.zerply.com" target="_blank" title="Zerply"></a></li>
						</ul>
					</div>
					<div id="login">
						<dnn:USER ID="User3" runat="server" LegacyMode="false" />
						<dnn:LOGIN ID="Login3" CssClass="LoginLink" runat="server" LegacyMode="false" />
					</div>
					<div class="language">
						<dnn:LANGUAGE runat="server" ID="Language3" ShowMenu="False" ShowLinks="True" />
					</div>
				</div>
			</div>
			<div class="container">
				<h1 class="logo">
					<dnn:LOGO runat="server" ID="LOGO4" />
				</h1>
				<button type="button" class="btn btn-responsive-nav btn-inverse" data-toggle="collapse" data-target=".nav-main-collapse">
					<em class="fa fa-bars"></em>
				</button>
			</div>
			<div class="navbar-collapse nav-main-collapse collapse">
				<div class="container">
					<dnn:MENU ID="MENU3" MenuStyle="Resources/Menu" runat="server" NodeManipulator="Mandeeps.DNN.Modules.PortoMegaMenu.Components.NodeManipulator, Mandeeps.DNN.Modules.PortoMegaMenu" class="nav nav-pills nav-main">
					</dnn:MENU>
				</div>
			</div>
		</header>
	</asp:PlaceHolder>
	<asp:PlaceHolder ID="phHeader5" Visible="false" runat="server">
		<header id="header" class="clean-top center">
			<div class="header-top">
				<div class="container">
					<div class="social-icons">
						<ul class="social-icons">
							<li class="behance"><a href="http://www.behance.com" target="_blank" title="Behance"></a></li>
							<li class="digg"><a href="https://www.digg.com" target="_blank" title="Digg"></a></li>
							<li class="dribbble"><a href="https://www.dribbble.com" target="_blank" title="Dribbble"></a></li>
							<li class="facebook active"><a href="http://www.facebook.com" target="_blank" title="Facebook"></a></li>
							<li class="flickr"><a href="https://www.flickr.com" target="_blank" title="Flickr"></a></li>
							<li class="forrst"><a href="https://www.forrest.com" target="_blank" title="Forrst"></a></li>
							<li class="foursquare"><a href="http://www.foursquare.com" target="_blank" title="Foursquare"></a></li>
							<li class="github"><a href="http://www.github.com" target="_blank" title="Github"></a></li>
							<li class="googleplus"><a href="https://www.googleplus.com" target="_blank" title="Googleplus"></a></li>
							<li class="html5"><a href="https://www.html5.com" target="_blank" title="HTML5"></a></li>
							<li class="icloud"><a href="https://www.icloud.com" target="_blank" title="Icloud"></a></li>
							<li class="instagram"><a href="http://www.instagram.com" target="_blank" title="Instagram"></a></li>
							<li class="lastfm"><a href="https://www.lastfm.com" target="_blank" title="Lastfm"></a></li>
							<li class="linkedin active"><a href="https://www.linkedin.com" target="_blank" title="Linkedin"></a></li>
							<li class="myspace"><a href="https://www.myspace.com" target="_blank" title="Myspace"></a></li>
							<li class="mail"><a href="http://www.mail.com" target="_blank" title="Mail"></a></li>
							<li class="paypal"><a href="http://www.paypal.com" target="_blank" title="Paypal"></a></li>
							<li class="picasa"><a href="http://www.picasa.com" target="_blank" title="Picasa"></a></li>
							<li class="pinterest"><a href="http://www.pinterest.com" target="_blank" title="Pinterest"></a></li>
							<li class="reddit"><a href="http://www.reddit.com" target="_blank" title="Reddit"></a></li>
							<li class="rss"><a href="http://www.rss.com" target="_blank" title="RSS"></a></li>
							<li class="skype"><a href="http://www.skype.com" target="_blank" title="Skype"></a></li>
							<li class="stumbleupon"><a href="http://www.stumbleupon.com" target="_blank" title="Stumbleupon"></a></li>
							<li class="tumblr"><a href="http://www.tumblr.com" target="_blank" title="Tumblr"></a></li>
							<li class="twitter active"><a href="http://www.twitter.com" target="_blank" title="Twitter"></a></li>
							<li class="vimeo"><a href="http://www.vimeo.com" target="_blank" title="Vimeo"></a></li>
							<li class="vk"><a href="http://www.vk.com" target="_blank" title="Vk"></a></li>
							<li class="wordpress"><a href="http://www.wordpress.com" target="_blank" title="Wordpress"></a></li>
							<li class="yahoo"><a href="http://www.yahoo.com" target="_blank" title="Yahoo"></a></li>
							<li class="youtube"><a href="http://www.youtube.com" target="_blank" title="Youtube"></a></li>
							<li class="yelp"><a href="http://www.yelp.com" target="_blank" title="Yelp"></a></li>
							<li class="zerply"><a href="http://www.zerply.com" target="_blank" title="Zerply"></a></li>
						</ul>
					</div>
					<%--                    <div class="search">
                        <div class="control-group">
                            <dnn:SEARCH ID="Search3" runat="server" ShowSite="false" ShowWeb="false" EnableTheming="true"
                                Submit="&nbsp;" CssClass="icon-search" />
                        </div>
                    </div>--%>
					<div id="login">
						<dnn:USER ID="User4" runat="server" LegacyMode="false" />
						<dnn:LOGIN ID="Login4" CssClass="LoginLink" runat="server" LegacyMode="false" />
					</div>
					<div class="language">
						<dnn:LANGUAGE runat="server" ID="Language4" ShowMenu="False" ShowLinks="True" />
					</div>
				</div>
			</div>
			<div class="container">
				<h1 class="logo">
					<dnn:LOGO runat="server" ID="LOGO5" />
				</h1>
				<button type="button" class="btn btn-responsive-nav btn-inverse" data-toggle="collapse" data-target=".nav-main-collapse">
					<em class="fa fa-bars"></em>
				</button>
			</div>
			<div class="navbar-collapse nav-main-collapse collapse">
				<div class="container">
					<dnn:MENU ID="MENU4" MenuStyle="Resources/Menu" runat="server" NodeManipulator="Mandeeps.DNN.Modules.PortoMegaMenu.Components.NodeManipulator, Mandeeps.DNN.Modules.PortoMegaMenu" class="nav nav-pills nav-main">
					</dnn:MENU>
				</div>
			</div>
		</header>
	</asp:PlaceHolder>
	<asp:PlaceHolder ID="phHeader6" Visible="false" runat="server">
		<header id="header" class="nav-bar no-border-top" data-plugin-options="{'stickyEnabled': true, 'stickyForceHeaderTop': '-161px'}">
			<div class="header-top header-top-style-2">
				<div class="container">
					<div class="social-icons">
						<ul class="social-icons">
							<li class="behance"><a href="http://www.behance.com" target="_blank" title="Behance"></a></li>
							<li class="digg"><a href="https://www.digg.com" target="_blank" title="Digg"></a></li>
							<li class="dribbble"><a href="https://www.dribbble.com" target="_blank" title="Dribbble"></a></li>
							<li class="facebook active"><a href="http://www.facebook.com" target="_blank" title="Facebook"></a></li>
							<li class="flickr"><a href="https://www.flickr.com" target="_blank" title="Flickr"></a></li>
							<li class="forrst"><a href="https://www.forrest.com" target="_blank" title="Forrst"></a></li>
							<li class="foursquare"><a href="http://www.foursquare.com" target="_blank" title="Foursquare"></a></li>
							<li class="github"><a href="http://www.github.com" target="_blank" title="Github"></a></li>
							<li class="googleplus"><a href="https://www.googleplus.com" target="_blank" title="Googleplus"></a></li>
							<li class="html5"><a href="https://www.html5.com" target="_blank" title="HTML5"></a></li>
							<li class="icloud"><a href="https://www.icloud.com" target="_blank" title="Icloud"></a></li>
							<li class="instagram"><a href="http://www.instagram.com" target="_blank" title="Instagram"></a></li>
							<li class="lastfm"><a href="https://www.lastfm.com" target="_blank" title="Lastfm"></a></li>
							<li class="linkedin active"><a href="https://www.linkedin.com" target="_blank" title="Linkedin"></a></li>
							<li class="myspace"><a href="https://www.myspace.com" target="_blank" title="Myspace"></a></li>
							<li class="mail"><a href="http://www.mail.com" target="_blank" title="Mail"></a></li>
							<li class="paypal"><a href="http://www.paypal.com" target="_blank" title="Paypal"></a></li>
							<li class="picasa"><a href="http://www.picasa.com" target="_blank" title="Picasa"></a></li>
							<li class="pinterest"><a href="http://www.pinterest.com" target="_blank" title="Pinterest"></a></li>
							<li class="reddit"><a href="http://www.reddit.com" target="_blank" title="Reddit"></a></li>
							<li class="rss"><a href="http://www.rss.com" target="_blank" title="RSS"></a></li>
							<li class="skype"><a href="http://www.skype.com" target="_blank" title="Skype"></a></li>
							<li class="stumbleupon"><a href="http://www.stumbleupon.com" target="_blank" title="Stumbleupon"></a></li>
							<li class="tumblr"><a href="http://www.tumblr.com" target="_blank" title="Tumblr"></a></li>
							<li class="twitter active"><a href="http://www.twitter.com" target="_blank" title="Twitter"></a></li>
							<li class="vimeo"><a href="http://www.vimeo.com" target="_blank" title="Vimeo"></a></li>
							<li class="vk"><a href="http://www.vk.com" target="_blank" title="Vk"></a></li>
							<li class="wordpress"><a href="http://www.wordpress.com" target="_blank" title="Wordpress"></a></li>
							<li class="yahoo"><a href="http://www.yahoo.com" target="_blank" title="Yahoo"></a></li>
							<li class="youtube"><a href="http://www.youtube.com" target="_blank" title="Youtube"></a></li>
							<li class="yelp"><a href="http://www.yelp.com" target="_blank" title="Yelp"></a></li>
							<li class="zerply"><a href="http://www.zerply.com" target="_blank" title="Zerply"></a></li>
						</ul>
					</div>
					<%--                    <div class="search">
                        <div class="control-group">
                            <dnn:SEARCH ID="Search4" runat="server" ShowSite="false" ShowWeb="false" EnableTheming="true"
                                Submit="&nbsp;" CssClass="icon-search" />
                        </div>
                    </div>--%>
					<div id="login">
						<dnn:USER ID="User5" runat="server" LegacyMode="false" />
						<dnn:LOGIN ID="Login5" CssClass="LoginLink" runat="server" LegacyMode="false" />
					</div>
					<div class="language">
						<dnn:LANGUAGE runat="server" ID="Language5" ShowMenu="False" ShowLinks="True" />
					</div>
				</div>
			</div>
			<div class="container">
				<h1 class="logo">
					<dnn:LOGO runat="server" ID="LOGO6" />
				</h1>
				<button type="button" class="btn btn-responsive-nav btn-inverse" data-toggle="collapse" data-target=".nav-main-collapse">
					<em class="fa fa-bars"></em>
				</button>
			</div>
			<div class="nav-bar-primary navbar-collapse nav-main-collapse collapse">
				<div class="container">
					<dnn:MENU ID="MENU5" MenuStyle="Resources/Menu" runat="server" NodeManipulator="Mandeeps.DNN.Modules.PortoMegaMenu.Components.NodeManipulator, Mandeeps.DNN.Modules.PortoMegaMenu" class="nav nav-pills nav-main">
					</dnn:MENU>
				</div>
			</div>
		</header>
	</asp:PlaceHolder>
	<asp:PlaceHolder ID="phHeader7" Visible="false" runat="server">
		<header id="header" class="newHeader">
			<div class="container">
				<h1 class="logo">
					<dnn:LOGO runat="server" ID="LOGO7" />
				</h1>
				<%--            <div class="search">
                <div class="input-group">
                    <dnn:SEARCH ID="SEARCH5" runat="server" ShowSite="false" ShowWeb="false" EnableTheming="true"
                                Submit="&nbsp;" CssClass="icon-search" />
                </div>
            </div>--%>
				<div id="login">
					<dnn:USER ID="USER6" runat="server" LegacyMode="false" />
					<dnn:LOGIN ID="LOGIN6" CssClass="LoginLink" runat="server" LegacyMode="false" />
				</div>

				<div class="language">
					<dnn:LANGUAGE runat="server" ID="LANGUAGE6" ShowMenu="False" ShowLinks="True" />
				</div>
				<button type="button" class="btn btn-responsive-nav btn-inverse" style="margin-top: 12px;" data-toggle="collapse" data-target=".nav-main-collapse">
					<em class="fa fa-bars"></em>
				</button>
			</div>
			<div class="navbar-collapse nav-main-collapse collapse">
				<div class="container">
					<div class="social-icons">
						<ul class="social-icons">
							<li class="behance"><a href="http://www.behance.com" target="_blank" title="Behance"></a></li>
							<li class="digg"><a href="https://www.digg.com" target="_blank" title="Digg"></a></li>
							<li class="dribbble"><a href="https://www.dribbble.com" target="_blank" title="Dribbble"></a></li>
							<li class="facebook active"><a href="http://www.facebook.com" target="_blank" title="Facebook"></a></li>
							<li class="flickr"><a href="https://www.flickr.com" target="_blank" title="Flickr"></a></li>
							<li class="forrst"><a href="https://www.forrest.com" target="_blank" title="Forrst"></a></li>
							<li class="foursquare"><a href="http://www.foursquare.com" target="_blank" title="Foursquare"></a></li>
							<li class="github"><a href="http://www.github.com" target="_blank" title="Github"></a></li>
							<li class="googleplus"><a href="https://www.googleplus.com" target="_blank" title="Googleplus"></a></li>
							<li class="html5"><a href="https://www.html5.com" target="_blank" title="HTML5"></a></li>
							<li class="icloud"><a href="https://www.icloud.com" target="_blank" title="Icloud"></a></li>
							<li class="instagram"><a href="http://www.instagram.com" target="_blank" title="Instagram"></a></li>
							<li class="lastfm"><a href="https://www.lastfm.com" target="_blank" title="Lastfm"></a></li>
							<li class="linkedin active"><a href="https://www.linkedin.com" target="_blank" title="Linkedin"></a></li>
							<li class="myspace"><a href="https://www.myspace.com" target="_blank" title="Myspace"></a></li>
							<li class="mail"><a href="http://www.mail.com" target="_blank" title="Mail"></a></li>
							<li class="paypal"><a href="http://www.paypal.com" target="_blank" title="Paypal"></a></li>
							<li class="picasa"><a href="http://www.picasa.com" target="_blank" title="Picasa"></a></li>
							<li class="pinterest"><a href="http://www.pinterest.com" target="_blank" title="Pinterest"></a></li>
							<li class="reddit"><a href="http://www.reddit.com" target="_blank" title="Reddit"></a></li>
							<li class="rss"><a href="http://www.rss.com" target="_blank" title="RSS"></a></li>
							<li class="skype"><a href="http://www.skype.com" target="_blank" title="Skype"></a></li>
							<li class="stumbleupon"><a href="http://www.stumbleupon.com" target="_blank" title="Stumbleupon"></a></li>
							<li class="tumblr"><a href="http://www.tumblr.com" target="_blank" title="Tumblr"></a></li>
							<li class="twitter active"><a href="http://www.twitter.com" target="_blank" title="Twitter"></a></li>
							<li class="vimeo"><a href="http://www.vimeo.com" target="_blank" title="Vimeo"></a></li>
							<li class="vk"><a href="http://www.vk.com" target="_blank" title="Vk"></a></li>
							<li class="wordpress"><a href="http://www.wordpress.com" target="_blank" title="Wordpress"></a></li>
							<li class="yahoo"><a href="http://www.yahoo.com" target="_blank" title="Yahoo"></a></li>
							<li class="youtube"><a href="http://www.youtube.com" target="_blank" title="Youtube"></a></li>
							<li class="yelp"><a href="http://www.yelp.com" target="_blank" title="Yelp"></a></li>
							<li class="zerply"><a href="http://www.zerply.com" target="_blank" title="Zerply"></a></li>
						</ul>
					</div>
					<dnn:MENU ID="MENU6" MenuStyle="Resources/Menu" runat="server" NodeManipulator="Mandeeps.DNN.Modules.PortoMegaMenu.Components.NodeManipulator, Mandeeps.DNN.Modules.PortoMegaMenu" class="nav nav-pills nav-main"></dnn:MENU>
				</div>
			</div>
		</header>
	</asp:PlaceHolder>
	<div role="main" class="main">
		<asp:PlaceHolder ID="pcBreadcrumb" runat="server" Visible="false">
			<section class="page-top basic">
				<div class="page-top-info container">
					<div class="row">
						<div class="col-md-12">
							<ul class="breadcrumb">
								<li>
									<dnn:BREADCRUMB ID="dnnBreadcrumb" runat="server" CssClass=" " RootLevel="0" Separator=" / " />
								</li>
							</ul>
						</div>
					</div>
					<div class="row">
						<div class="col-md-12">
							<h1><%= Server.HtmlEncode(PortalSettings.ActiveTab.TabName) %></h1>
						</div>
					</div>
				</div>
			</section>
		</asp:PlaceHolder>

		<div class="content full">
			<div id="TopUpperPaneFull" runat="server">
			</div>
			<div class="container">
				<div class="row">
					<div class="col-md-12">
						<div id="TopPane" runat="server">
						</div>
					</div>
				</div>
			</div>
			<div id="TopLowerPaneFull" runat="server">
			</div>
			<div class="container">
				<div class="row">
					<div class="col-md-12">
						<div id="GruposIconosSuperiorPane" runat="server">
						</div>
					</div>
				</div>
			</div>
			<div class="destacada">
				<div class="container">
					<div class="row">
						<div class="col-md-3">
							<div id="DestacadaLeftPane" runat="server">
							</div>
						</div>
						<div class="col-md-9">
							<div id="DestacadaRightPane" runat="server">
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="container">
				<div class="row">
					<div class="col-md-3">
						<div id="TopLeftOuter" runat="server">
						</div>
					</div>
					<div class="col-md-3">
						<div id="TopLeftInner" runat="server">
						</div>
					</div>
					<div class="col-md-3">
						<div id="TopRightInner" runat="server">
						</div>
					</div>
					<div class="col-md-3">
						<div id="TopRightOuter" runat="server">
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-4">
						<div id="TopLeftPane" runat="server">
						</div>
					</div>
					<div class="col-md-4">
						<div id="TopMiddlePane" runat="server">
						</div>
					</div>
					<div class="col-md-4">
						<div id="TopRightPane" runat="server">
						</div>
					</div>
				</div>
			</div>
			<div class="container">
				<div class="row">
					<div class="col-md-3">
						<div id="TopLeftSidebar" runat="server">
						</div>
					</div>
					<div class="col-md-9">
						<div id="TopLeftSidebarOuter" runat="server">
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-9">
						<div id="TopRightSidebarOuter" runat="server">
						</div>
					</div>
					<div class="col-md-3">
						<div id="TopRightSidebar" runat="server">
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-4">
						<div id="LeftSidebar" runat="server">
						</div>
					</div>
					<div class="col-md-8">
						<div id="LeftSidebarOuter" runat="server">
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-8">
						<div id="RightSidebarOuter" runat="server">
						</div>
					</div>
					<div class="col-md-4">
						<div id="RightSidebar" runat="server">
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-6">
						<div id="LeftPane" runat="server">
						</div>
					</div>
					<div class="col-md-6">
						<div id="RightPane" runat="server">
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<div id="contentPane" runat="server">
						</div>
					</div>
				</div>
				<div class="row">
					<div id="ContentLowerPane" runat="server">
					</div>
				</div>
				<div class="row">
					<div class="col-md-3">
						<div id="LowerContentLeftSidebarPane" runat="server">
						</div>
					</div>
					<div class="col-md-9">
						<div id="LowerContentRightSidebarPane" runat="server">
						</div>
					</div>
				</div>
			</div>
			<div class="container">
				<div class="row">
					<div class="col-md-12">
						<div id="GruposIconosInferiorPane" runat="server">
						</div>
					</div>
				</div>
			</div>
			<div id="BottomPaneFull" runat="server">
			</div>
		</div>
	</div>
	<footer id="footer">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<div id="FooterTop" runat="server">
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-6">
					<div id="FooterLeft" runat="server">
					</div>
				</div>
				<div class="col-md-6">
					<div id="FooterRight" runat="server">
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-4">
					<div id="FooterLeftPane" runat="server">
					</div>
				</div>
				<div class="col-md-4">
					<div id="FooterMiddlePane" runat="server">
					</div>
				</div>
				<div class="col-md-4">
					<div id="FooterRightPane" runat="server">
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-3">
					<div id="FooterLeftOuter" runat="server">
					</div>
				</div>
				<div class="col-md-3">
					<div id="FooterLeftInner" runat="server">
					</div>
				</div>
				<div class="col-md-3">
					<div id="FooterRightInner" runat="server">
					</div>
				</div>
				<div class="col-md-3">
					<div id="FooterRightOuter" runat="server">
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-3">
					<div id="GreyFooterLeftOuter" runat="server">
					</div>
					<ext:BotetinReducido ID="BotetinReducido" runat="server" />
				</div>
				<div class="col-md-3">
					<div id="GreyFooterLeftInner" runat="server">
					</div>
				</div>
				<div class="col-md-3">
					<div id="GreyFooterRightInner" runat="server">
					</div>
				</div>
				<div class="col-md-3">
					<ext:Siguenos ID="Siguenos" runat="server" />
				</div>
			</div>
			<div class="row">
				<div class="col-md-12">
					<div id="FooterBottom" runat="server">
					</div>
				</div>
			</div>
		</div>
		<div class="footer-copyright">
			<div class="container">
				<div class="row">
					<div class="col-md-12">
						<span class="copyright">&copy;</span>
						<dnn:COPYRIGHT ID="dnnCopyright" CssClass="copyright" runat="server" />
						<%--						<dnn:TERMS ID="dnnTerms" CssClass="terms" runat="server" />
						<dnn:PRIVACY ID="dnnPrivacy" CssClass="privacy" runat="server" />--%>
						<ext:Contactar ID="Contactar" CssClass="terms" runat="server" />
						<ext:InformacionGeneral ID="InformacionGeneral" CssClass="privacy" runat="server" />
						<ext:AvisoLegal ID="AvisoLegal" CssClass="terms" runat="server" />
						<ext:Privacidad ID="Privacidad" CssClass="privacy" runat="server" />
					</div>
				</div>
			</div>
		</div>
	</footer>
	<asp:Literal ID="LicenseMessage" runat="server"></asp:Literal>
	<div class="layout_trigger">
	</div>
</div>
<dnn:DnnCssInclude runat="server" FilePath="Home.theme.css" PathNameAlias="SkinPath" Priority="100" ForceProvider="DnnPageHeaderProvider" />
<!-- Se carga con el use.config como skin.js -->
<%--<dnn:DnnJsInclude runat="server" FilePath="HomeRevisado.js" PathNameAlias="SkinPath" Priority="101" ForceProvider="DnnFormBottomProvider" />--%>