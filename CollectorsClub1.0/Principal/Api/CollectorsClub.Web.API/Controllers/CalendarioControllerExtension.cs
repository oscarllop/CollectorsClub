
using CollectorsClub.Data.Dispatcher;
using CollectorsClub.Data.Infrastructure;
using CollectorsClub.Model.Commands;
using CollectorsClub.Model.Entities;
using CollectorsClub.Model.Repositories;
using CollectorsClub.Web.API.App_Code;
using CollectorsClub.Web.API.Models;
using Core.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using WebApi.OutputCache.V2;

namespace CollectorsClub.Web.API.Controllers {

	public partial class CalendarioController : ApiController {

		private IUnitOfWork Uow;

		public CalendarioController(ICommandBus commandBus, ICalendarioRepository calendarioRepository, ICalendario_IdiomaRepository calendario_IdiomaRepository, IUnitOfWork uow) {
			this.commandBus = commandBus;
			this.calendarioRepository = calendarioRepository;
			this.calendario_IdiomaRepository = calendario_IdiomaRepository;
			this.Uow = uow;
			log4net.Config.XmlConfigurator.Configure();
		}

		[HttpGet]
		public HttpResponseMessage LocalizarImagenesAnt() {
			try {
				string _rutaInicial = "G:\\Joan Carles\\Imatges\\COMERCIALES ESCAN";
				List<string> _mensajes = new List<string>();
				int _calendariosLozalizados = 0;
				List<Calendario> _calendarios = calendarioRepository.GetAll(new string[] { "Categoria", "SubCategoria", "Entidad" }).ToList();
				foreach (Calendario _calendario in _calendarios) {
					string _entidad = _calendario.Entidad.Nombre.Replace("\"", string.Empty);
					string _nombreArchivo = _entidad;
					string _variante = _calendario.Variante;
					if (_variante == "Castellano") { _variante = " Cast"; }
					if (_variante == "Català") { _variante = "Cat"; }
					string _carpetaCategoria = string.Empty; //_calendario.Categoria.Nombre;
					string _carpetaSubCategoria = Path.DirectorySeparatorChar + _calendario.Subcategoria.Nombre;

					string _numeroSerie = string.Empty;
					if (_calendario.NumeroSerie != null) {
						int _numeroSerieNumerico = -1;
						int.TryParse(_calendario.NumeroSerie, out _numeroSerieNumerico);
						if (_numeroSerieNumerico != -1) { _numeroSerie = " " + _numeroSerieNumerico; }
					}
					short _numeroCombinacion = 1;
					string _propuestaRuta = GenerarPropuesta(_numeroCombinacion, _rutaInicial, _carpetaCategoria, _carpetaSubCategoria, _entidad, _calendario.Anyo, _nombreArchivo, _variante, _numeroSerie);
					while (!File.Exists(_propuestaRuta) && _numeroCombinacion < 28) {
						_propuestaRuta = GenerarPropuesta(++_numeroCombinacion, _rutaInicial, _carpetaCategoria, _carpetaSubCategoria, _entidad, _calendario.Anyo, _nombreArchivo, _variante, _numeroSerie);
					}
					if (!File.Exists(_propuestaRuta)) {
						if (_calendario.NumeroSerie != null) {
							int _numeroSerieNumerico = -1;
							int.TryParse(_calendario.NumeroSerie, out _numeroSerieNumerico);
							if (_numeroSerieNumerico != -1) { _numeroSerie = " " + _numeroSerieNumerico.ToString("000"); }
						}
						_numeroCombinacion = 1;
						_propuestaRuta = GenerarPropuesta(_numeroCombinacion, _rutaInicial, _carpetaCategoria, _carpetaSubCategoria, _entidad, _calendario.Anyo, _nombreArchivo, _variante, _numeroSerie);
						while (!File.Exists(_propuestaRuta) && _numeroCombinacion < 28) {
							_propuestaRuta = GenerarPropuesta(++_numeroCombinacion, _rutaInicial, _carpetaCategoria, _carpetaSubCategoria, _entidad, _calendario.Anyo, _nombreArchivo, _variante, _numeroSerie);
						}
					}

					if (File.Exists(_propuestaRuta)) { _calendariosLozalizados++; } else {
						_mensajes.Add(string.Format("{0}-{1}: <b>{2}</b>", _calendario.Id, _propuestaRuta, File.Exists(_propuestaRuta)));
					}
				}
				_mensajes.Insert(0, string.Format("Se ha localizado {0} de {1} calendarios. {2}%", _calendariosLozalizados, _calendarios.Count, ((double)_calendariosLozalizados / _calendarios.Count) * 100));

				return Request.CreateResponse<List<string>>(HttpStatusCode.OK, _mensajes);
			} catch (Exception _excepcion) {
				log.Error(_excepcion);
				return Request.CreateResponse(HttpStatusCode.InternalServerError, _excepcion);
			}
		}

		[HttpGet]
		public HttpResponseMessage LocalizarImagenes() {
			try {
				string _rutaInicial = ConfigurationManager.AppSettings["RutaImagenes"];
				List<string> _mensajes = new List<string>();
				int _calendariosLozalizados = 0;
				List<Calendario> _calendarios = calendarioRepository.GetAll(new string[] { "TipoColeccionCalendario", "Categoria", "SubCategoria", "Entidad" }).ToList();
				foreach (Calendario _calendario in _calendarios) {
					string _carpetatipoColeccion = Utilidades.RevisarNombreSistemaArchivos(_calendario.TipoColeccionCalendario.Nombre);
					string _entidad = Utilidades.RevisarNombreSistemaArchivos(_calendario.Entidad.Nombre);
					string _nombreArchivo = _entidad;
					string _variante = Utilidades.RevisarNombreSistemaArchivos(_calendario.Variante);
					if (_variante == "Castellano") { _variante = "Cast"; }
					if (_variante == "Català") { _variante = "Cat"; }
					if (!string.IsNullOrEmpty(_variante)) { _variante = " " + _variante; }
					string _carpetaCategoria = Path.DirectorySeparatorChar + Utilidades.RevisarNombreSistemaArchivos(_calendario.Categoria.Nombre);
					string _carpetaSubCategoria = Path.DirectorySeparatorChar + Utilidades.RevisarNombreSistemaArchivos(_calendario.Subcategoria.Nombre);

					string _numeroSerie = string.Empty;
					if (_calendario.NumeroSerie != null) {
						int _numeroSerieNumerico = -1;
						int.TryParse(_calendario.NumeroSerie, out _numeroSerieNumerico);
						if (_numeroSerieNumerico != -1) { _numeroSerie = " " + _numeroSerieNumerico.ToString("000"); }
					}
					string _propuestaRuta = string.Format("{0}{1}{2}\\{3}\\{4} {5}{6}{7}.jpg", _rutaInicial + Path.DirectorySeparatorChar + _carpetatipoColeccion, _carpetaCategoria, _carpetaSubCategoria, _entidad, _calendario.Anyo, _nombreArchivo, _variante, _numeroSerie);

					if (File.Exists(_propuestaRuta)) {
						_calendario.Imagen = _propuestaRuta.Replace(_rutaInicial, string.Empty).Replace(Path.DirectorySeparatorChar, Path.AltDirectorySeparatorChar);
						calendarioRepository.Update(_calendario);
						_calendariosLozalizados++;
					} else {
						_mensajes.Add(string.Format("{0}-{1}: <b>{2}</b>", _calendario.Id, _propuestaRuta, File.Exists(_propuestaRuta)));
					}
				}
				Uow.Commit();
				_mensajes.Insert(0, string.Format("Se ha localizado {0} de {1} calendarios. {2}%", _calendariosLozalizados, _calendarios.Count, ((double)_calendariosLozalizados / _calendarios.Count) * 100));

				return Request.CreateResponse<List<string>>(HttpStatusCode.OK, _mensajes);
			} catch (Exception _excepcion) {
				log.Error(_excepcion);
				return Request.CreateResponse(HttpStatusCode.InternalServerError, _excepcion);
			}
		}

		private string GenerarPropuesta(short numero, string rutaInicial, string carpetaCategoria, string carpetaSubCategoria, string entidad, string anyo, string nombreArchivo, string variante, string numeroSerie) {
			switch (carpetaSubCategoria.Substring(1)) {
				case "Caja Rural":
				case "Bancos-Cajas":
				case "Bancos":
					switch (numero) {
						case 1: return string.Format("{0}{1}{2}\\A Conf\\{3}\\{4} {5}{6}{7}.jpg", rutaInicial, carpetaCategoria, carpetaSubCategoria, entidad, anyo, nombreArchivo, variante, numeroSerie);
						case 2: return string.Format("{0}{1}{2}\\A Conf\\{3}\\{4} {5}{6}{7}.jpg", rutaInicial, carpetaCategoria, carpetaSubCategoria, entidad, anyo, nombreArchivo.Replace("Banco", "B."), variante, numeroSerie);
						case 3: return string.Format("{0}{1}{2}\\A Conf\\{3}\\{4} {5}{6}{7}.jpg", rutaInicial, carpetaCategoria, carpetaSubCategoria, entidad, anyo, nombreArchivo.Replace("Banco de", "B."), variante, numeroSerie);
						case 4: return string.Format("{0}{1}{2}\\A Conf\\{3}\\{4} {5}{6}{7}.jpg", rutaInicial, carpetaCategoria, carpetaSubCategoria, entidad, anyo, nombreArchivo.Replace("Banc de", "B."), variante, numeroSerie);
						case 5: return string.Format("{0}{1}{2}\\A Conf\\{3}\\{4} {5}{6}{7}.jpg", rutaInicial, carpetaCategoria, carpetaSubCategoria, entidad, anyo, nombreArchivo.Replace("Banc de", "B."), variante, numeroSerie);
						case 6: return string.Format("{0}{1}{2}\\A Conf\\{3}\\{4} {5}{6}{7}.jpg", rutaInicial, carpetaCategoria, carpetaSubCategoria, entidad.Replace("Banco", "B."), anyo, nombreArchivo, variante, numeroSerie);
						case 7: return string.Format("{0}{1}{2}\\A Conf\\{3}\\{4} {5}{6}{7}.jpg", rutaInicial, carpetaCategoria, carpetaSubCategoria, entidad.Replace("Banco", "B."), anyo, nombreArchivo.Replace("Banco", "B."), variante, numeroSerie);
						case 8: return string.Format("{0}{1}{2}\\A Conf\\{3}\\{4} {5}{6}{7}.jpg", rutaInicial, carpetaCategoria, carpetaSubCategoria, entidad.Replace("Banco", "B."), anyo, nombreArchivo.Replace("Banco de", "B."), variante, numeroSerie);
						case 9: return string.Format("{0}{1}{2}\\A Conf\\{3}\\{4} {5}{6}{7}.jpg", rutaInicial, carpetaCategoria, carpetaSubCategoria, entidad.Replace("Banco", "B."), anyo, nombreArchivo.Replace("Banc de", "B."), variante, numeroSerie);
						case 10: return string.Format("{0}{1}{2}\\A Conf\\{3}\\{4} {5}{6}{7}.jpg", rutaInicial, carpetaCategoria, carpetaSubCategoria, entidad.Replace("Banco", "B."), anyo, nombreArchivo.Replace("Banc de", "B."), variante, numeroSerie);
						case 11: return string.Format("{0}{1}{2}\\A Conf\\{3}\\{4} {5}{6}{7}.jpg", rutaInicial, carpetaCategoria, carpetaSubCategoria, entidad.Replace("Banco de", "B."), anyo, nombreArchivo, variante, numeroSerie);
						case 12: return string.Format("{0}{1}{2}\\A Conf\\{3}\\{4} {5}{6}{7}.jpg", rutaInicial, carpetaCategoria, carpetaSubCategoria, entidad.Replace("Banco de", "B."), anyo, nombreArchivo.Replace("Banco", "B."), variante, numeroSerie);
						case 13: return string.Format("{0}{1}{2}\\A Conf\\{3}\\{4} {5}{6}{7}.jpg", rutaInicial, carpetaCategoria, carpetaSubCategoria, entidad.Replace("Banco de", "B."), anyo, nombreArchivo.Replace("Banco de", "B."), variante, numeroSerie);
						case 14: return string.Format("{0}{1}{2}\\A Conf\\{3}\\{4} {5}{6}{7}.jpg", rutaInicial, carpetaCategoria, carpetaSubCategoria, entidad.Replace("Banco de", "B."), anyo, nombreArchivo.Replace("Banc de", "B."), variante, numeroSerie);
						case 15: return string.Format("{0}{1}{2}\\A Conf\\{3}\\{4} {5}{6}{7}.jpg", rutaInicial, carpetaCategoria, carpetaSubCategoria, entidad.Replace("Banco de", "B."), anyo, nombreArchivo.Replace("Banc de", "B."), variante, numeroSerie);
						case 16: return string.Format("{0}{1}{2}\\A Conf\\{3}\\{4} {5}{6}{7}.jpg", rutaInicial, carpetaCategoria, carpetaSubCategoria, entidad.Replace("Banc", "B."), anyo, nombreArchivo, variante, numeroSerie);
						case 17: return string.Format("{0}{1}{2}\\A Conf\\{3}\\{4} {5}{6}{7}.jpg", rutaInicial, carpetaCategoria, carpetaSubCategoria, entidad.Replace("Banc", "B."), anyo, nombreArchivo.Replace("Banco", "B."), variante, numeroSerie);
						case 18: return string.Format("{0}{1}{2}\\A Conf\\{3}\\{4} {5}{6}{7}.jpg", rutaInicial, carpetaCategoria, carpetaSubCategoria, entidad.Replace("Banc", "B."), anyo, nombreArchivo.Replace("Banco de", "B."), variante, numeroSerie);
						case 19: return string.Format("{0}{1}{2}\\A Conf\\{3}\\{4} {5}{6}{7}.jpg", rutaInicial, carpetaCategoria, carpetaSubCategoria, entidad.Replace("Banc", "B."), anyo, nombreArchivo.Replace("Banc de", "B."), variante, numeroSerie);
						case 20: return string.Format("{0}{1}{2}\\A Conf\\{3}\\{4} {5}{6}{7}.jpg", rutaInicial, carpetaCategoria, carpetaSubCategoria, entidad.Replace("Banc", "B."), anyo, nombreArchivo.Replace("Banc de", "B."), variante, numeroSerie);
						case 21: return string.Format("{0}{1}{2}\\A Conf\\{3}\\{4} {5}{6}{7}.jpg", rutaInicial, carpetaCategoria, carpetaSubCategoria, entidad.Replace("Banc de", "B."), anyo, nombreArchivo, variante, numeroSerie);
						case 22: return string.Format("{0}{1}{2}\\A Conf\\{3}\\{4} {5}{6}{7}.jpg", rutaInicial, carpetaCategoria, carpetaSubCategoria, entidad.Replace("Banc de", "B."), anyo, nombreArchivo.Replace("Banco", "B."), variante, numeroSerie);
						case 23: return string.Format("{0}{1}{2}\\A Conf\\{3}\\{4} {5}{6}{7}.jpg", rutaInicial, carpetaCategoria, carpetaSubCategoria, entidad.Replace("Banc de", "B."), anyo, nombreArchivo.Replace("Banco de", "B."), variante, numeroSerie);
						case 24: return string.Format("{0}{1}{2}\\A Conf\\{3}\\{4} {5}{6}{7}.jpg", rutaInicial, carpetaCategoria, carpetaSubCategoria, entidad.Replace("Banc de", "B."), anyo, nombreArchivo.Replace("Banc de", "B."), variante, numeroSerie);
						case 25: return string.Format("{0}{1}{2}\\A Conf\\{3}\\{4} {5}{6}{7}.jpg", rutaInicial, carpetaCategoria, carpetaSubCategoria, entidad.Replace("Banc de", "B."), anyo, nombreArchivo.Replace("Banc de", "B."), variante, numeroSerie);
						case 26: return string.Format("{0}{1}{2}\\A Conf\\{3}\\{4} {5}{6}.jpg", rutaInicial, carpetaCategoria, carpetaSubCategoria, entidad, anyo, nombreArchivo, variante);
						case 27: return string.Format("{0}{1}{2}\\{3}\\{4} {5}{6}{7}.jpg", rutaInicial, carpetaCategoria, carpetaSubCategoria, entidad, anyo, nombreArchivo, variante, numeroSerie);
						default: return string.Format("{0}{1}{2}\\A Conf\\{3}\\{4} {5}{6}{7}.jpg", rutaInicial, carpetaCategoria, carpetaSubCategoria, entidad, anyo, nombreArchivo, variante, numeroSerie);
					}
				case "Caja de Ahorros":
					switch (numero) {
						case 1: return string.Format("{0}{1}{2}\\A Conf\\{3}\\{4} {5}{6}{7}.jpg", rutaInicial, carpetaCategoria, carpetaSubCategoria, entidad, anyo, nombreArchivo, variante, numeroSerie);
						case 2: return string.Format("{0}{1}{2}\\A Conf\\{3}\\{4} {5}{6}{7}.jpg", rutaInicial, carpetaCategoria, carpetaSubCategoria, entidad, anyo, nombreArchivo.Replace("Banco", "B."), variante, numeroSerie);
						case 3: return string.Format("{0}{1}{2}\\A Conf\\{3}\\{4} {5}{6}{7}.jpg", rutaInicial, carpetaCategoria, carpetaSubCategoria, entidad, anyo, nombreArchivo.Replace("Banco de", "B."), variante, numeroSerie);
						case 4: return string.Format("{0}{1}{2}\\A Conf\\{3}\\{4} {5}{6}{7}.jpg", rutaInicial, carpetaCategoria, carpetaSubCategoria, entidad.Replace("Caja", "C."), anyo, nombreArchivo, variante, numeroSerie);
						case 5: return string.Format("{0}{1}{2}\\A Conf\\{3}\\{4} {5}{6}{7}.jpg", rutaInicial, carpetaCategoria, carpetaSubCategoria, entidad.Replace("Caja", "C."), anyo, nombreArchivo.Replace("Caja", "C."), variante, numeroSerie);
						case 6: return string.Format("{0}{1}{2}\\A Conf\\{3}\\{4} {5}{6}{7}.jpg", rutaInicial, carpetaCategoria, carpetaSubCategoria, entidad.Replace("Caja", "C."), anyo, nombreArchivo.Replace("Caja de", "C."), variante, numeroSerie);
						case 7: return string.Format("{0}{1}{2}\\A Conf\\{3}\\{4} {5}{6}{7}.jpg", rutaInicial, carpetaCategoria, carpetaSubCategoria, entidad.Replace("Caja", "C."), anyo, nombreArchivo.Replace("Caja de Ahorros", "C. A."), variante, numeroSerie);
						case 8: return string.Format("{0}{1}{2}\\A Conf\\{3}\\{4} {5}{6}{7}.jpg", rutaInicial, carpetaCategoria, carpetaSubCategoria, entidad.Replace("Caja", "C."), anyo, nombreArchivo.Replace("Caja de Ahorros", "C.A."), variante, numeroSerie);
						case 9: return string.Format("{0}{1}{2}\\A Conf\\{3}\\{4} {5}{6}{7}.jpg", rutaInicial, carpetaCategoria, carpetaSubCategoria, entidad.Replace("Caja de", "C."), anyo, nombreArchivo, variante, numeroSerie);
						case 10: return string.Format("{0}{1}{2}\\A Conf\\{3}\\{4} {5}{6}{7}.jpg", rutaInicial, carpetaCategoria, carpetaSubCategoria, entidad.Replace("Caja de", "C."), anyo, nombreArchivo.Replace("Caja", "C."), variante, numeroSerie);
						case 11: return string.Format("{0}{1}{2}\\A Conf\\{3}\\{4} {5}{6}{7}.jpg", rutaInicial, carpetaCategoria, carpetaSubCategoria, entidad.Replace("Caja de", "C."), anyo, nombreArchivo.Replace("Caja de", "C."), variante, numeroSerie);
						case 12: return string.Format("{0}{1}{2}\\A Conf\\{3}\\{4} {5}{6}{7}.jpg", rutaInicial, carpetaCategoria, carpetaSubCategoria, entidad.Replace("Caja de", "C."), anyo, nombreArchivo.Replace("Caja de Ahorros", "C. A."), variante, numeroSerie);
						case 13: return string.Format("{0}{1}{2}\\A Conf\\{3}\\{4} {5}{6}{7}.jpg", rutaInicial, carpetaCategoria, carpetaSubCategoria, entidad.Replace("Caja de", "C."), anyo, nombreArchivo.Replace("Caja de Ahorros", "C.A."), variante, numeroSerie);
						case 14: return string.Format("{0}{1}{2}\\A Conf\\{3}\\{4} {5}{6}{7}.jpg", rutaInicial, carpetaCategoria, carpetaSubCategoria, entidad.Replace("Caixa", "C."), anyo, nombreArchivo, variante, numeroSerie);
						case 15: return string.Format("{0}{1}{2}\\A Conf\\{3}\\{4} {5}{6}{7}.jpg", rutaInicial, carpetaCategoria, carpetaSubCategoria, entidad.Replace("Caixa", "C."), anyo, nombreArchivo.Replace("Caixa", "C."), variante, numeroSerie);
						case 16: return string.Format("{0}{1}{2}\\A Conf\\{3}\\{4} {5}{6}{7}.jpg", rutaInicial, carpetaCategoria, carpetaSubCategoria, entidad.Replace("Caixa", "C."), anyo, nombreArchivo.Replace("Caixa de", "C."), variante, numeroSerie);
						case 17: return string.Format("{0}{1}{2}\\A Conf\\{3}\\{4} {5}{6}{7}.jpg", rutaInicial, carpetaCategoria, carpetaSubCategoria, entidad.Replace("Caixa de", "C."), anyo, nombreArchivo, variante, numeroSerie);
						case 18: return string.Format("{0}{1}{2}\\A Conf\\{3}\\{4} {5}{6}{7}.jpg", rutaInicial, carpetaCategoria, carpetaSubCategoria, entidad.Replace("Caixa de", "C."), anyo, nombreArchivo.Replace("Caixa", "C."), variante, numeroSerie);
						case 19: return string.Format("{0}{1}{2}\\A Conf\\{3}\\{4} {5}{6}{7}.jpg", rutaInicial, carpetaCategoria, carpetaSubCategoria, entidad.Replace("Caixa de", "C."), anyo, nombreArchivo.Replace("Caixa de", "C."), variante, numeroSerie);
						case 20: return string.Format("{0}{1}{2}\\A Conf\\{3}\\{4} {5}{6}{7}.jpg", rutaInicial, carpetaCategoria, carpetaSubCategoria, entidad.Replace("Caixa de", "Caixa"), anyo, nombreArchivo, variante, numeroSerie);
						case 21: return string.Format("{0}{1}{2}\\A Conf\\{3}\\{4} {5}{6}{7}.jpg", rutaInicial, carpetaCategoria, carpetaSubCategoria, entidad.Replace("Caixa de", "Caixa"), anyo, nombreArchivo.Replace("Caixa de", "Caixa"), variante, numeroSerie);
						case 22: return string.Format("{0}{1}{2}\\A Conf\\{3}\\{4} {5}{6}.jpg", rutaInicial, carpetaCategoria, carpetaSubCategoria, entidad, anyo, nombreArchivo, variante);
						case 23: return string.Format("{0}{1}{2}\\{3}\\{4} {5}{6}{7}.jpg", rutaInicial, carpetaCategoria, carpetaSubCategoria, entidad, anyo, nombreArchivo, variante, numeroSerie);
						default: return string.Format("{0}{1}{2}\\A Conf\\{3}\\{4} {5}{6}{7}.jpg", rutaInicial, carpetaCategoria, carpetaSubCategoria, entidad, anyo, nombreArchivo, variante, numeroSerie);
					}
				default: return string.Format("{0}{1}{2}\\A Conf\\{3}\\{4} {5}{6}{7}.jpg", rutaInicial, carpetaCategoria, carpetaSubCategoria, entidad, anyo, nombreArchivo, variante, numeroSerie);
			}
		}
	}
}
