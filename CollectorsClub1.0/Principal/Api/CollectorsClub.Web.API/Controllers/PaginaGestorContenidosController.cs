
using CollectorsClub.Model;
using CollectorsClub.Model.Repositories;
using CollectorsClub.Web.API.App_Code;
using Core.Json;
using log4net;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Reflection;
using System.Web.Http;
using WebApi.OutputCache.V2;

namespace CollectorsClub.Web.API.Controllers {

	[Authorize]
	public partial class PaginaGestorContenidosController : ApiController {
		private static readonly ILog log = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
		private readonly ICalendarioRepository calendarioRepository;

		public PaginaGestorContenidosController(ICalendarioRepository calendarioRepository) {
			this.calendarioRepository = calendarioRepository;
			log4net.Config.XmlConfigurator.Configure();
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
	}
}