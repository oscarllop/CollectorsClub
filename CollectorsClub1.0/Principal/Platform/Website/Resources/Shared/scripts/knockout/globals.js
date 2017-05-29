var pagesId = {
	listaClientes: '#pageCuponesGestionClientes',
	listaCartera: '#pageCarteraClientes',
	asigancionAsesores: '#pagePeriodosCupones',
	distribucionManual: '#pageDistribucionManual',
	reaperturaCupones: '#pageReaperturaCupones',
	reentradaCupones: '#pageReentradaCupones'
};

// Tipo de ordenación de query
var T_ORDER_QUERY = {
    asc: 'ASC',
    desc: 'DESC'
};

// Comienzo de clave de cada módulo para almacenar datos en session storage
var SESSIONSSTORAGE_MODULE_KEYS = {
    clientes: $(pagesId.listaClientes)[0] ? getIdPersona() + '_CF' : null, // Clientes por Filtros
    carteraClientes: $(pagesId.listaCartera)[0] ? getIdPersona() + '_CARTERA' : null, // Cartera de clientes
    periodosCupones: $(pagesId.asigancionAsesores)[0] ? getIdPersona() + '_PERIODOSCUPONES' : null, // Periodos de cupones
    distribucion: $(pagesId.distribucionManual)[0] ? getIdPersona() + '_DISTRIBUCION' : null, // Distribución de cupones
    reaperturaCupones: $(pagesId.reaperturaCupones)[0] ? getIdPersona() + '_REAPERTURA' : null, // Reapertura de cupones
    reentradaCupones: $(pagesId.reentradaCupones)[0] ? getIdPersona() + '_REENTRADA' : null // Reentrada de cupones
};