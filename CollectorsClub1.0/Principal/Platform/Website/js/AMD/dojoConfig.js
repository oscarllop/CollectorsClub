if (typeof dojoConfig === 'undefined') {
	var dojoConfig = {
		baseUrl: '~/js/AMD',
		tlmSiblingOfDojo: false,
		//paths: {
		//	'Noty': '~/Resources/Shared/scripts/noty/jquery.noty.packaged.min.js',
		//},
		packages: [
			{ name: 'dojo', location: '~/Resources/Shared/scripts/dojo/dojo' },
			{ name: 'dojox', location: '~/Resources/Shared/scripts/dojo/dojox' },
			{ name: 'global', location: '~/Resources/Shared/scripts' },
			{ name: 'components', location: '~/Resources/Shared/Components' },
			{ name: 'search', location: '~/Resources/Search' },
			{ name: 'partials', location: '~/Partials' },
			{ name: 'dnn', location: '~/js' },
			{ name: 'skinDNNMega', location: '~/Portals/_default/Skins/WoodStylesMenu1_SocialBar/DNNMega' },
			{ name: 'WebAPI', location: _urlWebAPI + '/scripts' },
			{ name: 'porto', location: '~/Portals/_default/Skins/Porto' },
			{ name: 'admin', location: '~/admin' },
			{ name: 'mandeepslibraries', location: '~/DesktopModules/Mandeeps/Libraries/Common/Frameworks' },
			{ name: 'editbar', location: '~/DesktopModules/admin/Dnn.EditBar' },
		],
		aliases: [
			['dependencyLib', 'Plugins/inputmask/dependencyLib'],
			['inputmask', 'Plugins/inputmask/inputmask'],
			['knockout', 'knockout-3.3.0'],
			['jquery.ui.widget', 'Plugins/FileUpload/jquery.ui.widget'],
			['knockout.validation', 'global/knockout/knockout.validation.min'],
			['adobeeditor', 'https://dme0ih8comzn4.cloudfront.net/imaging/v3/editor.js']
		],
		deps: ['jquery', 'jquery-ui-1.11.4/jquery-ui.min', 'jquery.cookie', 'https://maps.googleapis.com/maps/api/js?key=AIzaSyDRe9Auu84IsLUhinIhQARG5m8ADRnvoxg'],
		cacheBust: 'cdv=' + versionScripts
	};
}