
using CollectorsClub.Data.Dispatcher;
using CollectorsClub.Data.Infrastructure;
using CollectorsClub.Model.Entities;
using CollectorsClub.Model.Repositories;
using CollectorsClub.Web.API.Models;
using Core.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.IO.Compression;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using WebApi.OutputCache.V2;

namespace CollectorsClub.Web.API.Controllers {

	// OLL: Esta clase tendría que estar en App_Code - Utilidades. Pero no compila si la pongo allí.
	public static class ZipArchiveExtensions {
		public static void ExtractToDirectory(this ZipArchive archive, string destinationDirectoryName, bool overwrite) {
			if (!overwrite) {
				archive.ExtractToDirectory(destinationDirectoryName);
				return;
			}
			foreach (ZipArchiveEntry file in archive.Entries) {
				string completeFileName = Path.Combine(destinationDirectoryName, file.FullName);
				if (file.Name == "") {// Assuming Empty for Directory
					Directory.CreateDirectory(Path.GetDirectoryName(completeFileName));
					continue;
				}
				file.ExtractToFile(completeFileName, true);
			}
		}
	}

	public partial class FotoController : ApiController {

    private IUnitOfWork Uow;
		private readonly ICategoriaFotoRepository categoriaFotoRepository;

		public FotoController(ICommandBus commandBus, IFotoRepository fotoRepository, IFoto_IdiomaRepository foto_IdiomaRepository, ICategoriaFotoRepository categoriaFotoRepository, IUnitOfWork uow) {
			this.commandBus = commandBus;
			this.fotoRepository = fotoRepository;
			this.foto_IdiomaRepository = foto_IdiomaRepository;
			this.categoriaFotoRepository = categoriaFotoRepository;
			this.Uow = uow;
			log4net.Config.XmlConfigurator.Configure();
		}


		[AllowAnonymous]
		[HttpPost]
		public HttpResponseMessage CargaMasiva() {
			// Creating a variable to store the file if it has been sent.   
			HttpPostedFile uploadedFile = HttpContext.Current.Request.Files.Count > 0 ? HttpContext.Current.Request.Files[0] : null;
			string _rutaRelativa = HttpContext.Current.Request.Form["Ruta"];
			string _idMarca = HttpContext.Current.Request.Form["IdMarca"];

			if (uploadedFile != null && uploadedFile.ContentLength > 0 && uploadedFile.ContentLength <= 262144000) {
				var _nombreArchivo = Path.GetFileName(uploadedFile.FileName);

				// Set the path in Web.Config file to save the uploaded files. 
				string _directorio = ConfigurationManager.AppSettings["RutaArchivos"] + _rutaRelativa.Replace(Path.AltDirectorySeparatorChar, Path.DirectorySeparatorChar);

				if (!Directory.Exists(_directorio)) { Directory.CreateDirectory(_directorio); }
				uploadedFile.SaveAs(_directorio + "\\" + _nombreArchivo);
				if (Path.GetExtension(_nombreArchivo) == ".zip") {
					using (ZipArchive _file = ZipFile.OpenRead(_directorio + "\\" + _nombreArchivo)) {
						_file.ExtractToDirectory(_directorio, true);
					}
					//ZipFile.ExtractToDirectory(_directorio + "\\" + _nombreArchivo, _directorio);
					File.Delete(_directorio + "\\" + _nombreArchivo);
				}

				Dictionary<string, CategoriaFoto> _categoriasProcesadas = new Dictionary<string, CategoriaFoto>();
				List<MensajeModel> _mensajes = new List<MensajeModel>();
				int _indiceEntidades = 0;
				foreach (string _archivo in Directory.GetFiles(_directorio, "*.*", SearchOption.AllDirectories)) {
					string _rutaArchivoRelativa = _archivo.Replace(_directorio, string.Empty);
					try {
						string[] _partes = _rutaArchivoRelativa.Split('\\');
						if (_partes.Length == 2) {
							string _categoria = _partes[0];
							if (!_categoriasProcesadas.ContainsKey(_categoria)) {
								CategoriaFoto _categoriaFoto = categoriaFotoRepository.GetMany(cf => cf.Nombre == _categoria).FirstOrDefault();
								if (_categoriaFoto == null) {
									_categoriaFoto = new CategoriaFoto() { Id = --_indiceEntidades, Activa = true, FechaAlta = DateTime.Now, Nombre = _categoria, Orden = 1 };
									_categoriaFoto.RegistrosIdiomas.Add(new CategoriaFoto_Idioma() { IdRegistro = _indiceEntidades, Cultura = "es-ES", Nombre = _categoria });
									_categoriaFoto.RegistrosIdiomas.Add(new CategoriaFoto_Idioma() { IdRegistro = _indiceEntidades, Cultura = "ca-ES", Nombre = _categoria });
									_categoriaFoto.RegistrosIdiomas.Add(new CategoriaFoto_Idioma() { IdRegistro = _indiceEntidades, Cultura = "en-US", Nombre = _categoria });
									categoriaFotoRepository.Add(_categoriaFoto);
								}
								_categoriasProcesadas.Add(_categoria, _categoriaFoto);
							}
							string _nombreArchivoImagen = _partes[1];
							int _idCategoria = _categoriasProcesadas[_categoria].Id;
							Foto _foto = fotoRepository.GetMany(f => f.IdCategoria == _idCategoria && f.NombreArchivoImagen == _rutaArchivoRelativa).FirstOrDefault();
							if (_foto == null) {
								_foto = new Foto() { Id = --_indiceEntidades, Activa = true, Descripcion = Path.GetFileNameWithoutExtension(_nombreArchivoImagen), FechaAlta = DateTime.Now, IdCategoria = _categoriasProcesadas[_categoria].Id, Nombre = Path.GetFileNameWithoutExtension(_nombreArchivoImagen), NombreArchivoImagen = _rutaArchivoRelativa, Orden = 1 };
								_foto.RegistrosIdiomas.Add(new Foto_Idioma() { IdRegistro = _indiceEntidades, Cultura = "es-ES", Nombre = Path.GetFileNameWithoutExtension(_nombreArchivoImagen), Descripcion = Path.GetFileNameWithoutExtension(_nombreArchivoImagen) });
								_foto.RegistrosIdiomas.Add(new Foto_Idioma() { IdRegistro = _indiceEntidades, Cultura = "ca-ES", Nombre = Path.GetFileNameWithoutExtension(_nombreArchivoImagen), Descripcion = Path.GetFileNameWithoutExtension(_nombreArchivoImagen) });
								_foto.RegistrosIdiomas.Add(new Foto_Idioma() { IdRegistro = _indiceEntidades, Cultura = "en-US", Nombre = Path.GetFileNameWithoutExtension(_nombreArchivoImagen), Descripcion = Path.GetFileNameWithoutExtension(_nombreArchivoImagen) });
								fotoRepository.Add(_foto);
							}
							_mensajes.Add(new MensajeModel() { Tipo = "Mensaje", Texto = string.Format("Se cargado el archivo '{0}' correctamente.", _rutaArchivoRelativa) });
						} else if (_partes.Length > 2) {
							_mensajes.Add(new MensajeModel() { Tipo = "Advertencia", Texto = string.Format("No se puede cargar el archivo '{0}'. Debe indicar un único nivel de carpetas para indicar la categoría.", _rutaArchivoRelativa) });
							Directory.Delete(Path.GetDirectoryName(_archivo), true);
						} else if (_partes.Length == 1) {
							_mensajes.Add(new MensajeModel() { Tipo = "Advertencia", Texto = string.Format("No se puede cargar el archivo '{0}'. Debe ubicar el archivos dentro de la carpeta de su categoría.", _rutaArchivoRelativa) });
							File.Delete(_archivo);
						}
					} catch (Exception _excepcion) {
						_mensajes.Add(new MensajeModel() { Tipo = "Error", Texto = string.Format("No se puede cargar el archivo '{0}'. Detalle del error: {1}", _rutaArchivoRelativa, _excepcion.Message) });
					}
				}
				Uow.Commit();

				return Request.CreateResponse<CargaArchivoModel>(HttpStatusCode.OK, new CargaArchivoModel() { Ruta = _nombreArchivo, Mensaje = "Carga finalizada correctamente.", Mensajes = _mensajes.ToArray() });
			} else {
				return Request.CreateResponse<string>(HttpStatusCode.InternalServerError, "Error en la carga del fichero al servidor. No se ha detectado contenido en la petición.");
			}
		}
	}
}