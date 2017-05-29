using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using OfficeOpenXml;
using OfficeOpenXml.Style;
using System.IO;
using System.Dynamic;
using System.IO.Compression;
using System.Configuration;
using System.Text;
using System.Net.Mail;
using System.Net;
using CollectorsClub.Model.Repositories;
using CollectorsClub.Model.Infrastructure;
using CollectorsClub.Model.Entities;
using System.Globalization;
using DotNetNuke.Entities.Users;
using DotNetNuke.Security.Membership;
using DotNetNuke.Entities.Portals;
using System.Text.RegularExpressions;

namespace CollectorsClub.Web.API.App_Code {

	public enum TiposRetorno {
		Json = 1,
		Excel = 2
	}

	public class Utilidades {
		// Este método genera un excel a partir de una lista de objetos key-value y devuelve el nombre de archivo donde lo ha generado
		public static string GenerarExcel(IEnumerable<Object> lista) {
			ExcelPackage pck = new ExcelPackage();
			ExcelWorksheet ws = pck.Workbook.Worksheets.Add("Resultados");
			int fila = 2;
			int columna = 1;
			foreach (Object _row in lista) {
				// En caso de recibir ExpandoObject generamos el excel de este modo
				if (_row is ExpandoObject) {
					foreach (KeyValuePair<string, object> _columna in (ExpandoObject) _row) {
						if (fila == 2) {
							ws.Cells[1, columna].Value = _columna.Key;
							ws.Cells[1, columna].Style.Font.Bold = true;
						}
						ws.Cells[fila, columna].Value = _columna.Value;
						if (_columna.Value is DateTime) {
							ws.Cells[fila, columna].Style.Numberformat.Format = "dd/mm/yyyy";
						}
						columna++;
					}
				}
				fila++;
				columna = 1;
			}
			if (lista != null && lista.Count() > 0) { ws.Cells[ws.Dimension.Address].AutoFitColumns(); }
			// Generamos un nombre de archivo único para guardar en directorio temporal
			string _nombreArchivoTemporal = string.Format("\\Excel\\{0}_Resultados.xlsx", Guid.NewGuid().ToString());
			string _directorio = ConfigurationManager.AppSettings["UrlGuardarDocumentosTemporales"] + "\\Excel";
			if (!Directory.Exists(_directorio)) { Directory.CreateDirectory(_directorio); }
			pck.SaveAs(new FileInfo(string.Format("{0}\\{1}", ConfigurationManager.AppSettings["UrlGuardarDocumentosTemporales"], _nombreArchivoTemporal)));
			return _nombreArchivoTemporal;
		}

		public static string RemoveDiacritics(string input) {
			string stFormD = input.Normalize(NormalizationForm.FormD);
			int len = stFormD.Length;
			StringBuilder sb = new StringBuilder();
			for (int i = 0; i < len; i++) {
				System.Globalization.UnicodeCategory uc = System.Globalization.CharUnicodeInfo.GetUnicodeCategory(stFormD[i]);
				if (uc != System.Globalization.UnicodeCategory.NonSpacingMark) {
					sb.Append(stFormD[i]);
				}
			}
			return (sb.ToString().Normalize(NormalizationForm.FormC));
		}

		public static string ConstruirRutaDirectorios(string rutaBase, params object[] directoriosOrdenados) {
			string _ruta = rutaBase;
			if (!string.IsNullOrEmpty(_ruta) && directoriosOrdenados != null && directoriosOrdenados.Length > 0) {
				_ruta = string.Format(@"{0}\{1}", rutaBase, string.Join(@"\", Array.ConvertAll(directoriosOrdenados, r => r)));
			}
			return _ruta;
		}


		public static string RevisarNombreSistemaArchivos(string nombre) {
			if (string.IsNullOrEmpty(nombre)) { return nombre; }

			string _nombre = nombre;
			foreach (char _invalido in Path.GetInvalidFileNameChars()) {
				_nombre = _nombre.Replace(_invalido.ToString(), string.Empty);
			}
			return _nombre;
		}
	}

	public class Mailing {

		public static string ProcesarCamposEmail(int IdUsuario, string HTMLEmail) {
			//Usuario _usuario = null;

			//try {
			//	_usuario = new UsuarioRepository(new DatabaseFactory()).GetById(IdUsuario);
			//} catch {
			//	throw new ApplicationException("No se ha podido obtener los datos del usuario.");
			//}

			//string lSCultura = BLL_Idiomas.GetPorId(RowCurso.idIdioma).idm_culture;

			//#region Reemplazo los campos obligatorios. Si alguno de estos datos no está informado dará error
			//try {
			//	HTMLEmail = HTMLEmail.Replace("%%USERNAME%%", _usuario.UserName);
			//} catch {
			//	throw new ApplicationException("No se ha informado el username.");
			//}
			//try {
			//	if (HTMLEmail.Contains("%%NOMBRE%%")) { HTMLEmail = HTMLEmail.Replace("%%NOMBRE%%", _usuario.Nombre); }
			//} catch {
			//	throw new ApplicationException("No se ha informado el nombre del usuario.");
			//}
			//try {
			//	if (HTMLEmail.Contains("%%EMAIL%%")) { HTMLEmail = HTMLEmail.Replace("%%EMAIL%%", _usuario.Email); }
			//} catch {
			//	throw new ApplicationException("No se ha informado el email del usuario.");
			//}
			//HTMLEmail = HTMLEmail.Replace("%%FECHAACTUAL%%", DateTime.Now.ToString(CultureInfo.GetCultureInfo(lSCultura).DateTimeFormat.ShortDatePattern));
			//try {
			//	if (HTMLEmail.Contains("%%CONTRASENYA%%")) {
			//		UserInfo UsuarioCliente = MembershipProvider.Instance().GetUserByUserName((PortalSettings.Current != null ? PortalSettings.Current.PortalId : 0), _usuario.UserName);
			//		HTMLEmail = HTMLEmail.Replace("%%CONTRASENYA%%", MembershipProvider.Instance().GetPassword(UsuarioCliente, UsuarioCliente.Membership.PasswordAnswer));
			//	}
			//} catch {
			//	throw new ApplicationException("No se ha podido obtener la contrasenya del cliente.");
			//}
			//string lSHost = "http://www.CollectorsClubvilaseca.com";
			//if (HttpContext.Current != null) {
			//	lSHost = Uri.UriSchemeHttp + Uri.SchemeDelimiter + HttpContext.Current.Request.Url.Host + (HttpContext.Current.Request.IsLocal ? HttpContext.Current.Request.ApplicationPath : string.Empty);
			//}
			//try {
			//	if (HTMLEmail.Contains("%%URLWEBPUBLICA%%")) { HTMLEmail = HTMLEmail.Replace("%%URLWEBPUBLICA%%", lSHost); }
			//} catch {
			//	throw new ApplicationException("No se ha podido generar la url pública.");
			//}
			//HTMLEmail = Regex.Replace(HTMLEmail, "(?<atributo>\\s+href\\s*=\\s*['\"]?)(?<path>(?!http://)(?!https://)(?!#)(?!mms://)(?!')(?!\")(?!javascript:)[^'\"\\s\\>]*['\"]?)", "${atributo}" + lSHost + (PortalSettings.Current != null ? PortalSettings.Current.HomeDirectory : "/Portals/0/") + "Archivos/" + "${path}", RegexOptions.IgnoreCase);
			//#endregion Reemplazo los campos obligatorios. Si alguno de estos datos no está informado dará error

			//#region Reemplazo los campos opcionales. Si alguno de estos datos no está informado se pone en blanco
			//HTMLEmail = HTMLEmail.Replace("%%APELLIDO1%%", (_usuario != null ? _usuario.Apellido1 : string.Empty));
			//HTMLEmail = HTMLEmail.Replace("%%APELLIDO2%%", (_usuario != null ? _usuario.Apellido2 ?? string.Empty : string.Empty));
			//#endregion Reemplazo los campos opcionales. Si alguno de estos datos no está informado se pone en blanco

			return HTMLEmail;
		}

		public static void EnviarEmailAccion(string emailOrigen, string email, string asunto, string HTML, List<string> documentos) {
			SmtpClient SmtpClient = new SmtpClient();
			SmtpClient.Host = (!string.IsNullOrEmpty(DotNetNuke.Entities.Host.Host.SMTPServer) ? DotNetNuke.Entities.Host.Host.SMTPServer : ConfigurationManager.AppSettings["SMTPHost"]);

			if (bool.Parse(ConfigurationManager.AppSettings["CorreoUsarCredenciales"])) {
				SmtpClient.UseDefaultCredentials = false;
				SmtpClient.Credentials = new NetworkCredential(ConfigurationManager.AppSettings["CorreoCuenta"], ConfigurationManager.AppSettings["CorreoContrasenya"]);
			}

			MailMessage Mail = new MailMessage();
			Mail.Subject = asunto;
			Mail.Body = HTML;
			Mail.IsBodyHtml = true;
			Mail.From = new MailAddress(bool.Parse(ConfigurationManager.AppSettings["UsarFromGenerico"]) ? ConfigurationManager.AppSettings["FromGenerico"] : emailOrigen);
			Mail.To.Add(bool.Parse(ConfigurationManager.AppSettings["EnviarCorreosAlCliente"]) ? email : ConfigurationManager.AppSettings["CorreoDePruebas"]);

			if (documentos != null) {
				foreach (string IdDocumento in documentos) {
					Mail.Attachments.Add(CrearAdjunto(IdDocumento));
				}
			}
			SmtpClient.Send(Mail);

			foreach (Attachment Attachment in Mail.Attachments) {
				if (Attachment.ContentStream != null) { Attachment.ContentStream.Close(); }
			}
		}

		public static string ObtenerArchivo(string PathArchivo) {
			if (new Uri(PathArchivo).Scheme == Uri.UriSchemeFile) {
				using (StreamReader lSReader = File.OpenText(PathArchivo)) { return lSReader.ReadToEnd(); }
			} else {
				Stream resStream = WebRequest.Create(PathArchivo).GetResponse().GetResponseStream();

				StringBuilder sb = new StringBuilder();
				byte[] buf = new byte[8192];
				string tempString = null;
				int count = 0;
				do {
					// fill the buffer with data
					count = resStream.Read(buf, 0, buf.Length);
					// make sure we read some data
					if (count != 0) {
						// translate from bytes to ASCII text
						tempString = Encoding.UTF8.GetString(buf, 0, count);

						// continue building the string
						sb.Append(tempString);
					}
				}
				while (count > 0); // any more data to read?
				return sb.ToString();
			}
		}

		private static Attachment CrearAdjunto(string Ruta) {
			using (FileStream f = File.Open(ConfigurationManager.AppSettings["RutaBaseArchivos"] + Ruta, FileMode.Open, FileAccess.Read)) {

				MemoryStream ms = new MemoryStream();
				ms.SetLength(f.Length);
				f.Read(ms.GetBuffer(), 0, (int) f.Length);
				ms.Flush();
				f.Close();

				return new Attachment(ms, Path.GetFileName(Ruta));
			}
		}

	}
}