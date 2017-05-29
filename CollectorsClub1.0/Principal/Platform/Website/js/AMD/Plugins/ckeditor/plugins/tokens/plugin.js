CKEDITOR.plugins.add('tokens', {
	requires: ['richcombo'],
	init: function (editor) {
		var config = editor.config, lang = editor.lang.format;

		var tags = [];
		tags[0] = ["%%nombre%%", "Nombre Cliente", "Nombre Cliente"];
		tags[1] = ["%%primerapellido%%", "Primer Apellido Cliente", "Primer Apellido Cliente"];
		tags[2] = ["%%segundoapellido%%", "Segundo Apellido Cliente", "Segundo Apellido Cliente"];
		tags[3] = ["%%domiciliocliente%%", "Domicilio Cliente", "Domicilio Cliente"];
		tags[4] = ["%%codigopostalcliente%%", "Código Postal Cliente", "Código Postal Cliente"];
		tags[5] = ["%%provinciacliente%%", "Provincia Cliente", "Provincia Cliente"];
		tags[6] = ["%%paiscliente%%", "País Cliente", "País Cliente"];
		tags[7] = ["%%nombrecurso%%", "Nombre Programa", "Nombre Programa"];
		tags[8] = ["%%nombrecampuscurso%%", "Nombre Campus Programa", "Nombre Campus Programa"];
		tags[9] = ["%%urlwebpublica%%", "Url Web Pública", "Url Web Pública"];
		tags[10] = ["%%urlprograma%%", "Url Programa", "Url Programa"];

		// Create style objects for all defined styles.
		editor.ui.addRichCombo('tokens', {
			label: "Campos",
			title: "Campos",
			voiceLabel: "Campos",
			className: 'cke_format',
			multiSelect: false,

			panel: {
				//css: [config.contentsCss, CKEDITOR.getUrl(editor.skinPath + 'editor.css')],
				css: [config.contentsCss, CKEDITOR.getUrl(CKEDITOR.skinName.split(",")[1] || "skins/" + CKEDITOR.skinName.split(",")[0] + "/") + "editor.css"],
				voiceLabel: lang.panelVoiceLabel
			},

			init: function () {
			 	self = this;
			 	this.startGroup("Tokens");
			 	tags.forEach(function (tag) { self.add(tag[0], tag[1], tag[2]); });
			},

			onClick: function (value) {
			 	editor.focus();
			 	editor.fire('saveSnapshot');
			 	editor.insertHtml(value);
			 	editor.fire('saveSnapshot');
			}
		});
	}
});