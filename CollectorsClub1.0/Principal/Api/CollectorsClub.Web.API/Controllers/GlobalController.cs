
using CollectorsClub.Model;
using CollectorsClub.Model.Repositories;
using CollectorsClub.Web.API.App_Code;
using CollectorsClub.Web.API.Models;
using Core.Json;
using log4net;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Reflection;
using System.Web;
using System.Web.Http;
using WebApi.OutputCache.V2;

namespace CollectorsClub.Web.API.Controllers {

	// Cambiar nombre a UtilidadesController
	[Authorize]
	public partial class GlobalController : ApiController {
		private static readonly ILog log = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
		private readonly ICalendarioRepository calendarioRepository;

		public GlobalController(ICalendarioRepository calendarioRepository) {
			this.calendarioRepository = calendarioRepository;
			log4net.Config.XmlConfigurator.Configure();
		}
		
		[HttpGet]
		[AllowAnonymous]
		public HttpResponseMessage GetExcel(string rutaArchivo, string nombre) {
			try {
				HttpResponseMessage _response = Request.CreateResponse(HttpStatusCode.OK);
				string fullpath = ConfigurationManager.AppSettings["UrlGuardarDocumentosTemporales"] + string.Format("{0}", rutaArchivo);
				_response.Content = new StreamContent(new FileStream(fullpath, FileMode.Open, FileAccess.Read));
				_response.Content.Headers.ContentDisposition = new System.Net.Http.Headers.ContentDispositionHeaderValue("attachment");
				_response.Content.Headers.ContentType = new System.Net.Http.Headers.MediaTypeHeaderValue("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
				_response.Content.Headers.ContentDisposition.FileName = Utilidades.RemoveDiacritics(string.Format("{0}.xlsx", nombre));
				return _response;
			} catch (Exception _excepcion) {
				log.Error(string.Format("Archivo: {0}, Nombre: {1}", rutaArchivo, nombre), _excepcion);
				return Request.CreateResponse(HttpStatusCode.InternalServerError, _excepcion);
			}
		}

		[HttpGet]
		[AllowAnonymous]
		[CacheOutput(ClientTimeSpan = 100, ServerTimeSpan = 0)]
		public HttpResponseMessage GetQuery([FromUri] string query, [FromUri] object[] parameter, [FromUri] bool indent = false, [FromUri] TiposRetorno tipoRetorno = TiposRetorno.Json) {
			try {
				var formatter = new MaxDepthJsonMediaTypeFormatter() { Indent = indent };
				formatter.SerializerSettings.MaxDepth = 1;
				List<dynamic> _listaResultados = CollectorsClubEntities.ExecuteCommand(query, Enumerable.Select(parameter, p => new SqlParameter("@" + p.ToString().Split('|')[0], (SqlDbType) Enum.Parse(typeof(SqlDbType), p.ToString().Split('|')[1], true)) { Size = (p.ToString().Split('|').Length > 3 && !string.IsNullOrEmpty(p.ToString().Split('|')[3]) ? int.Parse(p.ToString().Split('|')[3]) : 0), Value = ((p.ToString().Split('|')[2] != string.Empty ? p.ToString().Split('|')[2] : null) ?? (object) DBNull.Value) }).ToArray<SqlParameter>(), CommandType.StoredProcedure, ((CalendarioRepository) calendarioRepository).DataContext.Database.Connection.ConnectionString);
				switch (tipoRetorno) {
				case TiposRetorno.Json: return Request.CreateResponse(HttpStatusCode.OK, _listaResultados);
				case TiposRetorno.Excel: return Request.CreateResponse(HttpStatusCode.OK, Utilidades.GenerarExcel((IEnumerable<object>) _listaResultados));
				}
				return Request.CreateResponse(HttpStatusCode.InternalServerError, "No se ha podido efectuar acción");
			} catch (Exception _excepcion) {
				log.Error(_excepcion);
				return Request.CreateResponse(HttpStatusCode.InternalServerError, _excepcion);
			}
		}

		[AllowAnonymous]
		[HttpPost]
		public HttpResponseMessage CargarArchivo() {
			// Creating a variable to store the file if it has been sent.   
			var uploadedFile = HttpContext.Current.Request.Files.Count > 0 ? HttpContext.Current.Request.Files[0] : null;
			var _rutaRelativa = HttpContext.Current.Request.Form[0];

			if (uploadedFile != null && uploadedFile.ContentLength > 0 && uploadedFile.ContentLength <= 10485760) {
				var _nombreArchivo = Path.GetFileName(uploadedFile.FileName);

				// Set the path in Web.Config file to save the uploaded files. 
				string _directorio = ConfigurationManager.AppSettings["RutaArchivos"] + _rutaRelativa.Replace(Path.AltDirectorySeparatorChar, Path.DirectorySeparatorChar);

				if (!Directory.Exists(_directorio)) { Directory.CreateDirectory(_directorio); }
				uploadedFile.SaveAs(_directorio + "\\" + _nombreArchivo);

				// Fetching the data that has been sent along with the form. 7
				//var formdata = HttpContext.Current.Request.Form[0];
				//return Request.CreateResponse<CargaArchivoModel>(HttpStatusCode.OK, new CargaArchivoModel() { Ruta = _rutaRelativa + '/' + _nombreArchivo, Mensaje = "Carga finalizada correctamente." });
				return Request.CreateResponse<CargaArchivoModel>(HttpStatusCode.OK, new CargaArchivoModel() { Ruta = _nombreArchivo, Mensaje = "Carga finalizada correctamente." });
			} else {
				return Request.CreateResponse<string>(HttpStatusCode.InternalServerError, "Error en la carga del fichero al servidor. No se ha detectado contenido en la petición.");
			}
		}
	}
}