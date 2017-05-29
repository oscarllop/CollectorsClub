using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Xml;
using System.Xml.XPath;

public class TraduccionRecursos {
	/// <summary>
	/// En base al contenido XML de un Resources (*.resx) devuelve una cadena de texto formateada en javascript
	/// </summary>
	/// <param name="contenidoXml">Contenido del XML del resource</param>
	/// <returns></returns>
	public static string obtenerTraduccionDesdeContenidoXML(string contenidoXml) {

		StringBuilder _resultado = new StringBuilder();
		if (!string.IsNullOrEmpty(contenidoXml)) {
			XPathDocument xmlDoc = new XPathDocument(new XmlTextReader(new StringReader(contenidoXml)) { WhitespaceHandling = WhitespaceHandling.None });
			XPathNavigator navegador = xmlDoc.CreateNavigator();
			XPathNodeIterator iterador = navegador.Select("/root/data");
			while (iterador.MoveNext()) {
				_resultado.AppendFormat("{0}: '{1}',", iterador.Current.GetAttribute("name", "").Replace(".", "_"), iterador.Current.Value.Replace("\r", string.Empty).Replace("\n", string.Empty).Replace("\t", string.Empty).Replace("'", "\\'"));
				//_resultado.AppendFormat("{0}: '{1}',", iterador.Current.GetAttribute("name", "").Replace(".", "_"), iterador.Current.Value);
			}
		}
		return string.Format("{{{0}}}", _resultado.ToString().TrimEnd(','));
	}

	/// <summary>
	/// Obtiene el Nombre del fichero que corresponde en base al CultireUI en curso.
	/// </summary>
	/// <param name="rutaResources">Ruta donde se alojan los ficheros de Resources</param>
	/// <param name="nombreBaseFichero">Nombre del fichero Base, (Ejemplo: View.ascx)</param>
	/// <param name="cultureUI">CultureUI info que esta en curso en la UI</param>
	/// <returns></returns>
	public static string obtenerRutaFicheroRecursoSegunCultura(string rutaResources, string nombreBaseFichero, string cultureUI) {
		string _resultado = null;
		if (!string.IsNullOrEmpty(rutaResources) && !string.IsNullOrEmpty(nombreBaseFichero) && Directory.Exists(rutaResources)) {
			List<string> ficheros = Directory.GetFiles(rutaResources).Where(r => r.Contains(Path.DirectorySeparatorChar + nombreBaseFichero)).ToList();
			if (!string.IsNullOrEmpty(cultureUI)) { _resultado = ficheros.FirstOrDefault(r => r.Contains(nombreBaseFichero + "." + cultureUI + ".resx")); }
			if (string.IsNullOrEmpty(_resultado)) { _resultado = ficheros.FirstOrDefault(r => r.Contains(nombreBaseFichero + ".resx")); }
		}
		return _resultado;
	}

	/// <summary>
	/// Lee el contenido de un fichero
	/// </summary>
	/// <param name="rutaFichero">Ruta del fichero</param>
	/// <param name="codificacion">Codificacion (null = Encoding.UTF8)</param>
	/// <returns></returns>
	public static string leerContenidoFichero(string rutaFichero, Encoding codificacion) {
		codificacion = codificacion ?? Encoding.UTF8;
		return File.Exists(rutaFichero) ? codificacion.GetString(File.ReadAllBytes(rutaFichero)) : null;
	}

	/// <summary>
	/// Devuelve una cadena de texto formateada en javascript con los literas establecidos en el Resource
	/// </summary>
	/// <param name="rutaRecursos">Ruta física donde estan alamcenados los recursos</param>
	/// <param name="nombreBaseRecurso">Nombre Base de la recurso a localizar. (Ejemplo: View.ascx)</param>
	/// <param name="cultureUI">CultureUI en curso. (Ejemplo: es-ES)</param>
	/// <returns></returns>
	public static string obtenerTraduccionLiteralDesdeRecursos(string rutaRecursos, string nombreBaseRecurso, string cultureUI) {
		string rutaFichero = obtenerRutaFicheroRecursoSegunCultura(rutaRecursos, nombreBaseRecurso, cultureUI);
		string contenidoXML = leerContenidoFichero(rutaFichero, null);
		return obtenerTraduccionDesdeContenidoXML(contenidoXML);
	}
}