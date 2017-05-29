function NumPageItem(numPage) {
	var self = this;

	self.numPage = ko.observable(numPage);
}

/*
options:
* columnHeaders: Array de columnas a mostrar
Cada elemento es un objeto con la siguiente estructura:
{index: Identifica el índice [entero], desc: Descripción a mostrar en la vista [string], visible: columna visible o no [bool], internalDesc: columna/columnas (separadas por comas) origen [string]}  
* list: Array de elementos a motrar en la página
* orderBy: Cláusula ORDER BY por defecto que se enviará al servidor para devolver datos ordenados
* getDTORequestFromView: Función que devuelve un objeto con los datos a enviar en la petición al servidor
* getPageFromServer: Función que devuelve una página de datos desde el servidor
* sessionStorageKey: String que representa el comienzao de la clave para almacenar en Session Storage. No establecer si no se desea guardar en memoria
* onReceiveData: Función que se ejecuta cuando se devuelve el array de elementos tras la función ajax
* onUpdateListFromSessionStorage: Functión que se ejecuta cuando se consultan los datos en sessionStorage
*/

function PagedList(options) {
	var self = this;

	self.defaultNumPagesOfSetOfPages = 9;
	self.columnHeaders = ko.observableArray(options.columnHeaders || []);
	self.list = ko.observableArray(options.list || []);
	self.orderBy = options.orderBy;
	self.getDTORequestFromView = options.getDTORequestFromView;
	self.getPageFromServer = options.getPageFromServer;
	self.sessionStorageKey = options.sessionStorageKey;
	self.onReceiveData = options.onReceiveData;
	self.onUpdateListFromSessionStorage = options.onUpdateListFromSessionStorage;

	self.enabledPageIndexChangedSubscription = 1;
	self.setOfPages = ko.observableArray([]); // Lista de números de páginas. Permite navegación aleatoria
	self.currentPageIndex = ko.observable(-1);
	self.totalPages = ko.observable(0);
	self.totalPages.subscribe(function(newValue) {
		self.setOfPages([]);
		var aux = [],
        limit = newValue < self.defaultNumPagesOfSetOfPages ? newValue : self.defaultNumPagesOfSetOfPages;
		for (var i = 0; i < limit; i++) {
			aux.push(new NumPageItem(i + 1));
		}
		self.setOfPages(aux);
	});
	self.totalRegisters = ko.observable(0); // Nº total de registros
	self.totalRegisters.subscribe(function(newValue) {
		self.totalPages(Math.ceil(self.totalRegisters() / self.selectedPageSize()));
	});
	self.pageSizes = ko.observableArray([10, 50, 100, 200, 500]);
	self.selectedPageSize = ko.observable(50);
	self.currentOrderColumn = ko.observable(self.columnHeaders()[0]);
	self.currentOrderDirection = ko.observable(T_ORDER_QUERY.asc);
	self.loading = ko.observable(0); // Muestra u oculta el loading
	self.currentDTORequest = null;

	// commands
	self.getPageCommand = function() {
		// Si se pulsa el botón buscar, se comienza desde la primera página
		self.currentPageIndex(0);
		self.getPage();
	};
	self.nextPage = function() {
		if (self.totalPages() <= 1) return;

		if (((self.currentPageIndex() + 1) * self.selectedPageSize()) < self.totalRegisters()) {
			self.currentPageIndex(self.currentPageIndex() + 1);
		}
		else {
			self.currentPageIndex(0);
		}
	};
	self.previousPage = function() {
		if (self.totalPages() <= 1) return;

		if (self.currentPageIndex() > 0) {
			self.currentPageIndex(self.currentPageIndex() - 1);
		}
		else {
			self.currentPageIndex((Math.ceil(self.totalRegisters() / self.selectedPageSize())) - 1);
		}
	};
	self.goToPage = function(numPageItem) {
		self.currentPageIndex(numPageItem.numPage() - 1);
	};
	self.nextSetOfPages = function() {
		var a = self.setOfPages();
		if (a.length > 0) {
			var currentLast = a[a.length - 1].numPage();
			self.updateSetOfPages(currentLast + 1);
		}
	};
	self.previousSetOfPages = function() {
		var a = self.setOfPages();
		if (a.length > 0) {
			var currentFirst = a[0].numPage();
			self.updateSetOfPages(currentFirst - 1);
		}
	};
	self.orderByCommand = function(c) {
		self.orderBy = '';
		// Si se marca la misma columna otra vez, se ordena a la inversa
		if (self.currentOrderColumn().index == c.index) {
			self.currentOrderDirection(self.currentOrderDirection() == T_ORDER_QUERY.asc ? T_ORDER_QUERY.desc : T_ORDER_QUERY.asc);
		} else { // Si se selecciona una columna diferente a la última seleccionada, se ordena ascendentemente por defecto
			self.currentOrderDirection(T_ORDER_QUERY.asc);
		}
		self.currentOrderColumn(c);
		// Se construye la claúsula Order By
		var columns = c.internalDesc.split(',');
		$.each(columns, function(i, col) {
			self.orderBy += col + ' ' + self.currentOrderDirection();
			if (i < columns.length - 1) self.orderBy += ',';
		});

		self.getPage();
	};

	// funciones
	self.getPage = function() {
		loading('+');

		self.currentDTORequest = self.getDTORequestFromView();
		var pagesize = parseInt(self.selectedPageSize(), 10);
		self.currentDTORequest.StartIndex = pagesize * self.currentPageIndex() + 1,
        self.currentDTORequest.EndIndex = self.currentDTORequest.StartIndex + pagesize - 1;

		// Llamada AJAX para obtener página
		self.getPageFromServer()
        .done(function(res) {
        	//self.list(res.rows);
        	if (typeof self.onReceiveData === "function") {
        		self.onReceiveData(res.rows);
        	} else {
        		self.list(res.rows);
        	}
        	self.totalRegisters(res.totalRows);
        	self.totalPages(Math.ceil(self.totalRegisters() / self.selectedPageSize()));
        	self.saveInSessionStorage();
        })
        .fail(function(e) {

        })
        .always(function() {
        	loading('-');
        });
	};

	self.currentPageIndex.subscribe(function(newValue) {
		if (!self.enabledPageIndexChangedSubscription) return;

		if (newValue >= 0 && self.totalPages() > 1) {
			self.getPage();
		}

		// Actualizar conjuto de páginas seleccionable
		self.updateSetOfPages(self.currentPageIndex());
	});

	self.updateSetOfPages = function(currentIndex) {
		// Si la página seleccionada es mayor/menor de la mitad del conjunto visible y hay más de defaultNumPagesOfSetOfPages páginas:
		if ((currentIndex + 1 > Math.ceil(self.defaultNumPagesOfSetOfPages / 2)
            || currentIndex + 1 < Math.ceil(self.defaultNumPagesOfSetOfPages / 2))
            && self.totalPages() > self.defaultNumPagesOfSetOfPages) {
			// se centra la página seleccionada en el conjunto de páginas seleccionables
			var a = currentIndex - Math.floor(self.defaultNumPagesOfSetOfPages / 2),
            b = currentIndex + 1 + Math.floor(self.defaultNumPagesOfSetOfPages / 2),
            aux = [];
			self.setOfPages([]);

			//a = a < 0 ? 0 : a;
			if (a < 0) {
				a = 0;
				b = b < self.totalPages() ? b - (currentIndex - Math.floor(self.defaultNumPagesOfSetOfPages / 2)) : self.totalPages();
			}
			if (b > self.totalPages()) {
				b = self.totalPages();
			}

			for (var i = a; i < b; i++) {
				aux.push(new NumPageItem(i + 1));
			}
			self.setOfPages(aux);
		}
	}

	self.showGoToPreviousSetOfPages = ko.computed(function() {
		if (self.setOfPages().length > 0) {
			return self.setOfPages()[0].numPage() != 1;
		} else {
			return false;
		}
	});
	self.showGoToNextSetOfPages = ko.computed(function() {
		if (self.setOfPages().length > 0) {
			return self.setOfPages()[self.setOfPages().length - 1].numPage() != self.totalPages();
		} else {
			return false;
		}
	});

	self.saveInSessionStorage = function() {
		if (!sessionStorage) return;
		if (!self.sessionStorageKey) return;
		if (self.list().length == 0) return;

		sessionStorage.setItem(self.sessionStorageKey + '_list', JSON.stringify(ko.toJS(self.list())));
		sessionStorage.setItem(self.sessionStorageKey + '_totalPages', self.totalPages());
		sessionStorage.setItem(self.sessionStorageKey + '_totalRegisters', self.totalRegisters());
		sessionStorage.setItem(self.sessionStorageKey + '_currentPageIndex', self.currentPageIndex());
		sessionStorage.setItem(self.sessionStorageKey + '_selectedPageSize', self.selectedPageSize());
		sessionStorage.setItem(self.sessionStorageKey + '_orderBy', self.orderBy);
	}

	self.selectFromSessionStorage = function() {
		if (!sessionStorage) return;
		if (!self.sessionStorageKey) return;

		self.enabledPageIndexChangedSubscription = 0;

		// Es importante el orden, ya que se pueden lanzar eventos subscribe de los observables
		if (typeof self.onUpdateListFromSessionStorage === "function") {
			var l = $.parseJSON(sessionStorage.getItem(self.sessionStorageKey + '_list')) || [];
			self.onUpdateListFromSessionStorage(l);
		} else {
			self.list($.parseJSON(sessionStorage.getItem(self.sessionStorageKey + '_list')) || []);
		}

		self.orderBy = sessionStorage.getItem(self.sessionStorageKey + '_orderBy') || self.orderBy;
		self.selectedPageSize($.parseJSON(sessionStorage.getItem(self.sessionStorageKey + '_selectedPageSize')) || 50);
		self.totalPages($.parseJSON(sessionStorage.getItem(self.sessionStorageKey + '_totalPages')) || 0);
		self.totalRegisters($.parseJSON(sessionStorage.getItem(self.sessionStorageKey + '_totalRegisters')) || 0);
		var pageIndex = ($.parseJSON(sessionStorage.getItem(self.sessionStorageKey + '_currentPageIndex')));

		self.currentPageIndex(self.totalRegisters() == 0 ? 0 : pageIndex);

		self.enabledPageIndexChangedSubscription = 1;
	}

	self.clearSessionStorage = function() {
		if (!sessionStorage) return;
		sessionStorage.clear();
	}

	self.clear = function() {
		self.enabledPageIndexChangedSubscription = 0;

		self.list([]);
		self.selectedPageSize(50);
		self.totalRegisters(0);
		self.currentPageIndex(-1);

		self.enabledPageIndexChangedSubscription = 1;

		self.clearSessionStorage();
	}
}