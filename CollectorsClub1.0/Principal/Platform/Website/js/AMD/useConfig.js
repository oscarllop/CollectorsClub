if (typeof window.semaforoUse === 'undefined') {
	window.semaforoUse = '';
	require({
		paths: {
			"use": "use"
		},
		use: {
			'initWidgets': { deps: ['jquery'], attach: 'global/initWidgets' },
			'dnn/dnn': { deps: ['jquery'], attach: 'dnn' },
			'dnn/dnncore': { deps: ['use!dnn/dnn'], attach: 'dnncore' },
			'search/SearchSkinObjectPreview': { deps: ['use!dnn/dnn'], attach: 'search' },
			'dnn/dnn.xmlhttp': { deps: ['use!dnn/dnn'], attach: 'dnnxmlhttp' },
			'dnn/dnn.xmlhttp.jsxmlhttprequest': { deps: ['use!dnn/dnn.xmlhttp'], attach: 'dnnxmlhttpjsxmlhttprequest' },
			'dnn/dnn.controls': { deps: ['use!dnn/dnn'], attach: 'dnncontrols' },
			'dnn/dnn.controls.dnnlabeledit': { deps: ['use!dnn/dnn.controls'], attach: 'dnncontrolsdnnlabeledit' },
			'dnn/dnn.motion': { deps: ['use!dnn/dnn'], attach: 'dnnmotion' },
			'dnn/dnn.dom.positioning': { deps: ['use!dnn/dnn'], attach: 'dnndompositioning' },
			// OLL: Parece que para el skin actual no lo necesito
			//'dnn/dnn.controls.dnnmenu': { deps: ['use!dnn/dnn.xmlhttp', 'use!dnn/dnn.xmlhttp.jsxmlhttprequest', 'use!dnn/dnn.controls', 'use!dnn/dnn.motion', 'use!dnn/dnn.dom.positioning'], attach: 'dnncontrolsdnnmenu' },
			//'skinDNNMega/jquery.dnnmega': { deps: ['Skin/jquery.hoverIntent', 'use!dnn/dnn.controls.dnnmenu'], attach: 'jquerydnnmega' },
			'Plugins/extruder/jquery.mb.flipText': { deps: ['jquery', 'Skin/jquery.hoverIntent'], attach: 'mbfliptext' },
			'Plugins/extruder/mbExtruder.extension': { deps: ['jquery', 'Skin/jquery.hoverIntent', 'Plugins/extruder/jquery.mb.flipText'], attach: 'mbExtruder' },

			//Skin Porto
			'porto/Resources/Menu/menu.min': { deps: ['jquery'], attach: 'portomenu' },
			'porto/js/modernizr': { deps: ['jquery'], attach: 'modernizr' },
			'porto/js/bootstrap_3.3.5': { attach: 'bootstrap3_3_5' }, // tiene código AMD, ver si se puede cargar con dojo en lugar de use
			'porto/js/bootstrap_3.3.5.extension': { attach: 'bootstrap3_3_5extension' }, // tiene código AMD, ver si se puede cargar con dojo en lugar de use
			'porto/js/stellar_0.6.2': { attach: 'stellar_0_6_2' }, // tiene código AMD, ver si se puede cargar con dojo en lugar de use
			'porto/js/stellar_0.6.2.extension': { attach: 'stellar_0_6_2extension' }, // tiene código AMD, ver si se puede cargar con dojo en lugar de use
			'porto/js/isotope_2.2.0': { attach: 'isotope_2_2_0' }, // tiene código AMD, ver si se puede cargar con dojo en lugar de use
			'porto/js/skin': { deps: ['use!porto/js/modernizr', 'use!porto/js/bootstrap_3.3.5', 'use!porto/js/bootstrap_3.3.5.extension', 'use!porto/js/stellar_0.6.2', 'use!porto/js/stellar_0.6.2.extension', 'use!porto/js/isotope_2.2.0'], attach: 'portoskin' },
			'Plugins/LiveSlider/Plugins/TimelineLite': { deps: ['jquery'], attach: 'LiveSliderPluginsTimelineLite' },
			'Plugins/LiveSlider/Transitions': { deps: ['use!Plugins/LiveSlider/Plugins/TimelineLite'], attach: 'LiveSliderTransitions' },
			'Plugins/LiveSlider/LiveSlider': { deps: ['use!Plugins/LiveSlider/Transitions'], attach: 'LiveSlider' },

			// Administracion
			'components/Tokeninput/jquery.tokeninput': { deps: ['jquery'], attach: 'TokenInput' },
			'dnn/Debug/dnn.servicesframework': { deps: ['jquery'], attach: 'dnnServicesFramework' },
			'global/dnn.jquery': { deps: ['use!dnn/dnn'], attach: 'dnnJquery' },
			'porto/Resources/js/AMD_jquery.colorpicker.min': { deps: ['jquery'], attach: 'jqueryColorPicker' },
			'porto/Resources/js/less': { deps: ['jquery'], attach: 'less' },

			//Administracion - Skin -- Revisar en un futuro para cargarlos correctamente
			//'mandeepslibraries/AngularJS/1.3.9/angular.min': { deps: ['jquery'], attach: 'mandeeps_angular' },
			//'mandeepslibraries/AngularJS/1.3.9/angular-route.min': { deps: ['use!mandeepslibraries/AngularJS/1.3.9/angular.min'], attach: 'mandeeps_angularroute' },
			//'mandeepslibraries/AngularJS/Plugins/mnCommonService/mnCommonService.min': { deps: ['use!mandeepslibraries/AngularJS/1.3.9/angular-route.min'], attach: 'mandeeps_mmcommonservice' },
			//'mandeepslibraries/HtmlParser/1.0.0/htmlparser.min': { deps: ['use!mandeepslibraries/AngularJS/Plugins/mnCommonService/mnCommonService.min'], attach: 'mandeeps_htmlparser' },
			//'mandeepslibraries/HtmlParser/1.0.0/htmlparser.min': { deps: ['jquery'], attach: 'mandeeps_htmlparser' },
			//'mandeepslibraries/Html2Json/1.0.0/html2json.min': { deps: ['use!mandeepslibraries/HtmlParser/1.0.0/htmlparser.min'], attach: 'mandeeps_html2json' },
			//'mandeepslibraries/AngularJS/Plugins/SweetAlert/alert.min': { deps: ['use!mandeepslibraries/Html2Json/1.0.0/html2json.min'], attach: 'mandeeps_alert' },
			'mandeepslibraries/AngularJS/Plugins/SweetAlert/SweetAlert.min': { deps: ['jquery'], attach: 'mandeeps_sweetalert' },
			//'mandeepslibraries/AngularJS/Plugins/loading-bar/loading-bar.min': { deps: ['use!mandeepslibraries/AngularJS/Plugins/SweetAlert/SweetAlert.min'], attach: 'mandeeps_loadingbar' },
			//'mandeepslibraries/WebAPI/1.0.0/webAPI.min': { deps: ['use!mandeepslibraries/AngularJS/Plugins/loading-bar/loading-bar.min'], attach: 'mandeeps_webapi' },

			// Modo edición
			'admin/menus/ModuleActions/ModuleActions': { deps: ['jquery'], attach: 'ModuleActions' },
			'global/dnn.extensions': { deps: ['jquery'], attach: 'dnnextensions' },
			'global/dnn.jquery.extensions': { deps: ['jquery'], attach: 'dnnjqueryextensions' },
			'global/dnn.DataStructures': { deps: ['jquery'], attach: 'dnndatastructures' },
			'global/jquery/jquery.mousewheel': { deps: ['jquery'], attach: 'jquerymousewheel' },
			'global/jquery/dnn.jScrollBar': { deps: ['jquery'], attach: 'dnnjscrollbar' },
			'global/TreeView/dnn.TreeView': { deps: ['jquery'], attach: 'dnntreview' },
			'global/TreeView/dnn.DynamicTreeView': { deps: ['jquery'], attach: 'dnndynamictreeview' },
			'components/DropDownList/dnn.DropDownList': { deps: ['jquery'], attach: 'dnndropdownlist' },
			'editbar/Resources/ContentEditorManager/Js/ModuleManager': { deps: ['jquery'], attach: 'modulemanager' },
			'editbar/Resources/ContentEditorManager/Js/ModuleDialog': { deps: ['jquery'], attach: 'moduledialog' },
			'editbar/Resources/ContentEditorManager/Js/ExistingModuleDialog': { deps: ['jquery'], attach: 'existingmoduledialog' },
			'editbar/Resources/ContentEditorManager/Js/ModuleService': { deps: ['jquery'], attach: 'moduleservice' },
			'editbar/Resources/ContentEditorManager/Js/ContentEditor': { deps: ['jquery'], attach: 'contenteditor' },
			'editbar/scripts/editBarContainer': { deps: ['jquery'], attach: 'editbarcontainer' },
			'global/dnn.dragDrop': { deps: ['use!global/dnn.jquery'], attach: 'dnndragdrop' },
		}
	});
	// Token input es un script de admin, solo debería llamarse en admin
	//require(['use!dnn/dnncore'], function (dnncore) { });
	require(['use!dnn/dnncore', 'use!dnn/dnn.xmlhttp', 'use!dnn/dnn.xmlhttp.jsxmlhttprequest', 'use!dnn/dnn.controls.dnnlabeledit', 'use!dnn/dnn.motion', 'use!dnn/dnn.dom.positioning'], function (dnncore, dnnxmlhttp, dnnxmlhttpjsxmlhttprequest, dnncontrolsdnnlabeledit, dnnmotion) { });
	// Administracion
	require(['use!components/Tokeninput/jquery.tokeninput', 'use!dnn/Debug/dnn.servicesframework', 'use!global/dnn.jquery', 'use!porto/Resources/js/AMD_jquery.colorpicker.min', 'use!porto/Resources/js/less'], function (tokenInput, servicesFramework, dnnJquery, colorPicker, less) { });
	// Administracion - Skin
	//require(['use!mandeepslibraries/WebAPI/1.0.0/webAPI.min'], function (moduleActions) { });
	// Modo edición
	require(['use!admin/menus/ModuleActions/ModuleActions', 'use!global/dnn.extensions', 'use!global/dnn.jquery.extensions', 'use!global/dnn.DataStructures', 'use!global/jquery/jquery.mousewheel', 'use!global/jquery/dnn.jScrollBar', 'use!global/TreeView/dnn.TreeView', 'use!global/TreeView/dnn.DynamicTreeView', 'use!components/DropDownList/dnn.DropDownList', 'use!global/dnn.dragDrop'], function (moduleActions, dnnExtensions, dnnJqueryExtensions, dnnDataStructures, jqueryMouseWheel, dnnScrollBar, dnnTreeview, dnnDynamicTreeView, dnnDropDownList, dnnDragDrop) { });

	if (incluirEditBar) {
		require(['use!editbar/Resources/ContentEditorManager/Js/ModuleManager', 'use!editbar/Resources/ContentEditorManager/Js/ModuleDialog', 'use!editbar/Resources/ContentEditorManager/Js/ExistingModuleDialog', 'use!editbar/Resources/ContentEditorManager/Js/ModuleService', 'use!editbar/Resources/ContentEditorManager/Js/ContentEditor', 'use!editbar/scripts/editBarContainer'], function (editBarModuleManager, editBarModuleDialog, editBarExistingModuleDialog, editBarModuleService, editBarContentEditor, editBarContainer) { });
	}
}