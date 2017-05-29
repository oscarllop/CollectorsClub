using System;
using System.Configuration;
using System.IO;
using System.Text.RegularExpressions;
using System.Web;
using System.Linq;

namespace CollectorsClub.Modules {

	/// <summary>
	/// This is a simple example of an insertion module, inheriting from
	/// InsertionModuleBase and performing a simple string replacement on the
	/// supplied web output buffer.
	/// </summary>
	public class HtmlReviewModule : InsertionModuleBase {

		#region Constantes
		const string S_CADENA_ROOTPATH = "~/";
		const string S_INICIO_AMD = "(function (factory) { if (typeof define === 'function' && define.amd) { define(['jquery'], factory) } else if (typeof exports === 'object') { module.exports = factory(require('jquery')) } else { factory(jQuery) } }(function ($) {";
		const string S_FIN_AMD = " }));";
		#endregion Constantes

		#region Métodos

		#region Métodos protegidos

		private string ConvertiraRegexString(string cadena) {
			return cadena.Replace("(", @"\(").Replace(")", @"\)").Replace("{", @"\{").Replace("}", @"\}").Replace("<", @"\<").Replace(">", @"\>").Replace("$", @"\$").Replace("!", @"\!").Replace("?", @"\?");
		}

		protected override string ProcesarRespuesta(string s) {
			//if (HttpContext.Current.Response.ContentType == "text/javascript") {
			//	if (s.Contains("function lsShowNotice(t,e,i){")) {
			//		s = s.Replace("function lsShowNotice(t,e,i){", S_INICIO_AMD + "function lsShowNotice(t,e,i){");
			//		s = s.Replace("}(jQuery);", S_INICIO_AMD + "}(jQuery);" + S_FIN_AMD);
			//	}
			//}
			if (HttpContext.Current.Response.ContentType == "text/html" || HttpContext.Current.Response.ContentType == "text/plain") {
				s = s.Replace(S_CADENA_ROOTPATH, VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath));
				if (s.Contains("<!-- CollectorsClub Skin -->")) {
					s = s.Replace("/Home.base.css\"", "/HomeRevisado.base.css\"");
					s = s.Replace("/Inner.base.css\"", "/InnerRevisado.base.css\"");
				}
				if (s.Contains("var dojoConfig")) {
					// OLL: Chapuza porque sinó no funciona en Producción. Por alguna razón que desconozco, en producción hay dos cdv diferentes.
					string _versionScripts = ConfigurationManager.AppSettings["VersionScripts"];
					int _inicioCadenaVersionScripts = s.IndexOf("?cdv=") + 5;
					_versionScripts = s.Substring(_inicioCadenaVersionScripts, s.IndexOf('"', _inicioCadenaVersionScripts) - _inicioCadenaVersionScripts);
					//               int _inicioCadenaVersionScripts = 0;
					//               if (s.IndexOf("jquery.cookie.js?cdv=") >= 0) {
					//	_inicioCadenaVersionScripts = s.IndexOf("jquery.cookie.js?cdv=") + 21;
					//	_versionScripts = s.Substring(_inicioCadenaVersionScripts, s.IndexOf('"', _inicioCadenaVersionScripts) - _inicioCadenaVersionScripts);
					//}
					//string _versionScripts = _versionScripts;
					//if (s.IndexOf("jquery-migrate.js?cdv=") >= 0) {
					//	int _inicioCadenaVersionScripts2 = s.IndexOf("jquery-migrate.js?cdv=") + 22;
					//	_versionScripts = s.Substring(_inicioCadenaVersionScripts2, s.IndexOf('"', _inicioCadenaVersionScripts2) - _inicioCadenaVersionScripts2);
					//}
					#region Para debugar
					string _cadenaDebug = "_script src=\"" + VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath) + "Resources/libraries/jQuery/01_09_01/jquery.js?cdv=" + _versionScripts + "\" type=\"text/javascript\"__/script_";
					_cadenaDebug += "\r\njquery" + s.IndexOf("<script src=\"" + VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath) + "Resources/libraries/jQuery/01_09_01/jquery.js?cdv=" + _versionScripts + "\" type=\"text/javascript\"></script>");
					_cadenaDebug += "\r\njqueryMigrate" + s.IndexOf("<script src=\"" + VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath) + "Resources/libraries/jQuery-Migrate/01_02_01/jquery-migrate.js?cdv=" + _versionScripts + "\" type=\"text/javascript\"></script>");
					_cadenaDebug += "\r\njqueryUI" + s.IndexOf("<script src=\"" + VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath) + "Resources/libraries/jQuery-UI/01_10_03/jquery-ui.js?cdv=" + _versionScripts + "\" type=\"text/javascript\"></script>");
					_cadenaDebug += "\r\najquery" + s.IndexOf("Resources/libraries/jQuery/01_09_01/jquery.js?cdv=" + _versionScripts);
					_cadenaDebug += "\r\najqueryMigrate" + s.IndexOf("Resources/libraries/jQuery-Migrate/01_02_01/jquery-migrate.js?cdv=" + _versionScripts);
					_cadenaDebug += "\r\najqueryUI" + s.IndexOf("Resources/libraries/jQuery-UI/01_10_03/jquery-ui.js?cdv=" + _versionScripts);
					#endregion Para debugar
					bool _incluirEditBar = Regex.IsMatch(s, "dnn.ContentEditorManagerResources");

					s = s.Replace("var dojoConfig", "var incluirEditBar = " + _incluirEditBar.ToString().ToLower() + "; var versionScripts = " + _versionScripts + ";\r\n/*" + _cadenaDebug + "*/\r\nvar dojoConfig");
					s = s.Replace("<script src=\"" + VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath) + "Resources/libraries/jQuery/01_09_01/jquery.js?cdv=" + _versionScripts + "\" type=\"text/javascript\"></script>", string.Empty);
					s = s.Replace("<script src=\"" + VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath) + "Resources/libraries/jQuery-Migrate/01_02_01/jquery-migrate.js?cdv=" + _versionScripts + "\" type=\"text/javascript\"></script>", string.Empty);
					s = s.Replace("<script src=\"" + VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath) + "Resources/libraries/jQuery-UI/01_11_03/jquery-ui.js?cdv=" + _versionScripts + "\" type=\"text/javascript\"></script>", string.Empty);
					s = s.Replace("<script src=\"" + VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath) + "js/Debug/dnncore.js?cdv=" + _versionScripts + "\" type=\"text/javascript\"></script>", string.Empty);

					s = Regex.Replace(s, @"\<script src=""" + VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath) + @"Portals/_default/skins/porto/Resources/Menu/menu.min.js\?cdv=" + _versionScripts + @""" type=""text/javascript""\>\</script\>", string.Empty, RegexOptions.IgnoreCase);
					s = Regex.Replace(s, @"\<script src=""" + VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath) + @"Portals/_default/skins/porto/Home.base.js\?cdv=" + _versionScripts + @""" type=""text/javascript""\>\</script\>", string.Empty, RegexOptions.IgnoreCase);
					//s = Regex.Replace(s, @"\<script src=""" + VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath) + @"Portals/_default/skins/porto/HomeRevisado.js\?cdv=" + _versionScripts + @""" type=""text/javascript""\>\</script\>", string.Empty, RegexOptions.IgnoreCase);
					s = Regex.Replace(s, @"\<script src=""" + VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath) + @"Portals/_default/skins/porto/Inner.base.js\?cdv=" + _versionScripts + @""" type=""text/javascript""\>\</script\>", string.Empty, RegexOptions.IgnoreCase);
					//s = Regex.Replace(s, @"\<script src=""" + VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath) + @"Portals/_default/skins/porto/InnerRevisado.js\?cdv=" + _versionScripts + @""" type=""text/javascript""\>\</script\>", string.Empty, RegexOptions.IgnoreCase);

					s = Regex.Replace(s, @"\$\('#([^']*)'\).layerSlider\(\{([^<]*)", "require(['jquery', 'use!Plugins/LiveSlider/LiveSlider'], function ($, liveSlider) { $('#$1').layerSlider({ $2 });");
					s = Regex.Replace(s, @"\<script src=""" + VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath) + @"WebResource.axd\?d=CON4WpTji6[^&]*&amp;t=[^&]*&amp;cdv=" + _versionScripts + @""" type=""text/javascript""\>\</script\>", string.Empty);
					s = Regex.Replace(s, @"\<script src=""" + VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath) + @"WebResource.axd\?d=MZmjywClmE[^&]*&amp;t=[^&]*&amp;cdv=" + _versionScripts + @""" type=""text/javascript""\>\</script\>", string.Empty);
					s = Regex.Replace(s, @"\<script src=""" + VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath) + @"WebResource.axd\?d=wL4KpjWgth[^&]*&amp;t=[^&]*&amp;cdv=" + _versionScripts + @""" type=""text/javascript""\>\</script\>", string.Empty);

					//Administracion
					s = Regex.Replace(s, @"\<script src=""" + VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath) + @"DesktopModules/Mandeeps/Libraries/Common/Frameworks/Bootstrap/3.3.4/js/bootstrap.min.js\?cdv=" + _versionScripts + @""" type=""text/javascript""\>\</script\>", string.Empty);
					s = Regex.Replace(s, @"\<script src=""" + VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath) + @"js/dnn.js(\?cdv=" + _versionScripts + @")?"" type=""text/javascript""\>\</script\>", string.Empty);
					// OLL: revisar si salen en admin o en edición para mirar de minimizar el número de reemplazos
					s = Regex.Replace(s, @"\<script src=""" + VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath) + @"js/dnn.xmlhttp.js(\?cdv=" + _versionScripts + @")?"" type=""text/javascript""\>\</script\>", string.Empty);
					s = Regex.Replace(s, @"\<script src=""" + VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath) + @"js/dnn.xmlhttp.jsxmlhttprequest.js(\?cdv=" + _versionScripts + @")?"" type=""text/javascript""\>\</script\>", string.Empty);
					s = Regex.Replace(s, @"\<script src=""" + VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath) + @"js/dnn.controls.js(\?cdv=" + _versionScripts + @")?"" type=""text/javascript""\>\</script\>", string.Empty);
					s = Regex.Replace(s, @"\<script src=""" + VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath) + @"js/dnn.controls.dnnlabeledit.js(\?cdv=" + _versionScripts + @")?"" type=""text/javascript""\>\</script\>", string.Empty);
					s = Regex.Replace(s, @"\<script src=""" + VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath) + @"js/dnn.dom.positioning.js(\?cdv=" + _versionScripts + @")?"" type=""text/javascript""\>\</script\>", string.Empty);

					s = Regex.Replace(s, @"\<script src=""" + VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath) + @"Resources/Shared/Scripts/jquery/jquery.hoverIntent.min.js\?cdv=" + _versionScripts + @""" type=""text/javascript""\>\</script\>", string.Empty);
					s = Regex.Replace(s, @"\<script src=""" + VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath) + @"Resources/Shared/Components/Tokeninput/jquery.tokeninput.js\?cdv=" + _versionScripts + @""" type=""text/javascript""\>\</script\>", string.Empty);
					s = Regex.Replace(s, @"\<script src=""" + VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath) + @"js/Debug/dnn.servicesframework.js\?cdv=" + _versionScripts + @""" type=""text/javascript""\>\</script\>", string.Empty);
					s = Regex.Replace(s, @"\<script src=""" + VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath) + @"Resources/Shared/Scripts/dnn.jquery.js\?cdv=" + _versionScripts + @""" type=""text/javascript""\>\</script\>", string.Empty);
					s = Regex.Replace(s, @"\<script src=""" + VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath) + @"Portals/_default/skins/Porto/Resources/js/jquery.colorpicker.min.js\?cdv=" + _versionScripts + @""" type=""text/javascript""\>\</script\>", string.Empty, RegexOptions.IgnoreCase);
					s = Regex.Replace(s, @"\<script src=""" + VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath) + @"Portals/_default/skins/Porto/Resources/js/js.cookie.min.js\?cdv=" + _versionScripts + @""" type=""text/javascript""\>\</script\>", string.Empty, RegexOptions.IgnoreCase);
					s = Regex.Replace(s, @"\<script src=""" + VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath) + @"Resources/libraries/Knockout/03_03_00/knockout.js\?cdv=" + _versionScripts + @""" type=""text/javascript""\>\</script\>", string.Empty);
					s = Regex.Replace(s, @"\<script src=""" + VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath) + @"Resources/libraries/Knockout.Mapping/02_04_01/knockout.mapping.js\?cdv=" + _versionScripts + @""" type=""text/javascript""\>\</script\>", string.Empty, RegexOptions.IgnoreCase);
					s = Regex.Replace(s, @"\<script type=""text/javascript"" src=""" + VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath) + @"Portals/_default/skins/porto/Resources/js/less.js""\>\</script\>", string.Empty, RegexOptions.IgnoreCase);

					// Administracion - Skin -- Revisar en un futuro para cargarlos correctamente
					//s = Regex.Replace(s, @"\<script src=""" + VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath) + @"DesktopModules/Mandeeps/Libraries/Common/Frameworks/AngularJS/1.3.9/angular.min.js\?cdv=" + _versionScripts + @""" type=""text/javascript""\>\</script\>", string.Empty);
					//s = Regex.Replace(s, @"\<script src=""" + VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath) + @"DesktopModules/Mandeeps/Libraries/Common/Frameworks/AngularJS/1.3.9/angular-route.min.js\?cdv=" + _versionScripts + @""" type=""text/javascript""\>\</script\>", string.Empty);
					//s = Regex.Replace(s, @"\<script src=""" + VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath) + @"DesktopModules/Mandeeps/Libraries/Common/Frameworks/AngularJS/Plugins/mnCommonService/mnCommonService.min.js\?cdv=" + _versionScripts + @""" type=""text/javascript""\>\</script\>", string.Empty);
					//s = Regex.Replace(s, @"\<script src=""" + VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath) + @"DesktopModules/Mandeeps/Libraries/Common/Frameworks/HtmlParser/1.0.0/htmlparser.min.js\?cdv=" + _versionScripts + @""" type=""text/javascript""\>\</script\>", string.Empty);
					//s = Regex.Replace(s, @"\<script src=""" + VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath) + @"DesktopModules/Mandeeps/Libraries/Common/Frameworks/Html2Json/1.0.0/html2json.min.js\?cdv=" + _versionScripts + @""" type=""text/javascript""\>\</script\>", string.Empty);
					s = Regex.Replace(s, @"\<script src=""" + VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath) + @"DesktopModules/Mandeeps/Libraries/Common/Frameworks/AngularJS/Plugins/SweetAlert/alert.min.js\?cdv=" + _versionScripts + @""" type=""text/javascript""\>\</script\>", string.Empty);
					//s = Regex.Replace(s, @"\<script src=""" + VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath) + @"DesktopModules/Mandeeps/Libraries/Common/Frameworks/AngularJS/Plugins/SweetAlert/SweetAlert.min.js\?cdv=" + _versionScripts + @""" type=""text/javascript""\>\</script\>", string.Empty);
					//s = Regex.Replace(s, @"\<script src=""" + VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath) + @"DesktopModules/Mandeeps/Libraries/Common/Frameworks/AngularJS/Plugins/loading-bar/loading-bar.min.js\?cdv=" + _versionScripts + @""" type=""text/javascript""\>\</script\>", string.Empty);
					//s = Regex.Replace(s, @"\<script src=""" + VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath) + @"DesktopModules/Mandeeps/Libraries/Common/Frameworks/WebAPI/1.0.0/webAPI.min.js\?cdv=" + _versionScripts + @""" type=""text/javascript""\>\</script\>", string.Empty);


					s = Regex.Replace(s, @"\(function\s*\(\$\)\s*\{", "require(['jquery'], function (jQuery) { (function($) {");
					s = Regex.Replace(s, @"\}\)\s*\(jQuery\);", "})(jQuery); });");
					s = Regex.Replace(s, @"\}\s*\(jQuery\)\);", "})(jQuery); });");

					//Modo edicion
					s = Regex.Replace(s, @"\<script src=""" + VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath) + @"admin/menus/ModuleActions/ModuleActions.js\?cdv=" + _versionScripts + @""" type=""text/javascript""\>\</script\>", string.Empty);
					s = Regex.Replace(s, @"\<script type=""text/javascript""\>dnn.([^<]*)", "<script type=\"text/javascript\">require(['use!dnn/dnn.controls.dnnlabeledit'], function (dnncontrolsdnnlabeledit) { dnn.$1 });");

					s = Regex.Replace(s, @"\<script src=""" + VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath) + @"Resources/Shared/scripts/dnn.extensions.js\?cdv=" + _versionScripts + @""" type=""text/javascript""\>\</script\>", string.Empty);
					s = Regex.Replace(s, @"\<script src=""" + VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath) + @"Resources/Shared/scripts/dnn.jquery.extensions.js\?cdv=" + _versionScripts + @""" type=""text/javascript""\>\</script\>", string.Empty);
					s = Regex.Replace(s, @"\<script src=""" + VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath) + @"Resources/Shared/scripts/dnn.DataStructures.js\?cdv=" + _versionScripts + @""" type=""text/javascript""\>\</script\>", string.Empty);
					s = Regex.Replace(s, @"\<script src=""" + VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath) + @"Resources/Shared/scripts/jquery/jquery.mousewheel.js\?cdv=" + _versionScripts + @""" type=""text/javascript""\>\</script\>", string.Empty);
					s = Regex.Replace(s, @"\<script src=""" + VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath) + @"Resources/Shared/scripts/jquery/dnn.jScrollBar.js\?cdv=" + _versionScripts + @""" type=""text/javascript""\>\</script\>", string.Empty);
					s = Regex.Replace(s, @"\<script src=""" + VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath) + @"Resources/Shared/scripts/TreeView/dnn.TreeView.js\?cdv=" + _versionScripts + @""" type=""text/javascript""\>\</script\>", string.Empty);
					s = Regex.Replace(s, @"\<script src=""" + VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath) + @"Resources/Shared/scripts/TreeView/dnn.DynamicTreeView.js\?cdv=" + _versionScripts + @""" type=""text/javascript""\>\</script\>", string.Empty);
					s = Regex.Replace(s, @"\<script src=""" + VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath) + @"Resources/Shared/Components/DropDownList/dnn.DropDownList.js\?cdv=" + _versionScripts + @""" type=""text/javascript""\>\</script\>", string.Empty);
					s = Regex.Replace(s, @"\<script src=""" + VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath) + @"DesktopModules/admin/Dnn.EditBar/Resources/ContentEditorManager/Js/ModuleManager.js\?cdv=" + _versionScripts + @""" type=""text/javascript""\>\</script\>", string.Empty);
					s = Regex.Replace(s, @"\<script src=""" + VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath) + @"DesktopModules/admin/Dnn.EditBar/Resources/ContentEditorManager/Js/ModuleDialog.js\?cdv=" + _versionScripts + @""" type=""text/javascript""\>\</script\>", string.Empty);
					s = Regex.Replace(s, @"\<script src=""" + VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath) + @"DesktopModules/admin/Dnn.EditBar/Resources/ContentEditorManager/Js/ExistingModuleDialog.js\?cdv=" + _versionScripts + @""" type=""text/javascript""\>\</script\>", string.Empty);
					s = Regex.Replace(s, @"\<script src=""" + VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath) + @"DesktopModules/admin/Dnn.EditBar/Resources/ContentEditorManager/Js/ModuleService.js\?cdv=" + _versionScripts + @""" type=""text/javascript""\>\</script\>", string.Empty);
					s = Regex.Replace(s, @"\<script src=""" + VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath) + @"DesktopModules/admin/Dnn.EditBar/Resources/ContentEditorManager/Js/ContentEditor.js\?cdv=" + _versionScripts + @""" type=""text/javascript""\>\</script\>", string.Empty);
					s = Regex.Replace(s, @"\<script src=""" + VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath) + @"DesktopModules/admin/Dnn.EditBar/scripts/editBarContainer.js\?cdv=" + _versionScripts + @""" type=""text/javascript""\>\</script\>", string.Empty);
					s = Regex.Replace(s, @"\<script src=""" + VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath) + @"resources/shared/scripts/dnn.dragDrop.js\?cdv=" + _versionScripts + @""" type=""text/javascript""\>\</script\>", string.Empty);
					s = Regex.Replace(s, @"dnn.ContentEditorManagerResources([^)]*\);)", "require(['use!editbar/Resources/ContentEditorManager/Js/ContentEditor'], function (editBarContentEditor) { dnn.ContentEditorManagerResources$1 });");
					s = Regex.Replace(s, @"\$\('([^']*)'\).dnnModuleDragDrop\(\{([^)]*)\}\);", "require(['use!global/dnn.dragDrop'], function (dnnDragDrop) { $('$1').dnnModuleDragDrop({$2}); });");



					// Google MAPS
					s = Regex.Replace(s, @"\<script type=""text/javascript"" src=""//maps.google.com/maps/api/js""\>\</script\>", string.Empty, RegexOptions.IgnoreCase);

					// Skin UnlimiteColors. No se necesita
					//s = s.Replace("<script src=\"" + VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath) + "DesktopModules/DNNGo_StyleSwicth/Resource/js/jquery.cookie.js?cdv=" + _versionScripts + "\" type=\"text/javascript\"></script>", string.Empty);
					//s = s.Replace("<script src=\"" + VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath) + "DesktopModules/DNNGo_StyleSwicth/Resource/js/jquery.easing.1.3.js?cdv=" + _versionScripts + "\" type=\"text/javascript\"></script>", string.Empty);
					//s = s.Replace("<script src=\"" + VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath) + "DesktopModules/DNNGo_StyleSwicth/Resource/js/bootstrap-colorpicker.js?cdv=" + _versionScripts + "\" type=\"text/javascript\"></script>", string.Empty);
					//s = s.Replace("<script src=\"" + VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath) + "DesktopModules/DNNGo_StyleSwicth/Resource/js/colorpicker.js?cdv=" + _versionScripts + "\" type=\"text/javascript\"></script>", string.Empty);
					//s = s.Replace("<script src=\"" + VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath) + "DesktopModules/DNNGo_StyleSwicth/Resource/js/jquery.common.js?cdv=" + _versionScripts + "\" type=\"text/javascript\"></script>", string.Empty);

					//s = s.Replace("<script src=\"" + VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath) + "DesktopModules/DNNGo_GoMenu/Resource/js/jquery.hoverIntent.min.js\" type=\"text/javascript\"></script>", string.Empty);
					//s = s.Replace("<script src=\"" + VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath) + "DesktopModules/DNNGo_GoMenu/Resource/js/Slide.js\" type=\"text/javascript\"></script>", string.Empty);
					s = s.Replace("<script src=\"" + VirtualPathUtility.AppendTrailingSlash(HttpContext.Current.Request.ApplicationPath) + "js/Debug/dnn.modalpopup.js?cdv=" + _versionScripts + "\" type=\"text/javascript\"></script>", string.Empty);
				} else {
					s = s.Replace("http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.16/jquery-ui.min.js", "https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.16/jquery-ui.min.js");
				}
				//if (_dominio != null) {
				//	s = s.Replace("Portals/0/favicon.ico", string.Format("Portals/0/favicon{0}.ico", _dominio.IdMarca));
				//}
			}
			return s;
		}
		#endregion Métodos protegidos

		//#region Métodos Privados
		//private Dominio obtenerDominoPorUrl() {
		//	string DominioRquest = HttpContext.Current.Request.Url.Host;
		//	return this.InformacionDominios.FirstOrDefault(r => DominioRquest.Contains(r.DominioUrl));
		//}
		//#endregion Métodos Privados

		#endregion Métodos
	}
}
