using System.Net;
using System;
using System.Configuration;
using System.Text;
using System.IO;
using Newtonsoft.Json;
using System.Collections.Generic;
using CollectorsClub.Web.API.Models;

public static class WebApi {

	public static string UrlWebApi { get { return ConfigurationManager.AppSettings["UrlWebApi"]; } }
	public static string UsuarioWebApi { get { return ConfigurationManager.AppSettings["UsuarioWebApi"]; } }
	public static string ContrasenyaWebApi { get { return ConfigurationManager.AppSettings["ContrasenyaWebApi"]; } }
	public static Dictionary<string, TokenModel> Tokens;

	public enum WebApiVerbos {
		POST = 1,
		GET = 2,
		PUT = 3,
		DELETE = 4
	}

	public static void ObtenerToken(string urlWebApi, string usuarioWebApi, string contrasenyaWebApi) {
		if (Tokens == null) { Tokens = new Dictionary<string, TokenModel>(); }
		if (!Tokens.ContainsKey(urlWebApi)) { Tokens.Add(urlWebApi, GetToken(urlWebApi, usuarioWebApi, contrasenyaWebApi)); } else { Tokens[urlWebApi] = GetToken(urlWebApi, usuarioWebApi, contrasenyaWebApi); }
	}

	public static string Post(string urlWebApi, string urlAccionController, string data) {
		HttpWebRequest _request = GetHttpWebRequestConToken(urlWebApi, urlAccionController, WebApiVerbos.POST);

		Byte[] _datos = Encoding.UTF8.GetBytes(data);
		Stream _requestStream = _request.GetRequestStream();
		_requestStream.Write(_datos, 0, _datos.Length);
		_requestStream.Close();

		return GetWebResponse(_request);
	}

	public static string Put(string urlWebApi, string urlAccionController, string data) {
		HttpWebRequest _request = GetHttpWebRequestConToken(urlWebApi, urlAccionController, WebApiVerbos.PUT);

		Byte[] _datos = Encoding.UTF8.GetBytes(data);
		Stream _requestStream = _request.GetRequestStream();
		_requestStream.Write(_datos, 0, _datos.Length);
		_requestStream.Close();

		return GetWebResponse(_request);
	}

	public static string Get(string urlWebApi, string urlAccionController) {
		return GetWebResponse(GetHttpWebRequestConToken(urlWebApi, urlAccionController, WebApiVerbos.GET));
	}

	public static string Delete(string urlWebApi, string urlAccionController) {
		return GetWebResponse(GetHttpWebRequestConToken(urlWebApi, urlAccionController, WebApiVerbos.DELETE));
	}

	private static HttpWebRequest GetHttpWebRequestConToken(string urlWebApi, string urlAccionController, WebApiVerbos verbo) {
		HttpWebRequest _request = (HttpWebRequest) WebRequest.Create(new Uri(urlWebApi + urlAccionController));
		_request.Timeout = 600000;
		_request.Headers.Add("Authorization", "Session " + Tokens[urlWebApi].access_token);
		_request.Accept = "application/json";
		_request.ContentType = "application/json";
		_request.Method = verbo.ToString();
		return _request;
	}

	private static string GetWebResponse(HttpWebRequest request) {
		WebResponse _response = request.GetResponse();
		Stream _responseStream = _response.GetResponseStream();
		StreamReader _reader = new StreamReader(_responseStream);
		return _reader.ReadToEnd();
	}

	public static Exception ProcesarExcepcionWeb(WebException excepcion, string mensaje) {
		if (excepcion.Response != null) {
			using (StreamReader _reader = new StreamReader(excepcion.Response.GetResponseStream())) {
				string _error = _reader.ReadToEnd();
				if (_error.Contains("Message")) {
					try {
						Exception _excepcionWebAPI = JsonConvert.DeserializeObject<Exception>(_error);
						return _excepcionWebAPI;
					} catch {
						return new ApplicationException(_error);
					}
				} else {
					return new ApplicationException(_error);
				}
			}
		} else {
			return excepcion;
		}
	}

	public static TokenModel GetToken(string urlWebApi, string usuarioWebApi, string contrasenyaWebApi) {
		WebClient _client = new WebClient();
		_client.Headers.Add("Authorization", "Basic " + Convert.ToBase64String(Encoding.GetEncoding("iso-8859-1").GetBytes(String.Format("{0}:{1}", usuarioWebApi, contrasenyaWebApi))));
		return JsonConvert.DeserializeObject<TokenModel>(_client.DownloadString(urlWebApi + "/api/token").Replace("\r\n", string.Empty));
	}
}