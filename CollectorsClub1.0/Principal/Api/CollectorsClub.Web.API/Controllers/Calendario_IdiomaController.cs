
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Dynamic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Reflection;
using System.Web.Http;
using CollectorsClub.Data.Dispatcher;
using CollectorsClub.Model;
using CollectorsClub.Model.Commands;
using CollectorsClub.Model.Entities;
using CollectorsClub.Model.Repositories;
using CollectorsClub.Web.API.App_Code;
using CollectorsClub.Web.API.Models;
using Core.Json;
using log4net;
using WebApi.OutputCache.V2;

namespace CollectorsClub.Web.API.Controllers {
	
	[Authorize]
	public partial class Calendario_IdiomaController : ApiController {
		private readonly ICommandBus commandBus;
		private readonly ICalendario_IdiomaRepository calendario_idiomaRepository;
	  private static readonly ILog log = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
		
		public Calendario_IdiomaController(ICommandBus commandBus, ICalendario_IdiomaRepository calendario_idiomaRepository) {
			this.commandBus = commandBus;
			this.calendario_idiomaRepository = calendario_idiomaRepository;
			log4net.Config.XmlConfigurator.Configure();
		}
		
		[Queryable]
		[CacheOutput(ClientTimeSpan = 100, ServerTimeSpan = 0)]
		public HttpResponseMessage Get([FromUri] string[] include, [FromUri] bool indent = false) {
			try {
				var formatter = new MaxDepthJsonMediaTypeFormatter() { Indent = indent };
				if (include.Length > 0) {
					formatter.SerializerSettings.MaxDepth = 100; //include.Max<string>(s => s.Split('.').Length * 5);
					formatter.SerializerSettings.PreserveReferencesHandling = Newtonsoft.Json.PreserveReferencesHandling.Objects;
				} else {
					formatter.SerializerSettings.MaxDepth = 1;
				}
				return Request.CreateResponse<IQueryable<Calendario_Idioma>>(HttpStatusCode.OK, calendario_idiomaRepository.GetAll(include).AsQueryable(), formatter);
			} catch (Exception _excepcion) {
				log.Error(_excepcion);
				return Request.CreateResponse(HttpStatusCode.InternalServerError, _excepcion);
			}
		}
	
		[HttpGet]
		[CacheOutput(ClientTimeSpan = 100, ServerTimeSpan = 0)]
		public HttpResponseMessage GetQuery([FromUri] string query, [FromUri] object[] parameter, [FromUri] bool indent = false, [FromUri] TiposRetorno tipoRetorno = TiposRetorno.Json) {
			try {
				var formatter = new MaxDepthJsonMediaTypeFormatter() { Indent = indent };
				formatter.SerializerSettings.MaxDepth = 1;
				List<dynamic> _listaResultados = CollectorsClubEntities.ExecuteCommand(query, Enumerable.Select(parameter, p => new SqlParameter("@" + p.ToString().Split('|')[0], (SqlDbType) Enum.Parse(typeof(SqlDbType), p.ToString().Split('|')[1], true)) { Size = (p.ToString().Split('|').Length > 3 && !string.IsNullOrEmpty(p.ToString().Split('|')[3]) ? int.Parse(p.ToString().Split('|')[3]) : 0), Value = ((p.ToString().Split('|')[2] != string.Empty ? p.ToString().Split('|')[2] : null) ?? (object) DBNull.Value) }).ToArray<SqlParameter>(), CommandType.StoredProcedure, ((Calendario_IdiomaRepository) calendario_idiomaRepository).DataContext.Database.Connection.ConnectionString);
				if (_listaResultados == null) { _listaResultados = new List<dynamic>(); }
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
	
		[HttpGet]
		[CacheOutput(ClientTimeSpan = 100, ServerTimeSpan = 0)]
		public HttpResponseMessage Get([FromUri] int Id, [FromUri] string[] include, [FromUri] bool indent = false) {
			try {
				var formatter = new MaxDepthJsonMediaTypeFormatter() { Indent = indent };
				if (include.Length > 0) {
					formatter.SerializerSettings.MaxDepth = 100; //include.Max<string>(s => s.Split('.').Length * 5);
					formatter.SerializerSettings.PreserveReferencesHandling = Newtonsoft.Json.PreserveReferencesHandling.Objects;
				} else {
					formatter.SerializerSettings.MaxDepth = 1;
				}
				Calendario_Idioma calendario_idioma = calendario_idiomaRepository.GetById(include, (p => p.Id == Id));
				if (calendario_idioma == null) { throw new HttpResponseException(HttpStatusCode.NotFound); }
				return Request.CreateResponse<Calendario_Idioma>(HttpStatusCode.OK, calendario_idioma, formatter);
			} catch (Exception _excepcion) {
				log.Error(_excepcion);
				return Request.CreateResponse(HttpStatusCode.InternalServerError, _excepcion);
			}
		}
	
		[HttpGet]
		[CacheOutput(ClientTimeSpan = 100, ServerTimeSpan = 0)]
		public HttpResponseMessage GetList([FromUri] int[] id, [FromUri] string[] include, [FromUri] bool indent = false) {
			try {
				var formatter = new MaxDepthJsonMediaTypeFormatter() { Indent = indent };
				if (include.Length > 0) {
					formatter.SerializerSettings.MaxDepth = 100; //include.Max<string>(s => s.Split('.').Length * 5);
					formatter.SerializerSettings.PreserveReferencesHandling = Newtonsoft.Json.PreserveReferencesHandling.Objects;
				} else {
					formatter.SerializerSettings.MaxDepth = 1;
				}
				return Request.CreateResponse<IEnumerable<Calendario_Idioma>>(HttpStatusCode.OK, calendario_idiomaRepository.GetMany(include, (p => id.Contains(p.Id))), formatter);
			} catch (Exception _excepcion) {
				log.Error(_excepcion);
				return Request.CreateResponse(HttpStatusCode.InternalServerError, _excepcion);
			}
		}
	
		[HttpGet]
		[CacheOutput(ClientTimeSpan = 100, ServerTimeSpan = 0)]
		public HttpResponseMessage Count() {
			try {
				return Request.CreateResponse(HttpStatusCode.OK, calendario_idiomaRepository.Count());
			} catch (Exception _excepcion) {
				log.Error(_excepcion);
				return Request.CreateResponse(HttpStatusCode.InternalServerError, _excepcion);
			}
		}
	
		[HttpGet]
		public HttpResponseMessage Modificado([FromUri] DateTime ultimaActualizacion) {
			try {
				return Request.CreateResponse(HttpStatusCode.OK, false);
			} catch (Exception _excepcion) {
				log.Error(_excepcion);
				return Request.CreateResponse(HttpStatusCode.InternalServerError, _excepcion);
			}
		}
	
		[HttpGet]
		public HttpResponseMessage Modificado(int Id) {
			try {
				return Request.CreateResponse(HttpStatusCode.OK, false);
			} catch (Exception _excepcion) {
				log.Error(_excepcion);
				return Request.CreateResponse(HttpStatusCode.InternalServerError, _excepcion);
			}
		}
	
		[CacheOutput(ClientTimeSpan = 100, ServerTimeSpan = 0)]
		public HttpResponseMessage Options() {
			try {
				return Request.CreateResponse(HttpStatusCode.OK);
			} catch (Exception _excepcion) {
				log.Error(_excepcion);
				return Request.CreateResponse(HttpStatusCode.InternalServerError, _excepcion);
			}
		}
	
		public HttpResponseMessage Post(Calendario_IdiomaModel calendario_idioma) {
			try {
				if (ModelState.IsValid) {
					if (calendario_idioma.Id == 0) {
						var command = AutoMapper.Mapper.Map<Calendario_IdiomaModel, CreateOrUpdateCalendario_IdiomaCommand>(calendario_idioma);
						var result = commandBus.Submit(command);
						if (result.Success) {
							calendario_idioma = AutoMapper.Mapper.Map<CreateOrUpdateCalendario_IdiomaCommand, Calendario_IdiomaModel>(command);
							var response = Request.CreateResponse<Calendario_IdiomaModel>(HttpStatusCode.Created, calendario_idioma);
							string uri = Url.Route(null, new { Id = calendario_idioma.Id });
							response.Headers.Location = new Uri(Request.RequestUri, uri);
							return response;
						}
					} else {
						return Request.CreateResponse(HttpStatusCode.BadRequest, "No se puede insertar el registro porque ya existe otro con la misma clave. Por favor, revísela.");
					}
				} else {
					var errors = new Dictionary<string, IEnumerable<string>>();
					foreach (var keyValue in ModelState) {
						errors[keyValue.Key] = keyValue.Value.Errors.Select(e => (!string.IsNullOrWhiteSpace(e.ErrorMessage) ? e.ErrorMessage : (e.Exception != null ? e.Exception.Message : string.Empty)));
					}
					return Request.CreateResponse(HttpStatusCode.BadRequest, errors);
				}
				throw new HttpResponseException(HttpStatusCode.BadRequest);
			} catch (Exception _excepcion) {
				log.Error(_excepcion);
				return Request.CreateResponse(HttpStatusCode.InternalServerError, _excepcion);
			}
		}
	
		public HttpResponseMessage Put(int Id, Calendario_IdiomaModel calendario_idioma) {
			try {
				if (ModelState.IsValid) {
					var command = AutoMapper.Mapper.Map<Calendario_IdiomaModel, CreateOrUpdateCalendario_IdiomaCommand>(calendario_idioma);
					var result = commandBus.Submit(command);
					return Request.CreateResponse<Calendario_IdiomaModel>(HttpStatusCode.OK, calendario_idioma);
				} else {
					var errors = new Dictionary<string, IEnumerable<string>>();
					foreach (var keyValue in ModelState) {
							errors[keyValue.Key] = keyValue.Value.Errors.Select(e => (!string.IsNullOrWhiteSpace(e.ErrorMessage) ? e.ErrorMessage : (e.Exception != null ? e.Exception.Message : string.Empty)));
					}
					return Request.CreateResponse(HttpStatusCode.BadRequest, errors);
				}
				throw new HttpResponseException(HttpStatusCode.BadRequest);
			} catch (Exception _excepcion) {
				log.Error(_excepcion);
				return Request.CreateResponse(HttpStatusCode.InternalServerError, _excepcion);
			}
		}
	
		public HttpResponseMessage Delete(int Id) {
			try {
				var command = new DeleteCalendario_IdiomaCommand(Id);
				var result = commandBus.Submit(command);
				if (!result.Success) { throw new HttpResponseException(HttpStatusCode.BadRequest); }
				return Request.CreateResponse(HttpStatusCode.OK);
			} catch (Exception _excepcion) {
				log.Error(_excepcion);
				return Request.CreateResponse(HttpStatusCode.InternalServerError, _excepcion);
			}
		}
		
		// Multiidioma
	}
}