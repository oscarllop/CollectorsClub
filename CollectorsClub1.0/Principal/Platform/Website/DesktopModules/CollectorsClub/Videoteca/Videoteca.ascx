<%@ Control Language="C#" AutoEventWireup="true" Inherits="CollectorsClub.UI.Skins.Controls.Videoteca" CodeFile="Videoteca.ascx.cs" %>
<asp:panel runat="server" id="Container">
	<!-- OLL: En las páginas del front oculto el historial de mensajes hasta que se me ocurra un método mejor
		Podríamos mostrar el formulario de envío de datos cuando no se haya cargado del todo la página. Es decir, todas las páginas deberían indicar que estan cargadas y si no en un timeout de n segundos debería aparecer 
		la opción -->
	<div id="HistorialMensajes" class="{title:'Historial de mensajes'}">
		<div class="mensajes" style="display: none; overflow-y: auto;" data-bind="foreach: Mensajes">
			<div data-bind="attr: { 'class': 'dnnFormMessage ' + Estilo }, html: Contenido"></div>
		</div>
	</div>
	<div id="VideotecaPrincipalContenedorCargando" class="ContenedorCargando" style="height: 50px; width: 50px;" data-elementoReferencia="VideotecaPrincipalContenedorExterno"></div>
	<div id="VideotecaPrincipalContenedorExterno" style="display: block;" data-bind="partialbieniniciada: Parametros"></div>
	<script type="text/javascript">
		if (typeof window.ParametrosGlobales === 'undefined') {
			window.ParametrosGlobales = {
				MostrarErrores: false,
				ErrorContainer: 'ErrorContainer',
				MensajeErrorCarga: '<%=DotNetNuke.UI.Utilities.ClientAPI.GetSafeJSString(LocalizeString("MensajeErrorCarga"))%>',
				Cultura: '<%= System.Threading.Thread.CurrentThread.CurrentCulture.ToString() %>',
				IdMarca: '<%= Session["Marca"] %>',
				IdPersona: '<%= Session["IdPersona"] %>',
				Usuario: '<%= (Page.User.Identity != null && !string.IsNullOrEmpty(Page.User.Identity.Name) ? Page.User.Identity.Name : "usuario_anonimo") %>',
				UrlWebAPI: '<%= ConfigurationManager.AppSettings["UrlWebAPI"] %>',
				ApplicationPath: '~/',
				RutaPartials: '<%= ConfigurationManager.AppSettings["RutaPartials"] %>',
				Aplicacion: '<%= ConfigurationManager.AppSettings["Aplicacion"] %>',
				UrlBaseDojo: '~/Resources/Shared/scripts/dojo/dojo/',
				UrlBaseCKEditor: '~/js/AMD/plugins/ckEditor/',
				debug: false,
				trace: false,
				UltimasVersionesTablas: []
			}
			define('ParametrosGlobales', window.ParametrosGlobales);

			require(['ParametrosGlobales', 'jquery'], function (ParametrosGlobales, $) {
				if (!ParametrosGlobales.MostrarErrores) { $('#HistorialMensajes').hide(); }
			});

			require.on('error', function (error) {
				if (!$('#' + window.ParametrosGlobales.ErrorContainer).length) { $("body").append('<div id="' + window.ParametrosGlobales.ErrorContainer + '" class="errorLabel"' + (window.ParametrosGlobales.MostrarErrores ? '' : ' style="visibility: hidden"') + ' />'); }
				window.Utils && window.Utils.MostrarMensaje('#' + window.ParametrosGlobales.ErrorContainer, 'No se ha podido cargar el módulo ' + error.info[0], 'dnnFormError', false);
			});
		}

		if (ParametrosGlobales.trace) { console.log(new Date().getTime() - Inicio.getTime() + ' - Main: Antes de obtener dependencias'); }
		require(['ParametrosGlobales', 'use!porto/Resources/Menu/menu.min', 'knockout', 'Globales/knockout.extensions', 'dojox/json/ref', 'Globales/Cargando', 'WebAPI/knockout.mapping-latest', 'jquery', 'Globales/Error', 'DNN/dnn.modalpopup', 'Globales/popup', 'Globales/Core.DoubleScroll', 'Globales/Core.ExpandToParent', 'Globales/Core.Utils', 'Plugins/inputmask/inputmask', 'Plugins/inputmask/jquery.inputmask', 'Plugins/inputmask/inputmask.regex.extensions', 'Plugins/inputmask/inputmask.phone.extensions', 'Globales/partials'], function (parametrosGlobales, menu, ko, koextensions, dojoref, cargando, mapping, $, error, modalPopup, popup, doubleScroll, expandToParent, utils, inputmask, jqueryInputmask, inputmaskRegexExtension, inputmaskPhoneExtension, partials) {
			if (parametrosGlobales.trace) { console.log(new Date().getTime() - Inicio.getTime() + ' - Iniciando main'); }

			// OLL: parametrosGlobales.Mensajes nos sirve de semáforo para no hacer temas globales dos veces. Deberíamos tener un script que haga los temas globales siempre que haya como mínimo un módulo amd en la página.
			// analizar como
			if (typeof parametrosGlobales.Mensajes === 'undefined') {
				window.ko = ko;
				window.ko.mapping = mapping;

				require(['jquery', 'use!Plugins/extruder/mbExtruder.extension'], function ($, mbExtruder) {
					$("#HistorialMensajes").buildMbExtruder({
						position: "right",
						width: $(window).width() / 2.5,
						extruderOpacity: 1,
						onExtFinishOpen: function () {
							var _mensajesContenedor = $('#HistorialMensajes .mensajes');
							_mensajesContenedor.height(parseInt(_mensajesContenedor.parent().parent().height() || 0) - parseInt((_mensajesContenedor.parent().css('padding-top') || 0)) - parseInt((_mensajesContenedor.parent().css('padding-bottom') || 0)));
							$(window).resize(function () {
								_mensajesContenedor.height(parseInt(_mensajesContenedor.parent().parent().height() || 0) - parseInt((_mensajesContenedor.parent().css('padding-top') || 0)) - parseInt((_mensajesContenedor.parent().css('padding-bottom') || 0)));
							});
							_mensajesContenedor.css('display', 'block');
						},
						onExtClose: function () {
							$('#HistorialMensajes .mensajes').css('display', 'none');
						},
						closeOnExternalClick: false
					});
					ko.applyBindings({ Mensajes: parametrosGlobales.Mensajes }, $('#HistorialMensajes')[0])
				});

				parametrosGlobales.Mensajes = ko.observableArray([]);

				utils.ObtenerVersionesTablas();

				// OLL: ¿Este punto sigo necesitándolo en DNN 9? lo deshabilito para ver si siguen fallando los menús. Borrarlo si no fallan
				// Deshabilita los eventos del link del menú que se está visualizando para evitar que se disparen eventos de validación al ir desde el menú a la misma página
				//function DeshabilitarEventosMenuitemActual() {
				//	var old_element = $('.subcurrent a').get(0);
				//	if (old_element != null) {
				//		var new_element = old_element.cloneNode(true);
				//		old_element.parentNode.replaceChild(new_element, old_element);
				//	}
				//}
				//DeshabilitarEventosMenuitemActual();
			}

			try {
				var _parametros = {
					PermitirCrear: true,
					PermitirGuardar: true,
					PermitirBorrar: true,
					BusquedaAutomatica: true,
					IdModulo: 'Videoteca',
					Entidad: 'Testimonial',
					IdPartial: 'VideotecaPrincipal',
					Contenedor: '#VideotecaPrincipalContenedorInterno',
					TamanyoPagina: 50,
					ColumnaOrden: 'Id',
					TipoOrden: 0,
					ModuloPrincipal: true
				};

				var _parametrosUrl = ['IdDesde', 'IdHasta', 'FechaAltaDesde', 'FechaAltaHasta', 'FechaUltimaModificacionDesde', 'FechaUltimaModificacionHasta', 'IdMarca'];
				var _filtro = {};
				$.each(_parametrosUrl, function (indice, _parametroUrl) {
					var _parametro = utils.ObtenerParametroUrl(_parametroUrl);
					if (_parametro != '') { _filtro[_parametroUrl] = _parametro; }
				});
				if (_filtro != {}) { _parametros.Filtro = _filtro; }

				var _parametroModo = utils.ObtenerParametroUrl('ModoModulo');
				_parametros.Modo = (_parametroModo != '' ? _parametroModo : 'Listado');

				ko.applyBindings({ Parametros: _parametros }, $('#VideotecaPrincipalContenedorExterno')[0]);
				if (parametrosGlobales.trace) { console.log(new Date().getTime() - Inicio.getTime() + ' - Cargado contenido ' + _parametros.IdModulo); }
			} catch (exception) {
				console.error(exception);
			}
		});
	</script>
</asp:panel>
