<%@ control language="C#" inherits="CollectorsClub.Modules.Editores.EditorCategoriaCalendario_Idioma.View" autoeventwireup="true" codefile="CategoriaCalendario_IdiomaEditorView.ascx.cs" enableviewstate="false" %>
<asp:panel runat="server" id="Container">
	<!-- OLL: En las páginas del front oculto el historial de mensajes hasta que se me ocurra un método mejor
		Podríamos mostrar el formulario de envío de datos cuando no se haya cargado del todo la página. Es decir, todas las páginas deberían indicar que estan cargadas y si no en un timeout de n segundos debería aparecer 
		la opción -->
	<div id="HistorialMensajes" class="{title:'Historial de mensajes'}">
		<div class="mensajes" style="display: none; overflow-y: auto;" data-bind="foreach: Mensajes">
			<div data-bind="attr: { 'class': 'dnnFormMessage ' + Estilo }, html: Contenido"></div>
		</div>
	</div>
	<!--<div id="FormularioSoporte" class="{title:'Soporte'}">
		<div class="formulario" style="display: none; padding: 5px; background-color: rgba(0, 0, 0, 0.3)">
			<p>Si desea informarnos de algún error, por favor, envíenos este formulario:
			</p>
			<%--<div class="container">--%>
				<div class="row">
					<div class="form-group col-md-12">
						<%-- OLL: incorporar multiidioma <label data-bind="text: $parent.TraduccionCampos.get('Comentarios_Text')() + ':'"></label>--%>
						<label data-bind="text: 'Comentarios'"></label>
						<textarea class="form-control" data-bind="value: Comentarios, event: { keypress: function (data, event) { if (event.keyCode == 13) { $parent.Enviar(data); } else { return true; } } }"></textarea>
					</div>
				</div>
			<%--</div>--%>
			<ul class="dnnActions dnnClear">
				<li>
					<%--<a data-bind="click: $parent.Enviar, text: $parent.TraduccionCampos.get('Guardar_Text')()" class="dnnPrimaryAction"></a>--%>
					<a data-bind="click: Enviar, text: 'Enviar'" class="dnnPrimaryAction"></a>
				</li>
				<li>
					<%--<a data-bind="click: $parent.Cancelar, text: $parent.TraduccionCampos.get('Cancelar_Text')()" class="dnnSecondaryAction"></a>--%>
					<a data-bind="click: Cancelar, text: 'Cancelar'" class="dnnSecondaryAction"></a>
				</li>
			</ul>
		</div>
	</div>-->
	<div id="CategoriaCalendario_IdiomaEditorPrincipalContenedorCargando" class="ContenedorCargando" style="height: 50px; width: 50px;" data-elementoReferencia="CategoriaCalendario_IdiomaEditorPrincipalContenedorExterno"></div>
	<div id="CategoriaCalendario_IdiomaEditorPrincipalContenedorExterno" style="display: block;" data-bind="partial: Parametros"></div>
	<script type="text/javascript">
		if (typeof window.ParametrosGlobales === 'undefined') {
			window.ParametrosGlobales = {
				MostrarErrores: true,
				ErrorContainer: 'ErrorContainer',
				//ContenedorModulo: 'CategoriaCalendario_IdiomaEditorPrincipalContenedorExterno',
				//ElementoReferenciaCargando: 'CategoriaCalendario_IdiomaEditorPrincipalContenedorExterno',
				//CapaBloqueoCargando: 'CategoriaCalendario_IdiomaEditorPrincipalContenedorCargando',
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
				UltimasVersionesTablas: [],
				ObtenerMargenSuperiorScroll: function () { return $('#header')[0].offsetHeight + $('#header')[0].offsetTop; },
				Culturas: ['es-ES', 'ca-ES', 'en-US']
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

					//$("#FormularioSoporte").buildMbExtruder({
					//	position: "right",
					//	width: $(window).width() / 2.5,
					//	extruderOpacity: 1,
					//	onExtFinishOpen: function () {
					//		var _formulario = $('#FormularioSoporte .formulario');
					//		_formulario.width(parseInt(_formulario.parent().innerWidth() || 0) - parseInt((_formulario.parent().css('padding-right') || 0)) - parseInt((_formulario.parent().css('padding-left') || 0)));
					//		$('#FormularioSoporte .container').width(parseInt(_formulario.innerWidth() || 0) - parseInt((_formulario.css('padding-right') || 0)) - parseInt((_formulario.css('padding-left') || 0)));
					//		$('#FormularioSoporte .row').width(parseInt(_formulario.innerWidth() || 0) - parseInt((_formulario.css('padding-right') || 0)) - parseInt((_formulario.css('padding-left') || 0)) - 10);
					//		$(window).resize(function () {
					//			_formulario.width(parseInt(_formulario.parent().innerWidth() || 0) - parseInt((_formulario.parent().css('padding-right') || 0)) - parseInt((_formulario.parent().css('padding-left') || 0)));
					//			$('#FormularioSoporte .container').width(parseInt(_formulario.innerWidth() || 0) - parseInt((_formulario.css('padding-right') || 0)) - parseInt((_formulario.css('padding-left') || 0)));
					//			$('#FormularioSoporte .row').width(parseInt(_formulario.innerWidth() || 0) - parseInt((_formulario.css('padding-right') || 0)) - parseInt((_formulario.css('padding-left') || 0)) - 10);
					//		});
					//		_formulario.css('display', 'block');
					//	},
					//	onExtClose: function () {
					//		$('#FormularioSoporte .formulario').css('display', 'none');
					//	},
					//	closeOnExternalClick: false
					//});
					//ko.applyBindings(new function () {
					//	self = this;
					//	self.Comentarios = ko.observable(null);
					//	self.Enviar = function () {
					//		console.log('Enviando el formulario...');
					//	};
					//	self.Cancelar = function () {
					//		self.Comentarios = ko.observable(null);
					//	}
					//}, $('#FormularioSoporte')[0])
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
					IdModulo: 'CategoriaCalendario_IdiomaEditor',
					Entidad: 'CategoriaCalendario_Idioma',
					IdPartial: 'CategoriaCalendario_IdiomaEditorPrincipal',
					Contenedor: '#CategoriaCalendario_IdiomaEditorPrincipalContenedorInterno',
					TamanyoPagina: 50,
					ColumnaOrden: 'Id',
					TipoOrden: 0,
					ModuloPrincipal: true
				};

				var _parametrosUrl = ['IdDesde', 'IdHasta', 'IdRegistroDesde', 'IdRegistroHasta', 'Cultura', 'Nombre'];
				var _filtro = {};
				$.each(_parametrosUrl, function (indice, _parametroUrl) {
					var _parametro = utils.ObtenerParametroUrl(_parametroUrl);
					if (_parametro != '') { _filtro[_parametroUrl] = _parametro; }
				});
				if (_filtro != {}) { _parametros.Filtro = _filtro; }
						
				var _parametroModo = utils.ObtenerParametroUrl('ModoModulo');
				_parametros.Modo = (_parametroModo != '' ? _parametroModo : 'Listado');

				ko.applyBindings({ Parametros: _parametros }, $('#CategoriaCalendario_IdiomaEditorPrincipalContenedorExterno')[0]);
				if (parametrosGlobales.trace) { console.log(new Date().getTime() - Inicio.getTime() + ' - Cargado contenido ' + _parametros.IdModulo); }
			} catch (exception) {
				console.error(exception);
			}
		});
	</script>
</asp:panel>
