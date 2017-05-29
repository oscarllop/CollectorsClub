
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
	public partial class MarcaController : ApiController {
		private readonly ICommandBus commandBus;
		private readonly IMarcaRepository marcaRepository;
	  private static readonly ILog log = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
		
		public MarcaController(ICommandBus commandBus, IMarcaRepository marcaRepository) {
			this.commandBus = commandBus;
			this.marcaRepository = marcaRepository;
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
				return Request.CreateResponse<IQueryable<Marca>>(HttpStatusCode.OK, marcaRepository.GetAll(include).AsQueryable(), formatter);
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
				List<dynamic> _listaResultados = CollectorsClubEntities.ExecuteCommand(query, Enumerable.Select(parameter, p => new SqlParameter("@" + p.ToString().Split('|')[0], (SqlDbType) Enum.Parse(typeof(SqlDbType), p.ToString().Split('|')[1], true)) { Size = (p.ToString().Split('|').Length > 3 && !string.IsNullOrEmpty(p.ToString().Split('|')[3]) ? int.Parse(p.ToString().Split('|')[3]) : 0), Value = ((p.ToString().Split('|')[2] != string.Empty ? p.ToString().Split('|')[2] : null) ?? (object) DBNull.Value) }).ToArray<SqlParameter>(), CommandType.StoredProcedure, ((MarcaRepository) marcaRepository).DataContext.Database.Connection.ConnectionString);
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
		public HttpResponseMessage Get([FromUri] string Id, [FromUri] string[] include, [FromUri] bool indent = false) {
			try {
				var formatter = new MaxDepthJsonMediaTypeFormatter() { Indent = indent };
				if (include.Length > 0) {
					formatter.SerializerSettings.MaxDepth = 100; //include.Max<string>(s => s.Split('.').Length * 5);
					formatter.SerializerSettings.PreserveReferencesHandling = Newtonsoft.Json.PreserveReferencesHandling.Objects;
				} else {
					formatter.SerializerSettings.MaxDepth = 1;
				}
				Marca marca = marcaRepository.GetById(include, (p => p.Id == Id));
				if (marca == null) { throw new HttpResponseException(HttpStatusCode.NotFound); }
				return Request.CreateResponse<Marca>(HttpStatusCode.OK, marca, formatter);
			} catch (Exception _excepcion) {
				log.Error(_excepcion);
				return Request.CreateResponse(HttpStatusCode.InternalServerError, _excepcion);
			}
		}
	
		[HttpGet]
		[CacheOutput(ClientTimeSpan = 100, ServerTimeSpan = 0)]
		public HttpResponseMessage GetList([FromUri] string[] id, [FromUri] string[] include, [FromUri] bool indent = false) {
			try {
				var formatter = new MaxDepthJsonMediaTypeFormatter() { Indent = indent };
				if (include.Length > 0) {
					formatter.SerializerSettings.MaxDepth = 100; //include.Max<string>(s => s.Split('.').Length * 5);
					formatter.SerializerSettings.PreserveReferencesHandling = Newtonsoft.Json.PreserveReferencesHandling.Objects;
				} else {
					formatter.SerializerSettings.MaxDepth = 1;
				}
				return Request.CreateResponse<IEnumerable<Marca>>(HttpStatusCode.OK, marcaRepository.GetMany(include, (p => id.Contains(p.Id))), formatter);
			} catch (Exception _excepcion) {
				log.Error(_excepcion);
				return Request.CreateResponse(HttpStatusCode.InternalServerError, _excepcion);
			}
		}
	
		[HttpGet]
		[CacheOutput(ClientTimeSpan = 100, ServerTimeSpan = 0)]
		public HttpResponseMessage Count() {
			try {
				return Request.CreateResponse(HttpStatusCode.OK, marcaRepository.Count());
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
		public HttpResponseMessage Modificado(string Id) {
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
	
		public HttpResponseMessage Post(MarcaModel marca) {
			try {
				if (ModelState.IsValid) {
					if (!marcaRepository.Exist(p => p.Id == marca.Id)) {
						var command = AutoMapper.Mapper.Map<MarcaModel, CreateOrUpdateMarcaCommand>(marca);
						var result = commandBus.Submit(command);
						if (result.Success) {
							marca = AutoMapper.Mapper.Map<CreateOrUpdateMarcaCommand, MarcaModel>(command);
							var response = Request.CreateResponse<MarcaModel>(HttpStatusCode.Created, marca);
							string uri = Url.Route(null, new { Id = marca.Id });
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
	
		public HttpResponseMessage Put(string Id, MarcaModel marca) {
			try {
				if (ModelState.IsValid) {
					var command = AutoMapper.Mapper.Map<MarcaModel, CreateOrUpdateMarcaCommand>(marca);
					var result = commandBus.Submit(command);
					return Request.CreateResponse<MarcaModel>(HttpStatusCode.OK, marca);
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
	
		public HttpResponseMessage Delete(string Id) {
			try {
				var command = new DeleteMarcaCommand(Id);
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