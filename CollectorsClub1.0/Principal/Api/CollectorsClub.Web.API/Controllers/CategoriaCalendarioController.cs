
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
	public partial class CategoriaCalendarioController : ApiController {
		private readonly ICommandBus commandBus;
		private readonly ICategoriaCalendarioRepository categoriacalendarioRepository;
		private readonly ICategoriaCalendario_IdiomaRepository categoriacalendario_IdiomaRepository;
	  private static readonly ILog log = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
		
		public CategoriaCalendarioController(ICommandBus commandBus, ICategoriaCalendarioRepository categoriacalendarioRepository, ICategoriaCalendario_IdiomaRepository categoriacalendario_IdiomaRepository) {
			this.commandBus = commandBus;
			this.categoriacalendarioRepository = categoriacalendarioRepository;
			this.categoriacalendario_IdiomaRepository = categoriacalendario_IdiomaRepository;
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
				return Request.CreateResponse<IQueryable<CategoriaCalendario>>(HttpStatusCode.OK, categoriacalendarioRepository.GetAll(include).AsQueryable(), formatter);
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
				List<dynamic> _listaResultados = CollectorsClubEntities.ExecuteCommand(query, Enumerable.Select(parameter, p => new SqlParameter("@" + p.ToString().Split('|')[0], (SqlDbType) Enum.Parse(typeof(SqlDbType), p.ToString().Split('|')[1], true)) { Size = (p.ToString().Split('|').Length > 3 && !string.IsNullOrEmpty(p.ToString().Split('|')[3]) ? int.Parse(p.ToString().Split('|')[3]) : 0), Value = ((p.ToString().Split('|')[2] != string.Empty ? p.ToString().Split('|')[2] : null) ?? (object) DBNull.Value) }).ToArray<SqlParameter>(), CommandType.StoredProcedure, ((CategoriaCalendarioRepository) categoriacalendarioRepository).DataContext.Database.Connection.ConnectionString);
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
				return Request.CreateResponse<IQueryable<CategoriaCalendario>>(HttpStatusCode.OK, categoriacalendarioRepository.GetMany(include, r => r.IdMarca == idMarca).AsQueryable(), formatter);
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
				return Request.CreateResponse<IEnumerable<CategoriaCalendario>>(HttpStatusCode.OK, categoriacalendarioRepository.GetMany(include, (p => id.Contains(p.Id))), formatter);
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
				return Request.CreateResponse<IQueryable<CategoriaCalendario>>(HttpStatusCode.OK, categoriacalendarioRepository.GetMany(r => r.IdMarca == idMarca && (nombre == null || r.Nombre.Contains(nombre))).AsQueryable(), formatter);
			} catch (Exception _excepcion) {
				log.Error(_excepcion);
				return Request.CreateResponse(HttpStatusCode.InternalServerError, _excepcion);
			}
		}
	
		[HttpGet]
		[CacheOutput(ClientTimeSpan = 100, ServerTimeSpan = 0)]
		public HttpResponseMessage Count() {
			try {
				return Request.CreateResponse(HttpStatusCode.OK, categoriacalendarioRepository.Count());
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
				var command = new DeleteCategoriaCalendarioCommand(Id);
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
				CategoriaCalendario _categoriacalendario = categoriacalendarioRepository.GetById(include, (p => p.Id == Id));
				if (cultura != Localizacion.CulturaPorDefecto) {
					CategoriaCalendario_Idioma _categoriacalendarioIdioma = categoriacalendario_IdiomaRepository.GetMany(p => p.IdRegistro == Id && p.Cultura == cultura).FirstOrDefault();
	
					// Campos multiidioma
					if (_categoriacalendarioIdioma != null) {
						_categoriacalendario.Nombre = _categoriacalendarioIdioma.Nombre;
					}
				}
	
				if (_categoriacalendario == null) { throw new HttpResponseException(HttpStatusCode.NotFound); }
				return Request.CreateResponse<CategoriaCalendario>(HttpStatusCode.OK, _categoriacalendario, formatter);
			} catch (Exception _excepcion) {
				log.Error(_excepcion);
				return Request.CreateResponse(HttpStatusCode.InternalServerError, _excepcion);
			}
		}
	
		public HttpResponseMessage Post(string cultura, CategoriaCalendarioModel categoriacalendario) {
			try {
				if (ModelState.IsValid) {
					if (categoriacalendario.Id == 0) {
						var command = AutoMapper.Mapper.Map<CategoriaCalendarioModel, CreateOrUpdateCategoriaCalendarioCommand>(categoriacalendario);
						var result = commandBus.Submit(command);
						if (result.Success) {
							var commandIdioma = AutoMapper.Mapper.Map<CategoriaCalendario_IdiomaModel, CreateOrUpdateCategoriaCalendario_IdiomaCommand>(new CategoriaCalendario_IdiomaModel { IdRegistro = command.Id, Cultura = cultura, Nombre = command.Nombre });
							var resultIdioma = commandBus.Submit(commandIdioma);
							if (resultIdioma.Success) {
								categoriacalendario = AutoMapper.Mapper.Map<CreateOrUpdateCategoriaCalendarioCommand, CategoriaCalendarioModel>(command);
								var response = Request.CreateResponse<CategoriaCalendarioModel>(HttpStatusCode.Created, categoriacalendario);
								string uri = Url.Route(null, new { Id = categoriacalendario.Id });
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
	
		public HttpResponseMessage Put(short Id, string cultura, CategoriaCalendarioModel categoriacalendario) {
			try {
				if (ModelState.IsValid) {
					if (cultura != Localizacion.CulturaPorDefecto) {
						CategoriaCalendario _categoriacalendario = categoriacalendarioRepository.GetById(new string[] {}, (p => p.Id == Id));
						CategoriaCalendarioModel _categoriacalendarioPorDefecto = new CategoriaCalendarioModel();
						// Solo funciona el Mapper si se ha configurado el Mapper con Mapper.CreateMap<EmpresaModel, EmpresaModel>(); Se está creando en la carpeta mappers.
						_categoriacalendarioPorDefecto = AutoMapper.Mapper.Map<CategoriaCalendarioModel, CategoriaCalendarioModel>(categoriacalendario, _categoriacalendarioPorDefecto);
	
						_categoriacalendarioPorDefecto.Nombre = _categoriacalendario.Nombre;
	
						var command = AutoMapper.Mapper.Map<CategoriaCalendarioModel, CreateOrUpdateCategoriaCalendarioCommand>(_categoriacalendarioPorDefecto);
						var result = commandBus.Submit(command);
					} else {
						var command = AutoMapper.Mapper.Map<CategoriaCalendarioModel, CreateOrUpdateCategoriaCalendarioCommand>(categoriacalendario);
						var result = commandBus.Submit(command);
					}
					CategoriaCalendario_Idioma _categoriacalendarioIdioma = categoriacalendario_IdiomaRepository.GetMany(t => t.IdRegistro == categoriacalendario.Id && t.Cultura == cultura).FirstOrDefault();
					var commandIdioma = AutoMapper.Mapper.Map<CategoriaCalendario_IdiomaModel, CreateOrUpdateCategoriaCalendario_IdiomaCommand>(new CategoriaCalendario_IdiomaModel { Id = (_categoriacalendarioIdioma != null ? _categoriacalendarioIdioma.Id : (short) 0), IdRegistro = categoriacalendario.Id, Cultura = cultura, Nombre = categoriacalendario.Nombre });
					var resultIdioma = commandBus.Submit(commandIdioma);
					return Request.CreateResponse<CategoriaCalendarioModel>(HttpStatusCode.OK, categoriacalendario);
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