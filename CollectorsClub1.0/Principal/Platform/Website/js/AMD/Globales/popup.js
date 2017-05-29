define(['jquery', 'DNN/dnn.modalpopup'], function ($, dnnmodalpopup) {
	return {
		AbrirDialogo: function (idPopUp, width, height, titulo, onClose) {
			dnnDialogoModal.show(null, false, height, width, false, null, idPopUp, onClose, titulo);
		},
		CerrarDialogo: function (idPopUp, onClose) {
			dnnDialogoModal.closePopUp(false, null, idPopUp, onClose);
		},
		RevisarTamanyo: function (idPopUp) {
			dnnDialogoModal.revisarTamanyo(idPopUp);
		},
		// Revisar con dnnDialogModal
		AbrirDialogoMaximizado: function (IdPopUp, Titulo) {
			var maxWidth = $(window).width() - ($(window).width() * 10 / 100);
			var maxHeight = $(window).height() - ($(window).height() * 10 / 100);
			var dlg = $('#' + IdPopUp).dialog({
				title: Titulo,
				modal: true,
				autoOpen: true,
				close: function () { $(this).dialog('destroy'); },
				open: function () { },
				width: maxWidth,
				height: maxHeight
			});
			dlg.parent().appendTo(jQuery("form:first"));
		},
		AbrirDialogoConUrlExterna: function (url, width, height, id) {
			//OLL temporal mientras haya '+' en las urls
			url = url.replace('+', '&');
			if (url.indexOf('&popUp=true') == -1 && url.indexOf('?popUp=true') == -1) {
				url += (url.indexOf('?') == -1 ? '?' : '&') + 'popUp=true';
			}
			dnnDialogoModal.show(url, false, height, width, false);
		}
	}
});