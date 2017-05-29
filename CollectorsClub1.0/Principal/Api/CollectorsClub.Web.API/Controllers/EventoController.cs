
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
	public partial class EventoController : ApiController {
		private readonly ICommandBus commandBus;
		private readonly IEventoRepository eventoRepository;
		private readonly IEvento_IdiomaRepository evento_IdiomaRepository;
	  private static readonly ILog log = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
		
		public EventoController(ICommandBus commandBus, IEventoRepository eventoRepository, IEvento_IdiomaRepository evento_IdiomaRepository) {
			this.commandBus = commandBus;
			this.eventoRepository = eventoRepository;
			this.evento_IdiomaRepository = evento_IdiomaRepository;
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
				return Request.CreateResponse<IQueryable<Evento>>(HttpStatusCode.OK, eventoRepository.GetAll(include).AsQueryable(), formatter);
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
				List<dynamic> _listaResultados = CollectorsClubEntities.ExecuteCommand(query, Enumerable.Select(parameter, p => new SqlParameter("@" + p.ToString().Split('|')[0], (SqlDbType) Enum.Parse(typeof(SqlDbType), p.ToString().Split('|')[1], true)) { Size = (p.ToString().Split('|').Length > 3 && !string.IsNullOrEmpty(p.ToString().Split('|')[3]) ? int.Parse(p.ToString().Split('|')[3]) : 0), Value = ((p.ToString().Split('|')[2] != string.Empty ? p.ToString().Split('|')[2] : null) ?? (object) DBNull.Value) }).ToArray<SqlParameter>(), CommandType.StoredProcedure, ((EventoRepository) eventoRepository).DataContext.Database.Connection.ConnectionString);
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
				return Request.CreateResponse<IQueryable<Evento>>(HttpStatusCode.OK, eventoRepository.GetMany(include, r => r.IdMarca == idMarca).AsQueryable(), formatter);
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
				return Request.CreateResponse<IEnumerable<Evento>>(HttpStatusCode.OK, eventoRepository.GetMany(include, (p => id.Contains(p.Id))), formatter);
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
				return Request.CreateResponse<IQueryable<Evento>>(HttpStatusCode.OK, eventoRepository.GetMany(r => r.IdMarca == idMarca && (nombre == null || r.Nombre.Contains(nombre))).AsQueryable(), formatter);
			} catch (Exception _excepcion) {
				log.Error(_excepcion);
				return Request.CreateResponse(HttpStatusCode.InternalServerError, _excepcion);
			}
		}
	
		[HttpGet]
		[CacheOutput(ClientTimeSpan = 100, ServerTimeSpan = 0)]
		public HttpResponseMessage Count() {
			try {
				return Request.CreateResponse(HttpStatusCode.OK, eventoRepository.Count());
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
	
		public HttpResponseMessage Delete(int Id) {
			try {
				var command = new DeleteEventoCommand(Id);
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
		public HttpResponseMessage Get([FromUri] int Id, [FromUri] string cultura, [FromUri] string[] include, [FromUri] bool indent = false) {
			try {
				var formatter = new MaxDepthJsonMediaTypeFormatter() { Indent = indent };
				if (include.Length > 0) {
					formatter.SerializerSettings.MaxDepth = 100; //include.Max<string>(s => s.Split('.').Length * 5);
					formatter.SerializerSettings.PreserveReferencesHandling = Newtonsoft.Json.PreserveReferencesHandling.Objects;
				} else {
					formatter.SerializerSettings.MaxDepth = 1;
				}
				Evento _evento = eventoRepository.GetById(include, (p => p.Id == Id));
				if (cultura != Localizacion.CulturaPorDefecto) {
					Evento_Idioma _eventoIdioma = evento_IdiomaRepository.GetMany(p => p.IdRegistro == Id && p.Cultura == cultura).FirstOrDefault();
	
					// Campos multiidioma
					if (_eventoIdioma != null) {
						_evento.Ubicacion = _eventoIdioma.Ubicacion;
						_evento.Nombre = _eventoIdioma.Nombre;
						_evento.Descripcion = _eventoIdioma.Descripcion;
					}
				}
	
				if (_evento == null) { throw new HttpResponseException(HttpStatusCode.NotFound); }
				return Request.CreateResponse<Evento>(HttpStatusCode.OK, _evento, formatter);
			} catch (Exception _excepcion) {
				log.Error(_excepcion);
				return Request.CreateResponse(HttpStatusCode.InternalServerError, _excepcion);
			}
		}
	
		public HttpResponseMessage Post(string cultura, EventoModel evento) {
			try {
				if (ModelState.IsValid) {
					if (evento.Id == 0) {
						var command = AutoMapper.Mapper.Map<EventoModel, CreateOrUpdateEventoCommand>(evento);
						var result = commandBus.Submit(command);
						if (result.Success) {
							var commandIdioma = AutoMapper.Mapper.Map<Evento_IdiomaModel, CreateOrUpdateEvento_IdiomaCommand>(new Evento_IdiomaModel { IdRegistro = command.Id, Cultura = cultura, Ubicacion = command.Ubicacion, Nombre = command.Nombre, Descripcion = command.Descripcion });
							var resultIdioma = commandBus.Submit(commandIdioma);
							if (resultIdioma.Success) {
								evento = AutoMapper.Mapper.Map<CreateOrUpdateEventoCommand, EventoModel>(command);
								var response = Request.CreateResponse<EventoModel>(HttpStatusCode.Created, evento);
								string uri = Url.Route(null, new { Id = evento.Id });
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
	
		public HttpResponseMessage Put(int Id, string cultura, EventoModel evento) {
			try {
				if (ModelState.IsValid) {
					if (cultura != Localizacion.CulturaPorDefecto) {
						Evento _evento = eventoRepository.GetById(new string[] {}, (p => p.Id == Id));
						EventoModel _eventoPorDefecto = new EventoModel();
						// Solo funciona el Mapper si se ha configurado el Mapper con Mapper.CreateMap<EmpresaModel, EmpresaModel>(); Se está creando en la carpeta mappers.
						_eventoPorDefecto = AutoMapper.Mapper.Map<EventoModel, EventoModel>(evento, _eventoPorDefecto);
	
						_eventoPorDefecto.Ubicacion = _evento.Ubicacion;
						_eventoPorDefecto.Nombre = _evento.Nombre;
						_eventoPorDefecto.Descripcion = _evento.Descripcion;
	
						var command = AutoMapper.Mapper.Map<EventoModel, CreateOrUpdateEventoCommand>(_eventoPorDefecto);
						var result = commandBus.Submit(command);
					} else {
						var command = AutoMapper.Mapper.Map<EventoModel, CreateOrUpdateEventoCommand>(evento);
						var result = commandBus.Submit(command);
					}
					Evento_Idioma _eventoIdioma = evento_IdiomaRepository.GetMany(t => t.IdRegistro == evento.Id && t.Cultura == cultura).FirstOrDefault();
					var commandIdioma = AutoMapper.Mapper.Map<Evento_IdiomaModel, CreateOrUpdateEvento_IdiomaCommand>(new Evento_IdiomaModel { Id = (_eventoIdioma != null ? _eventoIdioma.Id : (int) 0), IdRegistro = evento.Id, Cultura = cultura, Ubicacion = evento.Ubicacion, Nombre = evento.Nombre, Descripcion = evento.Descripcion });
					var resultIdioma = commandBus.Submit(commandIdioma);
					return Request.CreateResponse<EventoModel>(HttpStatusCode.OK, evento);
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