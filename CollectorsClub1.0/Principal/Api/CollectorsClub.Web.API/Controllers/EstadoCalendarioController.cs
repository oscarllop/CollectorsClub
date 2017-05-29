
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
	public partial class EstadoCalendarioController : ApiController {
		private readonly ICommandBus commandBus;
		private readonly IEstadoCalendarioRepository estadocalendarioRepository;
		private readonly IEstadoCalendario_IdiomaRepository estadocalendario_IdiomaRepository;
	  private static readonly ILog log = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
		
		public EstadoCalendarioController(ICommandBus commandBus, IEstadoCalendarioRepository estadocalendarioRepository, IEstadoCalendario_IdiomaRepository estadocalendario_IdiomaRepository) {
			this.commandBus = commandBus;
			this.estadocalendarioRepository = estadocalendarioRepository;
			this.estadocalendario_IdiomaRepository = estadocalendario_IdiomaRepository;
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
				return Request.CreateResponse<IQueryable<EstadoCalendario>>(HttpStatusCode.OK, estadocalendarioRepository.GetAll(include).AsQueryable(), formatter);
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
				List<dynamic> _listaResultados = CollectorsClubEntities.ExecuteCommand(query, Enumerable.Select(parameter, p => new SqlParameter("@" + p.ToString().Split('|')[0], (SqlDbType) Enum.Parse(typeof(SqlDbType), p.ToString().Split('|')[1], true)) { Size = (p.ToString().Split('|').Length > 3 && !string.IsNullOrEmpty(p.ToString().Split('|')[3]) ? int.Parse(p.ToString().Split('|')[3]) : 0), Value = ((p.ToString().Split('|')[2] != string.Empty ? p.ToString().Split('|')[2] : null) ?? (object) DBNull.Value) }).ToArray<SqlParameter>(), CommandType.StoredProcedure, ((EstadoCalendarioRepository) estadocalendarioRepository).DataContext.Database.Connection.ConnectionString);
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
		public HttpResponseMessage GetPorMarca([FromUri] string idMarca, [FromUri] string[] include, [FromUri] bool indent = false) {
			try {
				var formatter = new MaxDepthJsonMediaTypeFormatter() { Indent = indent };
				if (include.Length > 0) {
					formatter.SerializerSettings.MaxDepth = 100; //include.Max<string>(s => s.Split('.').Length * 5);
					formatter.SerializerSettings.PreserveReferencesHandling = Newtonsoft.Json.PreserveReferencesHandling.Objects;
				} else {
					formatter.SerializerSettings.MaxDepth = 1;
				}
				return Request.CreateResponse<IQueryable<EstadoCalendario>>(HttpStatusCode.OK, estadocalendarioRepository.GetMany(include, r => r.IdMarca == idMarca).AsQueryable(), formatter);
			} catch (Exception _excepcion) {
				log.Error(_excepcion);
				return Request.CreateResponse(HttpStatusCode.InternalServerError, _excepcion);
			}
		}
	
		[HttpGet]
		[CacheOutput(ClientTimeSpan = 100, ServerTimeSpan = 0)]
		public HttpResponseMessage GetList([FromUri] short[] id, [FromUri] string[] include, [FromUri] bool indent = false) {
			try {
				var formatter = new MaxDepthJsonMediaTypeFormatter() { Indent = indent };
				if (include.Length > 0) {
					formatter.SerializerSettings.MaxDepth = 100; //include.Max<string>(s => s.Split('.').Length * 5);
					formatter.SerializerSettings.PreserveReferencesHandling = Newtonsoft.Json.PreserveReferencesHandling.Objects;
				} else {
					formatter.SerializerSettings.MaxDepth = 1;
				}
				return Request.CreateResponse<IEnumerable<EstadoCalendario>>(HttpStatusCode.OK, estadocalendarioRepository.GetMany(include, (p => id.Contains(p.Id))), formatter);
			} catch (Exception _excepcion) {
				log.Error(_excepcion);
				return Request.CreateResponse(HttpStatusCode.InternalServerError, _excepcion);
			}
		}
	
		[HttpGet]
		[CacheOutput(ClientTimeSpan = 100, ServerTimeSpan = 0)]
		public HttpResponseMessage GetPorFiltros(string idMarca, string nombre, [FromUri] string[] include, [FromUri] bool indent = false) {
			try {
				var formatter = new MaxDepthJsonMediaTypeFormatter() { Indent = indent };
				if (include.Length > 0) {
					formatter.SerializerSettings.MaxDepth = 100; //include.Max<string>(s => s.Split('.').Length * 5);
					formatter.SerializerSettings.PreserveReferencesHandling = Newtonsoft.Json.PreserveReferencesHandling.Objects;
				} else {
					formatter.SerializerSettings.MaxDepth = 1;
				}
				return Request.CreateResponse<IQueryable<EstadoCalendario>>(HttpStatusCode.OK, estadocalendarioRepository.GetMany(r => r.IdMarca == idMarca && (nombre == null || r.Nombre.Contains(nombre))).AsQueryable(), formatter);
			} catch (Exception _excepcion) {
				log.Error(_excepcion);
				return Request.CreateResponse(HttpStatusCode.InternalServerError, _excepcion);
			}
		}
	
		[HttpGet]
		[CacheOutput(ClientTimeSpan = 100, ServerTimeSpan = 0)]
		public HttpResponseMessage Count() {
			try {
				return Request.CreateResponse(HttpStatusCode.OK, estadocalendarioRepository.Count());
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
		public HttpResponseMessage Modificado(short Id) {
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
	
		public HttpResponseMessage Delete(short Id) {
			try {
				var command = new DeleteEstadoCalendarioCommand(Id);
				var result = commandBus.Submit(command);
				if (!result.Success) { throw new HttpResponseException(HttpStatusCode.BadRequest); }
				return Request.CreateResponse(HttpStatusCode.OK);
			} catch (Exception _excepcion) {
				log.Error(_excepcion);
				return Request.CreateResponse(HttpStatusCode.InternalServerError, _excepcion);
			}
		}
		
		// Multiidioma
		[HttpGet]
		[CacheOutput(ClientTimeSpan = 100, ServerTimeSpan = 0)]
		public HttpResponseMessage Get([FromUri] short Id, [FromUri] string cultura, [FromUri] string[] include, [FromUri] bool indent = false) {
			try {
				var formatter = new MaxDepthJsonMediaTypeFormatter() { Indent = indent };
				if (include.Length > 0) {
					formatter.SerializerSettings.MaxDepth = 100; //include.Max<string>(s => s.Split('.').Length * 5);
					formatter.SerializerSettings.PreserveReferencesHandling = Newtonsoft.Json.PreserveReferencesHandling.Objects;
				} else {
					formatter.SerializerSettings.MaxDepth = 1;
				}
				EstadoCalendario _estadocalendario = estadocalendarioRepository.GetById(include, (p => p.Id == Id));
				if (cultura != Localizacion.CulturaPorDefecto) {
					EstadoCalendario_Idioma _estadocalendarioIdioma = estadocalendario_IdiomaRepository.GetMany(p => p.IdRegistro == Id && p.Cultura == cultura).FirstOrDefault();
	
					// Campos multiidioma
					if (_estadocalendarioIdioma != null) {
						_estadocalendario.Nombre = _estadocalendarioIdioma.Nombre;
					}
				}
	
				if (_estadocalendario == null) { throw new HttpResponseException(HttpStatusCode.NotFound); }
				return Request.CreateResponse<EstadoCalendario>(HttpStatusCode.OK, _estadocalendario, formatter);
			} catch (Exception _excepcion) {
				log.Error(_excepcion);
				return Request.CreateResponse(HttpStatusCode.InternalServerError, _excepcion);
			}
		}
	
		public HttpResponseMessage Post(string cultura, EstadoCalendarioModel estadocalendario) {
			try {
				if (ModelState.IsValid) {
					if (estadocalendario.Id == 0) {
						var command = AutoMapper.Mapper.Map<EstadoCalendarioModel, CreateOrUpdateEstadoCalendarioCommand>(estadocalendario);
						var result = commandBus.Submit(command);
						if (result.Success) {
							var commandIdioma = AutoMapper.Mapper.Map<EstadoCalendario_IdiomaModel, CreateOrUpdateEstadoCalendario_IdiomaCommand>(new EstadoCalendario_IdiomaModel { IdRegistro = command.Id, Cultura = cultura, Nombre = command.Nombre });
							var resultIdioma = commandBus.Submit(commandIdioma);
							if (resultIdioma.Success) {
								estadocalendario = AutoMapper.Mapper.Map<CreateOrUpdateEstadoCalendarioCommand, EstadoCalendarioModel>(command);
								var response = Request.CreateResponse<EstadoCalendarioModel>(HttpStatusCode.Created, estadocalendario);
								string uri = Url.Route(null, new { Id = estadocalendario.Id });
								response.Headers.Location = new Uri(Request.RequestUri, uri);
								return response;
							}
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
	
		public HttpResponseMessage Put(short Id, string cultura, EstadoCalendarioModel estadocalendario) {
			try {
				if (ModelState.IsValid) {
					if (cultura != Localizacion.CulturaPorDefecto) {
						EstadoCalendario _estadocalendario = estadocalendarioRepository.GetById(new string[] {}, (p => p.Id == Id));
						EstadoCalendarioModel _estadocalendarioPorDefecto = new EstadoCalendarioModel();
						// Solo funciona el Mapper si se ha configurado el Mapper con Mapper.CreateMap<EmpresaModel, EmpresaModel>(); Se está creando en la carpeta mappers.
						_estadocalendarioPorDefecto = AutoMapper.Mapper.Map<EstadoCalendarioModel, EstadoCalendarioModel>(estadocalendario, _estadocalendarioPorDefecto);
	
						_estadocalendarioPorDefecto.Nombre = _estadocalendario.Nombre;
	
						var command = AutoMapper.Mapper.Map<EstadoCalendarioModel, CreateOrUpdateEstadoCalendarioCommand>(_estadocalendarioPorDefecto);
						var result = commandBus.Submit(command);
					} else {
						var command = AutoMapper.Mapper.Map<EstadoCalendarioModel, CreateOrUpdateEstadoCalendarioCommand>(estadocalendario);
						var result = commandBus.Submit(command);
					}
					EstadoCalendario_Idioma _estadocalendarioIdioma = estadocalendario_IdiomaRepository.GetMany(t => t.IdRegistro == estadocalendario.Id && t.Cultura == cultura).FirstOrDefault();
					var commandIdioma = AutoMapper.Mapper.Map<EstadoCalendario_IdiomaModel, CreateOrUpdateEstadoCalendario_IdiomaCommand>(new EstadoCalendario_IdiomaModel { Id = (_estadocalendarioIdioma != null ? _estadocalendarioIdioma.Id : (short) 0), IdRegistro = estadocalendario.Id, Cultura = cultura, Nombre = estadocalendario.Nombre });
					var resultIdioma = commandBus.Submit(commandIdioma);
					return Request.CreateResponse<EstadoCalendarioModel>(HttpStatusCode.OK, estadocalendario);
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
	}
}