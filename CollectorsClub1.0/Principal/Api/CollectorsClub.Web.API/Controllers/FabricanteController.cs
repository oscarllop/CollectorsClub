
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
	public partial class FabricanteController : ApiController {
		private readonly ICommandBus commandBus;
		private readonly IFabricanteRepository fabricanteRepository;
		private readonly IFabricante_IdiomaRepository fabricante_IdiomaRepository;
	  private static readonly ILog log = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
		
		public FabricanteController(ICommandBus commandBus, IFabricanteRepository fabricanteRepository, IFabricante_IdiomaRepository fabricante_IdiomaRepository) {
			this.commandBus = commandBus;
			this.fabricanteRepository = fabricanteRepository;
			this.fabricante_IdiomaRepository = fabricante_IdiomaRepository;
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
				return Request.CreateResponse<IQueryable<Fabricante>>(HttpStatusCode.OK, fabricanteRepository.GetAll(include).AsQueryable(), formatter);
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
				List<dynamic> _listaResultados = CollectorsClubEntities.ExecuteCommand(query, Enumerable.Select(parameter, p => new SqlParameter("@" + p.ToString().Split('|')[0], (SqlDbType) Enum.Parse(typeof(SqlDbType), p.ToString().Split('|')[1], true)) { Size = (p.ToString().Split('|').Length > 3 && !string.IsNullOrEmpty(p.ToString().Split('|')[3]) ? int.Parse(p.ToString().Split('|')[3]) : 0), Value = ((p.ToString().Split('|')[2] != string.Empty ? p.ToString().Split('|')[2] : null) ?? (object) DBNull.Value) }).ToArray<SqlParameter>(), CommandType.StoredProcedure, ((FabricanteRepository) fabricanteRepository).DataContext.Database.Connection.ConnectionString);
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
				return Request.CreateResponse<IQueryable<Fabricante>>(HttpStatusCode.OK, fabricanteRepository.GetMany(include, r => r.IdMarca == idMarca).AsQueryable(), formatter);
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
				return Request.CreateResponse<IEnumerable<Fabricante>>(HttpStatusCode.OK, fabricanteRepository.GetMany(include, (p => id.Contains(p.Id))), formatter);
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
				return Request.CreateResponse<IQueryable<Fabricante>>(HttpStatusCode.OK, fabricanteRepository.GetMany(r => r.IdMarca == idMarca && (nombre == null || r.Nombre.Contains(nombre))).AsQueryable(), formatter);
			} catch (Exception _excepcion) {
				log.Error(_excepcion);
				return Request.CreateResponse(HttpStatusCode.InternalServerError, _excepcion);
			}
		}
	
		[HttpGet]
		[CacheOutput(ClientTimeSpan = 100, ServerTimeSpan = 0)]
		public HttpResponseMessage Count() {
			try {
				return Request.CreateResponse(HttpStatusCode.OK, fabricanteRepository.Count());
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
				var command = new DeleteFabricanteCommand(Id);
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
				Fabricante _fabricante = fabricanteRepository.GetById(include, (p => p.Id == Id));
				if (cultura != Localizacion.CulturaPorDefecto) {
					Fabricante_Idioma _fabricanteIdioma = fabricante_IdiomaRepository.GetMany(p => p.IdRegistro == Id && p.Cultura == cultura).FirstOrDefault();
	
					// Campos multiidioma
					if (_fabricanteIdioma != null) {
						_fabricante.Nombre = _fabricanteIdioma.Nombre;
					}
				}
	
				if (_fabricante == null) { throw new HttpResponseException(HttpStatusCode.NotFound); }
				return Request.CreateResponse<Fabricante>(HttpStatusCode.OK, _fabricante, formatter);
			} catch (Exception _excepcion) {
				log.Error(_excepcion);
				return Request.CreateResponse(HttpStatusCode.InternalServerError, _excepcion);
			}
		}
	
		public HttpResponseMessage Post(string cultura, FabricanteModel fabricante) {
			try {
				if (ModelState.IsValid) {
					if (fabricante.Id == 0) {
						var command = AutoMapper.Mapper.Map<FabricanteModel, CreateOrUpdateFabricanteCommand>(fabricante);
						var result = commandBus.Submit(command);
						if (result.Success) {
							var commandIdioma = AutoMapper.Mapper.Map<Fabricante_IdiomaModel, CreateOrUpdateFabricante_IdiomaCommand>(new Fabricante_IdiomaModel { IdRegistro = command.Id, Cultura = cultura, Nombre = command.Nombre });
							var resultIdioma = commandBus.Submit(commandIdioma);
							if (resultIdioma.Success) {
								fabricante = AutoMapper.Mapper.Map<CreateOrUpdateFabricanteCommand, FabricanteModel>(command);
								var response = Request.CreateResponse<FabricanteModel>(HttpStatusCode.Created, fabricante);
								string uri = Url.Route(null, new { Id = fabricante.Id });
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
	
		public HttpResponseMessage Put(int Id, string cultura, FabricanteModel fabricante) {
			try {
				if (ModelState.IsValid) {
					if (cultura != Localizacion.CulturaPorDefecto) {
						Fabricante _fabricante = fabricanteRepository.GetById(new string[] {}, (p => p.Id == Id));
						FabricanteModel _fabricantePorDefecto = new FabricanteModel();
						// Solo funciona el Mapper si se ha configurado el Mapper con Mapper.CreateMap<EmpresaModel, EmpresaModel>(); Se está creando en la carpeta mappers.
						_fabricantePorDefecto = AutoMapper.Mapper.Map<FabricanteModel, FabricanteModel>(fabricante, _fabricantePorDefecto);
	
						_fabricantePorDefecto.Nombre = _fabricante.Nombre;
	
						var command = AutoMapper.Mapper.Map<FabricanteModel, CreateOrUpdateFabricanteCommand>(_fabricantePorDefecto);
						var result = commandBus.Submit(command);
					} else {
						var command = AutoMapper.Mapper.Map<FabricanteModel, CreateOrUpdateFabricanteCommand>(fabricante);
						var result = commandBus.Submit(command);
					}
					Fabricante_Idioma _fabricanteIdioma = fabricante_IdiomaRepository.GetMany(t => t.IdRegistro == fabricante.Id && t.Cultura == cultura).FirstOrDefault();
					var commandIdioma = AutoMapper.Mapper.Map<Fabricante_IdiomaModel, CreateOrUpdateFabricante_IdiomaCommand>(new Fabricante_IdiomaModel { Id = (_fabricanteIdioma != null ? _fabricanteIdioma.Id : (int) 0), IdRegistro = fabricante.Id, Cultura = cultura, Nombre = fabricante.Nombre });
					var resultIdioma = commandBus.Submit(commandIdioma);
					return Request.CreateResponse<FabricanteModel>(HttpStatusCode.OK, fabricante);
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