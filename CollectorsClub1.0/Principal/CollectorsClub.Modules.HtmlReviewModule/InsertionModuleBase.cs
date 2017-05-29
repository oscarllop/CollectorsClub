using System;
using System.Linq;
using System.Configuration;
using System.Collections.Specialized;
using System.IO;
using System.Text.RegularExpressions;
using System.Web;
using System.Collections.Generic;

namespace CollectorsClub.Modules {

	public class InsertionModuleBase : IHttpModule {

		#region Propiedades
		//public List<Dominio> InformacionDominios { get; private set; }
		#endregion Propiedades

		#region Constantes
		protected const string S_CONFIG_EXTENSIONESATRATARPORMODULOS = "ExtensionesATratarPorModulos";
		protected const string S_CONFIG_EXCEPCIONES = "ExcepcionesReviewModule";
		protected const string S_CONFIG_INFORMACIONDOMINIOS = "InformacionDominios";
		#endregion Constantes

		#region Variables
		private FilterReplacementDelegate _replacementDelegate = null;
		private InsertionFilterStream _filterStream = null;
		#endregion Variables

		#region Constructor y Destructor
		public InsertionModuleBase() { }

		public void Dispose() { }
		#endregion Constructor y Destructor

		#region Eventos

		#region Eventos del ciclo de vida
		public void Init(HttpApplication app) {
			Inicializa(app);
		}

		private void Application_BeginRequest(object source, EventArgs e) {
			try {
				// Con Ajax Control Toolkit tengo que incluir la condición !HttpContext.Current.Request.QueryString.ToString().Contains("_TSM_HiddenField")
				// En ciertos casos, como con el AutoComplete, llama a la página actual con otros parámetros y el filtro falla 
				if (ConfigurationManager.AppSettings[S_CONFIG_EXTENSIONESATRATARPORMODULOS].Contains(Path.GetExtension(HttpContext.Current.Request.CurrentExecutionFilePath)) && !HttpContext.Current.Request.QueryString.ToString().Contains("_TSM_HiddenField")) {
					HttpApplication app = source as HttpApplication;
					if (app != null) {
						bool _excepcion = false;
						string[] _urlsExcepciones = (!string.IsNullOrEmpty(ConfigurationManager.AppSettings[S_CONFIG_EXCEPCIONES]) ? ConfigurationManager.AppSettings[S_CONFIG_EXCEPCIONES].Split(',') : null);
						if (_urlsExcepciones != null) { _excepcion = _urlsExcepciones.Any(u => app.Request.RawUrl.ToLower().Contains(u.ToLower())); }
						if (!_excepcion && app.Request != null && app.Request.Form["__EVENTTARGET"] != null && app.Request.Form["__EVENTTARGET"].Contains("crViewer")) { _excepcion = true; }
						if (!_excepcion) {
							_replacementDelegate = new FilterReplacementDelegate(FilterString);
							_filterStream = new InsertionFilterStream(app.Response.Filter, _replacementDelegate, app.Response.ContentEncoding);
							app.Response.Filter = _filterStream;
							AsignarInformacionDominio(app);
						}
					}
				}
			} catch { }
		}
		#endregion Eventos del ciclo de vida
		
		#endregion Eventos

		#region Métodos

		#region Métodos privados
		private string FilterString(string s) {
			return ProcesarRespuestaConOSinAjax(s);
		}

		private void AsignarInformacionDominio(HttpApplication App) {
			//if (this.InformacionDominios == null && App != null) {
			//	if (App.Context.Application[S_CONFIG_INFORMACIONDOMINIOS] == null) {
			//		App.Context.Application[S_CONFIG_INFORMACIONDOMINIOS] = Dominio.GetData();
			//	}
			//	this.InformacionDominios = App.Context.Application[S_CONFIG_INFORMACIONDOMINIOS] as List<Dominio>;
			//}
		}
		#endregion Métodos privados

		#region Métodos protegidos
		protected virtual void Inicializa(HttpApplication app) {
			app.BeginRequest += new EventHandler(Application_BeginRequest);
		}

		protected string ProcesarRespuestaConOSinAjax(string content) {
			Regex reg = new Regex(@"^(\d+)\|[^\|]*\|[^\|]*\|", RegexOptions.Singleline);
			Match m = reg.Match(content);
			if (m.Success) {
				// Es una respuesta Ajax
				int length = 0;
				int.TryParse(m.Groups[1].Value, out length);
				reg = new Regex(@"^(\d+)(\|([^\|]*)\|[^\|]*\|)(.{" + length + @"})\|", RegexOptions.Singleline);
				m = reg.Match(content);
				if (m.Success) {
					string trans = string.Empty;
					switch (m.Groups[3].Value) {
					case "updatePanel": trans = ProcesarRespuesta(m.Groups[4].Value); break;
					default: trans = m.Groups[4].Value; break;
					}
					return trans.Length + m.Groups[2].Value + trans + "|" + ProcesarRespuestaConOSinAjax(content.Substring(m.Length));
				}
			}
			// No es una respuesta Ajax, la tratamos directamente.
			return ProcesarRespuesta(content);
		}

		protected virtual string ProcesarRespuesta(string s) {
			return s;
		}
		#endregion Métodos protegidos

		#endregion Métodos
	}
}