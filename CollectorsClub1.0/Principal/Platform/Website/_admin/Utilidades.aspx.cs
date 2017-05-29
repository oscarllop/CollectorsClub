using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Utilidades : System.Web.UI.Page {
	protected void Page_Load(object sender, EventArgs e) {

	}

	protected void Codificar_Click(object sender, EventArgs e) {
		CadenaResultante.Text = ConvertiraRegexString(CadenaACodificar.Text);
	}

	private string ConvertiraRegexString(string cadena) {
		return cadena.Replace("(", @"\(").Replace(")", @"\)").Replace("{", @"\{").Replace("}", @"\}").Replace("<", @"\<").Replace(">", @"\>").Replace("$", @"\$").Replace("!", @"\!").Replace("?", @"\?").Replace("\"", @"""""");
	}
}