using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using CollectorsClub.Web.API.Models;

namespace CollectorsClub.Web.API.Controllers {
	public partial class TrazaController : ApiController {
		protected static readonly log4net.ILog log = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

		public TrazaController() {
			log4net.Config.XmlConfigurator.Configure();
		}

		public HttpResponseMessage Test() {
			return Request.CreateResponse(HttpStatusCode.OK);
		}

		public HttpResponseMessage Post(TrazaModel traza) {
			try {
				switch ((TrazaModel.TiposMensaje) traza.Nivel) {
				case TrazaModel.TiposMensaje.Informativo:
					log.Info("-> Mensaje: " + traza.Mensaje + ", Excepcion: " + traza.Excepcion);
					break;
				case TrazaModel.TiposMensaje.Advertencia:
					log.Warn("-> Mensaje: " + traza.Mensaje + ", Excepcion: " + traza.Excepcion);
					break;
				case TrazaModel.TiposMensaje.Error:
					log.Error("-> Mensaje: " + traza.Mensaje + ", Excepcion: " + traza.Excepcion);
					break;
				}
				return Request.CreateResponse(HttpStatusCode.OK);
			} catch (Exception _excepcion) {
				return Request.CreateResponse(HttpStatusCode.BadRequest, _excepcion);
			}
		}
	}
}