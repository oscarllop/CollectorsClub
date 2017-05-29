
using CollectorsClub.Model.Commands;
using CollectorsClub.Model.Entities;
using CollectorsClub.Web.API.App_Code;
using CollectorsClub.Web.API.Models;
using Core.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using WebApi.OutputCache.V2;

namespace CollectorsClub.Web.API.Controllers {

	public partial class SolicitudContactoController : ApiController {

		[HttpPost]
		public HttpResponseMessage PostExtension(SolicitudContactoModel solicitudcontacto) {
			try {
				if (ModelState.IsValid) {
					if (solicitudcontacto.Id == 0) {
						var command = AutoMapper.Mapper.Map<SolicitudContactoModel, CreateOrUpdateSolicitudContactoCommand>(solicitudcontacto);
						var result = commandBus.Submit(command);
						if (result.Success) {
							solicitudcontacto = AutoMapper.Mapper.Map<CreateOrUpdateSolicitudContactoCommand, SolicitudContactoModel>(command);

							string _contenido = ConfigurationManager.AppSettings["SolicitudContacto_Contenido"];
							_contenido = _contenido.Replace("%%SolicitudContacto.Id%%", solicitudcontacto.Id.ToString());
							_contenido = _contenido.Replace("%%SolicitudContacto.Nombre%%", solicitudcontacto.Nombre);
							_contenido = _contenido.Replace("%%SolicitudContacto.CorreoElectronico%%", solicitudcontacto.CorreoElectronico);
							_contenido = _contenido.Replace("%%SolicitudContacto.Asunto%%", solicitudcontacto.Asunto);
							_contenido = _contenido.Replace("%%SolicitudContacto.Contenido%%", solicitudcontacto.Contenido);
							Mailing.EnviarEmailAccion(ConfigurationManager.AppSettings["SolicitudContacto_De"], ConfigurationManager.AppSettings["SolicitudContacto_Para"], ConfigurationManager.AppSettings["SolicitudContacto_Asunto"], _contenido, null);

							var response = Request.CreateResponse<SolicitudContactoModel>(HttpStatusCode.Created, solicitudcontacto);
							string uri = Url.Route(null, new { Id = solicitudcontacto.Id });
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
	}
}