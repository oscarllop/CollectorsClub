
USE GeneradorMetadata;
GO

declare @IdEntidad as smallint

------------------------------- Inicio script del módulo Calendario  ------------------------------

set @IdEntidad  = (SELECT Id FROM Entidades WHERE Aplicacion = 'CollectorsClub' AND Nombre = 'Calendario')
if (@IdEntidad IS NULL)
begin
	INSERT INTO Entidades (Aplicacion, Nombre) VALUES ('CollectorsClub', 'Calendario')	
	set @IdEntidad = Scope_Identity()
end

 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Calendario' AND Propiedad = 'Id')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Calendario', 'Id', 'Id', 14, 21, 4, 4, 4, 1, 1);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Calendario' AND Propiedad = 'Nombre')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Calendario', 'Nombre', 'Nombre', 1, 17, 1, 1, 1, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Calendario' AND Propiedad = 'IdTipoColeccion')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Calendario', 'IdTipoColeccion', 'IdTipoColeccion', 8, 19, 8, 8, 8, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Calendario' AND Propiedad = 'IdCategoria')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Calendario', 'IdCategoria', 'IdCategoria', 8, 19, 8, 8, 8, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Calendario' AND Propiedad = 'IdSubcategoria')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Calendario', 'IdSubcategoria', 'IdSubcategoria', 8, 19, 8, 8, 8, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Calendario' AND Propiedad = 'Codigo')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Calendario', 'Codigo', 'Codigo', 1, 17, 1, 1, 1, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Calendario' AND Propiedad = 'Anyo')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Calendario', 'Anyo', 'Anyo', 1, 17, 1, 1, 1, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Calendario' AND Propiedad = 'Serie')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Calendario', 'Serie', 'Serie', 1, 17, 1, 1, 1, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Calendario' AND Propiedad = 'IdEntidad')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Calendario', 'IdEntidad', 'IdEntidad', 8, 19, 8, 8, 8, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Calendario' AND Propiedad = 'NumeroRepetidos')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Calendario', 'NumeroRepetidos', 'NumeroRepetidos', 14, 21, 4, 4, 4, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Calendario' AND Propiedad = 'NumeroSerie')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Calendario', 'NumeroSerie', 'NumeroSerie', 1, 17, 1, 1, 1, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Calendario' AND Propiedad = 'IdEstado')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Calendario', 'IdEstado', 'IdEstado', 8, 19, 8, 8, 8, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Calendario' AND Propiedad = 'DL')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Calendario', 'DL', 'DL', 1, 17, 1, 1, 1, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Calendario' AND Propiedad = 'IdEntidadContratante')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Calendario', 'IdEntidadContratante', 'IdEntidadContratante', 8, 19, 8, 8, 8, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Calendario' AND Propiedad = 'Variante')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Calendario', 'Variante', 'Variante', 1, 17, 1, 1, 1, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Calendario' AND Propiedad = 'IdFabricante')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Calendario', 'IdFabricante', 'IdFabricante', 8, 19, 8, 8, 8, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Calendario' AND Propiedad = 'PaginaWeb')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Calendario', 'PaginaWeb', 'PaginaWeb', 1, 17, 1, 1, 1, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Calendario' AND Propiedad = 'IdUsuario')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Calendario', 'IdUsuario', 'IdUsuario', 8, 19, 8, 8, 8, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Calendario' AND Propiedad = 'Imagen')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Calendario', 'Imagen', 'Imagen', 1, 17, 47, 47, 47, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Calendario' AND Propiedad = 'ImagenEnBinario')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Calendario', 'ImagenEnBinario', 'ImagenEnBinario', 25, 25, 25, 25, 25, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Calendario' AND Propiedad = 'Visible')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Calendario', 'Visible', 'Visible', 6, 20, 12, 6, 6, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Calendario' AND Propiedad = 'IdMarca')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Calendario', 'IdMarca', 'IdMarca', 8, 1, 8, 8, 8, 1, 1);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Calendario' AND Propiedad = 'Entidad')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario) VALUES ('CollectorsClub', @IdEntidad, 'Calendario', 'Entidad', 'Entidad', 25, 19, 25, 25, 25, 0, 1, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Calendario' AND Propiedad = 'EntidadContratante')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario) VALUES ('CollectorsClub', @IdEntidad, 'Calendario', 'EntidadContratante', 'EntidadContratante', 25, 19, 25, 25, 25, 0, 1, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Calendario' AND Propiedad = 'Estado')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario) VALUES ('CollectorsClub', @IdEntidad, 'Calendario', 'Estado', 'Estado', 25, 19, 25, 25, 25, 0, 1, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Calendario' AND Propiedad = 'Fabricante')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario) VALUES ('CollectorsClub', @IdEntidad, 'Calendario', 'Fabricante', 'Fabricante', 25, 19, 25, 25, 25, 0, 1, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Calendario' AND Propiedad = 'TipoColeccionCalendario')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario) VALUES ('CollectorsClub', @IdEntidad, 'Calendario', 'TipoColeccionCalendario', 'TipoColeccionCalendario', 25, 19, 25, 25, 25, 0, 1, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Calendario' AND Propiedad = 'Categoria')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario) VALUES ('CollectorsClub', @IdEntidad, 'Calendario', 'Categoria', 'Categoria', 25, 19, 25, 25, 25, 0, 1, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Calendario' AND Propiedad = 'Subcategoria')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario) VALUES ('CollectorsClub', @IdEntidad, 'Calendario', 'Subcategoria', 'Subcategoria', 25, 19, 25, 25, 25, 0, 1, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Calendario' AND Propiedad = 'Usuario')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario) VALUES ('CollectorsClub', @IdEntidad, 'Calendario', 'Usuario', 'Usuario', 25, 19, 25, 25, 25, 0, 1, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Calendario' AND Propiedad = 'Marca')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario) VALUES ('CollectorsClub', @IdEntidad, 'Calendario', 'Marca', 'Marca', 25, 19, 25, 25, 25, 0, 1, 0);
end
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Calendario' AND Propiedad = 'RegistrosIdiomas')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario, PermitirCrear, PermitirGuardar, PermitirBorrar, BusquedaAutomatica, IdModoInicio, HabilitarFiltro) VALUES ('CollectorsClub', @IdEntidad,'Calendario', 'RegistrosIdiomas', 'RegistrosIdiomas', 25, 35, 29, 29, 29, 0, 0, 0, 1, 1, 1, 1, 1, 1);
end
------------------------------- Fin script del módulo Calendario  ------------------------------

------------------------------- Inicio script del módulo Calendario_Idioma  ------------------------------

set @IdEntidad  = (SELECT Id FROM Entidades WHERE Aplicacion = 'CollectorsClub' AND Nombre = 'Calendario_Idioma')
if (@IdEntidad IS NULL)
begin
	INSERT INTO Entidades (Aplicacion, Nombre) VALUES ('CollectorsClub', 'Calendario_Idioma')	
	set @IdEntidad = Scope_Identity()
end

 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Calendario_Idioma' AND Propiedad = 'Id')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Calendario_Idioma', 'Id', 'Id', 14, 21, 4, 4, 4, 1, 1);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Calendario_Idioma' AND Propiedad = 'IdRegistro')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Calendario_Idioma', 'IdRegistro', 'IdRegistro', 8, 19, 8, 8, 8, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Calendario_Idioma' AND Propiedad = 'Cultura')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Calendario_Idioma', 'Cultura', 'Cultura', 1, 17, 1, 1, 1, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Calendario_Idioma' AND Propiedad = 'Nombre')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Calendario_Idioma', 'Nombre', 'Nombre', 1, 17, 1, 1, 1, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Calendario_Idioma' AND Propiedad = 'Variante')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Calendario_Idioma', 'Variante', 'Variante', 1, 17, 1, 1, 1, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Calendario_Idioma' AND Propiedad = 'Registro')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario) VALUES ('CollectorsClub', @IdEntidad, 'Calendario_Idioma', 'Registro', 'Registro', 25, 19, 25, 25, 25, 0, 1, 0);
end
------------------------------- Fin script del módulo Calendario_Idioma  ------------------------------

------------------------------- Inicio script del módulo CategoriaCalendario  ------------------------------

set @IdEntidad  = (SELECT Id FROM Entidades WHERE Aplicacion = 'CollectorsClub' AND Nombre = 'CategoriaCalendario')
if (@IdEntidad IS NULL)
begin
	INSERT INTO Entidades (Aplicacion, Nombre) VALUES ('CollectorsClub', 'CategoriaCalendario')	
	set @IdEntidad = Scope_Identity()
end

 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'CategoriaCalendario' AND Propiedad = 'Id')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'CategoriaCalendario', 'Id', 'Id', 14, 21, 4, 4, 4, 1, 1);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'CategoriaCalendario' AND Propiedad = 'Nombre')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'CategoriaCalendario', 'Nombre', 'Nombre', 1, 17, 1, 1, 1, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'CategoriaCalendario' AND Propiedad = 'Codigo')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'CategoriaCalendario', 'Codigo', 'Codigo', 1, 17, 1, 1, 1, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'CategoriaCalendario' AND Propiedad = 'IdMarca')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'CategoriaCalendario', 'IdMarca', 'IdMarca', 8, 1, 8, 8, 8, 1, 1);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'CategoriaCalendario' AND Propiedad = 'Marca')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario) VALUES ('CollectorsClub', @IdEntidad, 'CategoriaCalendario', 'Marca', 'Marca', 25, 19, 25, 25, 25, 0, 1, 0);
end
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'CategoriaCalendario' AND Propiedad = 'Subcategorias')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario, PermitirCrear, PermitirGuardar, PermitirBorrar, BusquedaAutomatica, IdModoInicio, HabilitarFiltro) VALUES ('CollectorsClub', @IdEntidad,'CategoriaCalendario', 'Subcategorias', 'Subcategorias', 25, 35, 29, 29, 29, 0, 0, 0, 1, 1, 1, 1, 1, 1);
end
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'CategoriaCalendario' AND Propiedad = 'RegistrosIdiomas')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario, PermitirCrear, PermitirGuardar, PermitirBorrar, BusquedaAutomatica, IdModoInicio, HabilitarFiltro) VALUES ('CollectorsClub', @IdEntidad,'CategoriaCalendario', 'RegistrosIdiomas', 'RegistrosIdiomas', 25, 35, 29, 29, 29, 0, 0, 0, 1, 1, 1, 1, 1, 1);
end
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'CategoriaCalendario' AND Propiedad = 'Calendarios')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario, PermitirCrear, PermitirGuardar, PermitirBorrar, BusquedaAutomatica, IdModoInicio, HabilitarFiltro) VALUES ('CollectorsClub', @IdEntidad,'CategoriaCalendario', 'Calendarios', 'Calendarios', 25, 35, 29, 29, 29, 0, 0, 0, 1, 1, 1, 1, 1, 1);
end
------------------------------- Fin script del módulo CategoriaCalendario  ------------------------------

------------------------------- Inicio script del módulo CategoriaCalendario_Idioma  ------------------------------

set @IdEntidad  = (SELECT Id FROM Entidades WHERE Aplicacion = 'CollectorsClub' AND Nombre = 'CategoriaCalendario_Idioma')
if (@IdEntidad IS NULL)
begin
	INSERT INTO Entidades (Aplicacion, Nombre) VALUES ('CollectorsClub', 'CategoriaCalendario_Idioma')	
	set @IdEntidad = Scope_Identity()
end

 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'CategoriaCalendario_Idioma' AND Propiedad = 'Id')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'CategoriaCalendario_Idioma', 'Id', 'Id', 14, 21, 4, 4, 4, 1, 1);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'CategoriaCalendario_Idioma' AND Propiedad = 'IdRegistro')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'CategoriaCalendario_Idioma', 'IdRegistro', 'IdRegistro', 14, 21, 4, 4, 4, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'CategoriaCalendario_Idioma' AND Propiedad = 'Cultura')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'CategoriaCalendario_Idioma', 'Cultura', 'Cultura', 1, 17, 1, 1, 1, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'CategoriaCalendario_Idioma' AND Propiedad = 'Nombre')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'CategoriaCalendario_Idioma', 'Nombre', 'Nombre', 1, 17, 1, 1, 1, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'CategoriaCalendario_Idioma' AND Propiedad = 'Registro')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario) VALUES ('CollectorsClub', @IdEntidad, 'CategoriaCalendario_Idioma', 'Registro', 'Registro', 25, 19, 25, 25, 25, 0, 1, 0);
end
------------------------------- Fin script del módulo CategoriaCalendario_Idioma  ------------------------------

------------------------------- Inicio script del módulo CategoriaFoto  ------------------------------

set @IdEntidad  = (SELECT Id FROM Entidades WHERE Aplicacion = 'CollectorsClub' AND Nombre = 'CategoriaFoto')
if (@IdEntidad IS NULL)
begin
	INSERT INTO Entidades (Aplicacion, Nombre) VALUES ('CollectorsClub', 'CategoriaFoto')	
	set @IdEntidad = Scope_Identity()
end

 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'CategoriaFoto' AND Propiedad = 'Id')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'CategoriaFoto', 'Id', 'Id', 14, 21, 4, 4, 4, 1, 1);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'CategoriaFoto' AND Propiedad = 'FechaAlta')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'CategoriaFoto', 'FechaAlta', 'FechaAlta', 39, 40, 38, 38, 38, 1, 1);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'CategoriaFoto' AND Propiedad = 'FechaUltimaModificacion')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'CategoriaFoto', 'FechaUltimaModificacion', 'FechaUltimaModificacion', 39, 40, 38, 38, 38, 1, 1);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'CategoriaFoto' AND Propiedad = 'Activa')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'CategoriaFoto', 'Activa', 'Activa', 6, 20, 12, 6, 6, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'CategoriaFoto' AND Propiedad = 'Orden')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'CategoriaFoto', 'Orden', 'Orden', 14, 21, 4, 4, 4, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'CategoriaFoto' AND Propiedad = 'Nombre')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'CategoriaFoto', 'Nombre', 'Nombre', 1, 17, 1, 1, 1, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'CategoriaFoto' AND Propiedad = 'IdMarca')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'CategoriaFoto', 'IdMarca', 'IdMarca', 8, 1, 8, 8, 8, 1, 1);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'CategoriaFoto' AND Propiedad = 'Marca')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario) VALUES ('CollectorsClub', @IdEntidad, 'CategoriaFoto', 'Marca', 'Marca', 25, 19, 25, 25, 25, 0, 1, 0);
end
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'CategoriaFoto' AND Propiedad = 'RegistrosIdiomas')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario, PermitirCrear, PermitirGuardar, PermitirBorrar, BusquedaAutomatica, IdModoInicio, HabilitarFiltro) VALUES ('CollectorsClub', @IdEntidad,'CategoriaFoto', 'RegistrosIdiomas', 'RegistrosIdiomas', 25, 35, 29, 29, 29, 0, 0, 0, 1, 1, 1, 1, 1, 1);
end
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'CategoriaFoto' AND Propiedad = 'Fotos')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario, PermitirCrear, PermitirGuardar, PermitirBorrar, BusquedaAutomatica, IdModoInicio, HabilitarFiltro) VALUES ('CollectorsClub', @IdEntidad,'CategoriaFoto', 'Fotos', 'Fotos', 25, 35, 29, 29, 29, 0, 0, 0, 1, 1, 1, 1, 1, 1);
end
------------------------------- Fin script del módulo CategoriaFoto  ------------------------------

------------------------------- Inicio script del módulo CategoriaFoto_Idioma  ------------------------------

set @IdEntidad  = (SELECT Id FROM Entidades WHERE Aplicacion = 'CollectorsClub' AND Nombre = 'CategoriaFoto_Idioma')
if (@IdEntidad IS NULL)
begin
	INSERT INTO Entidades (Aplicacion, Nombre) VALUES ('CollectorsClub', 'CategoriaFoto_Idioma')	
	set @IdEntidad = Scope_Identity()
end

 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'CategoriaFoto_Idioma' AND Propiedad = 'Id')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'CategoriaFoto_Idioma', 'Id', 'Id', 14, 21, 4, 4, 4, 1, 1);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'CategoriaFoto_Idioma' AND Propiedad = 'IdRegistro')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'CategoriaFoto_Idioma', 'IdRegistro', 'IdRegistro', 8, 19, 8, 8, 8, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'CategoriaFoto_Idioma' AND Propiedad = 'Cultura')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'CategoriaFoto_Idioma', 'Cultura', 'Cultura', 1, 17, 1, 1, 1, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'CategoriaFoto_Idioma' AND Propiedad = 'Nombre')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'CategoriaFoto_Idioma', 'Nombre', 'Nombre', 1, 17, 1, 1, 1, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'CategoriaFoto_Idioma' AND Propiedad = 'Registro')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario) VALUES ('CollectorsClub', @IdEntidad, 'CategoriaFoto_Idioma', 'Registro', 'Registro', 25, 19, 25, 25, 25, 0, 1, 0);
end
------------------------------- Fin script del módulo CategoriaFoto_Idioma  ------------------------------

------------------------------- Inicio script del módulo Entidad  ------------------------------

set @IdEntidad  = (SELECT Id FROM Entidades WHERE Aplicacion = 'CollectorsClub' AND Nombre = 'Entidad')
if (@IdEntidad IS NULL)
begin
	INSERT INTO Entidades (Aplicacion, Nombre) VALUES ('CollectorsClub', 'Entidad')	
	set @IdEntidad = Scope_Identity()
end

 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Entidad' AND Propiedad = 'Id')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Entidad', 'Id', 'Id', 14, 21, 4, 4, 4, 1, 1);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Entidad' AND Propiedad = 'Nombre')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Entidad', 'Nombre', 'Nombre', 1, 17, 1, 1, 1, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Entidad' AND Propiedad = 'Codigo')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Entidad', 'Codigo', 'Codigo', 1, 17, 1, 1, 1, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Entidad' AND Propiedad = 'IdMarca')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Entidad', 'IdMarca', 'IdMarca', 8, 1, 8, 8, 8, 1, 1);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Entidad' AND Propiedad = 'Marca')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario) VALUES ('CollectorsClub', @IdEntidad, 'Entidad', 'Marca', 'Marca', 25, 19, 25, 25, 25, 0, 1, 0);
end
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Entidad' AND Propiedad = 'CalendariosPorEntidad')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario, PermitirCrear, PermitirGuardar, PermitirBorrar, BusquedaAutomatica, IdModoInicio, HabilitarFiltro) VALUES ('CollectorsClub', @IdEntidad,'Entidad', 'CalendariosPorEntidad', 'CalendariosPorEntidad', 25, 35, 29, 29, 29, 0, 0, 0, 1, 1, 1, 1, 1, 1);
end
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Entidad' AND Propiedad = 'CalendariosPorEntidadContratante')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario, PermitirCrear, PermitirGuardar, PermitirBorrar, BusquedaAutomatica, IdModoInicio, HabilitarFiltro) VALUES ('CollectorsClub', @IdEntidad,'Entidad', 'CalendariosPorEntidadContratante', 'CalendariosPorEntidadContratante', 25, 35, 29, 29, 29, 0, 0, 0, 1, 1, 1, 1, 1, 1);
end
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Entidad' AND Propiedad = 'RegistrosIdiomas')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario, PermitirCrear, PermitirGuardar, PermitirBorrar, BusquedaAutomatica, IdModoInicio, HabilitarFiltro) VALUES ('CollectorsClub', @IdEntidad,'Entidad', 'RegistrosIdiomas', 'RegistrosIdiomas', 25, 35, 29, 29, 29, 0, 0, 0, 1, 1, 1, 1, 1, 1);
end
------------------------------- Fin script del módulo Entidad  ------------------------------

------------------------------- Inicio script del módulo Entidad_Idioma  ------------------------------

set @IdEntidad  = (SELECT Id FROM Entidades WHERE Aplicacion = 'CollectorsClub' AND Nombre = 'Entidad_Idioma')
if (@IdEntidad IS NULL)
begin
	INSERT INTO Entidades (Aplicacion, Nombre) VALUES ('CollectorsClub', 'Entidad_Idioma')	
	set @IdEntidad = Scope_Identity()
end

 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Entidad_Idioma' AND Propiedad = 'Id')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Entidad_Idioma', 'Id', 'Id', 14, 21, 4, 4, 4, 1, 1);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Entidad_Idioma' AND Propiedad = 'IdRegistro')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Entidad_Idioma', 'IdRegistro', 'IdRegistro', 8, 19, 8, 8, 8, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Entidad_Idioma' AND Propiedad = 'Cultura')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Entidad_Idioma', 'Cultura', 'Cultura', 1, 17, 1, 1, 1, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Entidad_Idioma' AND Propiedad = 'Nombre')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Entidad_Idioma', 'Nombre', 'Nombre', 1, 17, 1, 1, 1, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Entidad_Idioma' AND Propiedad = 'Registro')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario) VALUES ('CollectorsClub', @IdEntidad, 'Entidad_Idioma', 'Registro', 'Registro', 25, 19, 25, 25, 25, 0, 1, 0);
end
------------------------------- Fin script del módulo Entidad_Idioma  ------------------------------

------------------------------- Inicio script del módulo EstadoCalendario  ------------------------------

set @IdEntidad  = (SELECT Id FROM Entidades WHERE Aplicacion = 'CollectorsClub' AND Nombre = 'EstadoCalendario')
if (@IdEntidad IS NULL)
begin
	INSERT INTO Entidades (Aplicacion, Nombre) VALUES ('CollectorsClub', 'EstadoCalendario')	
	set @IdEntidad = Scope_Identity()
end

 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'EstadoCalendario' AND Propiedad = 'Id')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'EstadoCalendario', 'Id', 'Id', 14, 21, 4, 4, 4, 1, 1);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'EstadoCalendario' AND Propiedad = 'Nombre')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'EstadoCalendario', 'Nombre', 'Nombre', 1, 17, 1, 1, 1, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'EstadoCalendario' AND Propiedad = 'Codigo')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'EstadoCalendario', 'Codigo', 'Codigo', 1, 17, 1, 1, 1, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'EstadoCalendario' AND Propiedad = 'IdMarca')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'EstadoCalendario', 'IdMarca', 'IdMarca', 8, 1, 8, 8, 8, 1, 1);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'EstadoCalendario' AND Propiedad = 'Marca')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario) VALUES ('CollectorsClub', @IdEntidad, 'EstadoCalendario', 'Marca', 'Marca', 25, 19, 25, 25, 25, 0, 1, 0);
end
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'EstadoCalendario' AND Propiedad = 'Calendarios')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario, PermitirCrear, PermitirGuardar, PermitirBorrar, BusquedaAutomatica, IdModoInicio, HabilitarFiltro) VALUES ('CollectorsClub', @IdEntidad,'EstadoCalendario', 'Calendarios', 'Calendarios', 25, 35, 29, 29, 29, 0, 0, 0, 1, 1, 1, 1, 1, 1);
end
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'EstadoCalendario' AND Propiedad = 'RegistrosIdiomas')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario, PermitirCrear, PermitirGuardar, PermitirBorrar, BusquedaAutomatica, IdModoInicio, HabilitarFiltro) VALUES ('CollectorsClub', @IdEntidad,'EstadoCalendario', 'RegistrosIdiomas', 'RegistrosIdiomas', 25, 35, 29, 29, 29, 0, 0, 0, 1, 1, 1, 1, 1, 1);
end
------------------------------- Fin script del módulo EstadoCalendario  ------------------------------

------------------------------- Inicio script del módulo EstadoCalendario_Idioma  ------------------------------

set @IdEntidad  = (SELECT Id FROM Entidades WHERE Aplicacion = 'CollectorsClub' AND Nombre = 'EstadoCalendario_Idioma')
if (@IdEntidad IS NULL)
begin
	INSERT INTO Entidades (Aplicacion, Nombre) VALUES ('CollectorsClub', 'EstadoCalendario_Idioma')	
	set @IdEntidad = Scope_Identity()
end

 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'EstadoCalendario_Idioma' AND Propiedad = 'Id')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'EstadoCalendario_Idioma', 'Id', 'Id', 14, 21, 4, 4, 4, 1, 1);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'EstadoCalendario_Idioma' AND Propiedad = 'IdRegistro')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'EstadoCalendario_Idioma', 'IdRegistro', 'IdRegistro', 8, 19, 8, 8, 8, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'EstadoCalendario_Idioma' AND Propiedad = 'Cultura')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'EstadoCalendario_Idioma', 'Cultura', 'Cultura', 1, 17, 1, 1, 1, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'EstadoCalendario_Idioma' AND Propiedad = 'Nombre')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'EstadoCalendario_Idioma', 'Nombre', 'Nombre', 1, 17, 1, 1, 1, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'EstadoCalendario_Idioma' AND Propiedad = 'Registro')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario) VALUES ('CollectorsClub', @IdEntidad, 'EstadoCalendario_Idioma', 'Registro', 'Registro', 25, 19, 25, 25, 25, 0, 1, 0);
end
------------------------------- Fin script del módulo EstadoCalendario_Idioma  ------------------------------

------------------------------- Inicio script del módulo Evento  ------------------------------

set @IdEntidad  = (SELECT Id FROM Entidades WHERE Aplicacion = 'CollectorsClub' AND Nombre = 'Evento')
if (@IdEntidad IS NULL)
begin
	INSERT INTO Entidades (Aplicacion, Nombre) VALUES ('CollectorsClub', 'Evento')	
	set @IdEntidad = Scope_Identity()
end

 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Evento' AND Propiedad = 'Id')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Evento', 'Id', 'Id', 14, 21, 4, 4, 4, 1, 1);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Evento' AND Propiedad = 'FechaAlta')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Evento', 'FechaAlta', 'FechaAlta', 39, 40, 38, 38, 38, 1, 1);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Evento' AND Propiedad = 'FechaUltimaModificacion')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Evento', 'FechaUltimaModificacion', 'FechaUltimaModificacion', 39, 40, 38, 38, 38, 1, 1);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Evento' AND Propiedad = 'Fecha')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Evento', 'Fecha', 'Fecha', 39, 40, 38, 38, 38, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Evento' AND Propiedad = 'HoraInicio')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Evento', 'HoraInicio', 'HoraInicio', 15, 23, 5, 5, 5, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Evento' AND Propiedad = 'HoraFin')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Evento', 'HoraFin', 'HoraFin', 15, 23, 5, 5, 5, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Evento' AND Propiedad = 'IdTipo')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Evento', 'IdTipo', 'IdTipo', 8, 19, 8, 8, 8, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Evento' AND Propiedad = 'Activa')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Evento', 'Activa', 'Activa', 6, 20, 12, 6, 6, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Evento' AND Propiedad = 'IdMarca')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Evento', 'IdMarca', 'IdMarca', 8, 19, 8, 8, 8, 1, 1);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Evento' AND Propiedad = 'Nombre')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Evento', 'Nombre', 'Nombre', 1, 17, 1, 1, 1, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Evento' AND Propiedad = 'Descripcion')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Evento', 'Descripcion', 'Descripcion', 1, 18, 3, 3, 3, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Evento' AND Propiedad = 'Ubicacion')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Evento', 'Ubicacion', 'Ubicacion', 1, 18, 1, 1, 1, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Evento' AND Propiedad = 'Marca')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario) VALUES ('CollectorsClub', @IdEntidad, 'Evento', 'Marca', 'Marca', 25, 19, 25, 25, 25, 0, 1, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Evento' AND Propiedad = 'Tipo')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario) VALUES ('CollectorsClub', @IdEntidad, 'Evento', 'Tipo', 'Tipo', 25, 19, 25, 25, 25, 0, 1, 0);
end
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Evento' AND Propiedad = 'RegistrosIdiomas')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario, PermitirCrear, PermitirGuardar, PermitirBorrar, BusquedaAutomatica, IdModoInicio, HabilitarFiltro) VALUES ('CollectorsClub', @IdEntidad,'Evento', 'RegistrosIdiomas', 'RegistrosIdiomas', 25, 35, 29, 29, 29, 0, 0, 0, 1, 1, 1, 1, 1, 1);
end
------------------------------- Fin script del módulo Evento  ------------------------------

------------------------------- Inicio script del módulo Evento_Idioma  ------------------------------

set @IdEntidad  = (SELECT Id FROM Entidades WHERE Aplicacion = 'CollectorsClub' AND Nombre = 'Evento_Idioma')
if (@IdEntidad IS NULL)
begin
	INSERT INTO Entidades (Aplicacion, Nombre) VALUES ('CollectorsClub', 'Evento_Idioma')	
	set @IdEntidad = Scope_Identity()
end

 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Evento_Idioma' AND Propiedad = 'Id')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Evento_Idioma', 'Id', 'Id', 14, 21, 4, 4, 4, 1, 1);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Evento_Idioma' AND Propiedad = 'IdRegistro')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Evento_Idioma', 'IdRegistro', 'IdRegistro', 8, 19, 8, 8, 8, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Evento_Idioma' AND Propiedad = 'Cultura')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Evento_Idioma', 'Cultura', 'Cultura', 1, 17, 1, 1, 1, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Evento_Idioma' AND Propiedad = 'Ubicacion')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Evento_Idioma', 'Ubicacion', 'Ubicacion', 1, 18, 7, 7, 7, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Evento_Idioma' AND Propiedad = 'Nombre')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Evento_Idioma', 'Nombre', 'Nombre', 1, 18, 7, 7, 7, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Evento_Idioma' AND Propiedad = 'Descripcion')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Evento_Idioma', 'Descripcion', 'Descripcion', 1, 18, 3, 3, 3, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Evento_Idioma' AND Propiedad = 'Registro')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario) VALUES ('CollectorsClub', @IdEntidad, 'Evento_Idioma', 'Registro', 'Registro', 25, 19, 25, 25, 25, 0, 1, 0);
end
------------------------------- Fin script del módulo Evento_Idioma  ------------------------------

------------------------------- Inicio script del módulo Fabricante  ------------------------------

set @IdEntidad  = (SELECT Id FROM Entidades WHERE Aplicacion = 'CollectorsClub' AND Nombre = 'Fabricante')
if (@IdEntidad IS NULL)
begin
	INSERT INTO Entidades (Aplicacion, Nombre) VALUES ('CollectorsClub', 'Fabricante')	
	set @IdEntidad = Scope_Identity()
end

 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Fabricante' AND Propiedad = 'Id')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Fabricante', 'Id', 'Id', 14, 21, 4, 4, 4, 1, 1);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Fabricante' AND Propiedad = 'Nombre')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Fabricante', 'Nombre', 'Nombre', 1, 17, 1, 1, 1, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Fabricante' AND Propiedad = 'Codigo')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Fabricante', 'Codigo', 'Codigo', 1, 17, 1, 1, 1, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Fabricante' AND Propiedad = 'IdMarca')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Fabricante', 'IdMarca', 'IdMarca', 8, 1, 8, 8, 8, 1, 1);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Fabricante' AND Propiedad = 'Marca')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario) VALUES ('CollectorsClub', @IdEntidad, 'Fabricante', 'Marca', 'Marca', 25, 19, 25, 25, 25, 0, 1, 0);
end
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Fabricante' AND Propiedad = 'Calendarios')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario, PermitirCrear, PermitirGuardar, PermitirBorrar, BusquedaAutomatica, IdModoInicio, HabilitarFiltro) VALUES ('CollectorsClub', @IdEntidad,'Fabricante', 'Calendarios', 'Calendarios', 25, 35, 29, 29, 29, 0, 0, 0, 1, 1, 1, 1, 1, 1);
end
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Fabricante' AND Propiedad = 'RegistrosIdiomas')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario, PermitirCrear, PermitirGuardar, PermitirBorrar, BusquedaAutomatica, IdModoInicio, HabilitarFiltro) VALUES ('CollectorsClub', @IdEntidad,'Fabricante', 'RegistrosIdiomas', 'RegistrosIdiomas', 25, 35, 29, 29, 29, 0, 0, 0, 1, 1, 1, 1, 1, 1);
end
------------------------------- Fin script del módulo Fabricante  ------------------------------

------------------------------- Inicio script del módulo Fabricante_Idioma  ------------------------------

set @IdEntidad  = (SELECT Id FROM Entidades WHERE Aplicacion = 'CollectorsClub' AND Nombre = 'Fabricante_Idioma')
if (@IdEntidad IS NULL)
begin
	INSERT INTO Entidades (Aplicacion, Nombre) VALUES ('CollectorsClub', 'Fabricante_Idioma')	
	set @IdEntidad = Scope_Identity()
end

 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Fabricante_Idioma' AND Propiedad = 'Id')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Fabricante_Idioma', 'Id', 'Id', 14, 21, 4, 4, 4, 1, 1);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Fabricante_Idioma' AND Propiedad = 'IdRegistro')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Fabricante_Idioma', 'IdRegistro', 'IdRegistro', 8, 19, 8, 8, 8, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Fabricante_Idioma' AND Propiedad = 'Cultura')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Fabricante_Idioma', 'Cultura', 'Cultura', 1, 17, 1, 1, 1, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Fabricante_Idioma' AND Propiedad = 'Nombre')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Fabricante_Idioma', 'Nombre', 'Nombre', 1, 17, 1, 1, 1, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Fabricante_Idioma' AND Propiedad = 'Registro')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario) VALUES ('CollectorsClub', @IdEntidad, 'Fabricante_Idioma', 'Registro', 'Registro', 25, 19, 25, 25, 25, 0, 1, 0);
end
------------------------------- Fin script del módulo Fabricante_Idioma  ------------------------------

------------------------------- Inicio script del módulo Foto  ------------------------------

set @IdEntidad  = (SELECT Id FROM Entidades WHERE Aplicacion = 'CollectorsClub' AND Nombre = 'Foto')
if (@IdEntidad IS NULL)
begin
	INSERT INTO Entidades (Aplicacion, Nombre) VALUES ('CollectorsClub', 'Foto')	
	set @IdEntidad = Scope_Identity()
end

 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Foto' AND Propiedad = 'Id')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Foto', 'Id', 'Id', 14, 21, 4, 4, 4, 1, 1);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Foto' AND Propiedad = 'FechaAlta')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Foto', 'FechaAlta', 'FechaAlta', 39, 40, 38, 38, 38, 1, 1);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Foto' AND Propiedad = 'FechaUltimaModificacion')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Foto', 'FechaUltimaModificacion', 'FechaUltimaModificacion', 39, 40, 38, 38, 38, 1, 1);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Foto' AND Propiedad = 'NombreArchivoImagen')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Foto', 'NombreArchivoImagen', 'NombreArchivoImagen', 1, 17, 47, 47, 47, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Foto' AND Propiedad = 'Orden')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Foto', 'Orden', 'Orden', 14, 21, 4, 4, 4, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Foto' AND Propiedad = 'Activa')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Foto', 'Activa', 'Activa', 6, 20, 12, 6, 6, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Foto' AND Propiedad = 'IdCategoria')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Foto', 'IdCategoria', 'IdCategoria', 8, 19, 8, 8, 8, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Foto' AND Propiedad = 'Nombre')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Foto', 'Nombre', 'Nombre', 1, 17, 1, 1, 1, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Foto' AND Propiedad = 'Descripcion')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Foto', 'Descripcion', 'Descripcion', 1, 18, 3, 3, 3, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Foto' AND Propiedad = 'IdMarca')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Foto', 'IdMarca', 'IdMarca', 8, 1, 8, 8, 8, 1, 1);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Foto' AND Propiedad = 'Categoria')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario) VALUES ('CollectorsClub', @IdEntidad, 'Foto', 'Categoria', 'Categoria', 25, 19, 25, 25, 25, 0, 1, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Foto' AND Propiedad = 'Marca')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario) VALUES ('CollectorsClub', @IdEntidad, 'Foto', 'Marca', 'Marca', 25, 19, 25, 25, 25, 0, 1, 0);
end
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Foto' AND Propiedad = 'RegistrosIdiomas')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario, PermitirCrear, PermitirGuardar, PermitirBorrar, BusquedaAutomatica, IdModoInicio, HabilitarFiltro) VALUES ('CollectorsClub', @IdEntidad,'Foto', 'RegistrosIdiomas', 'RegistrosIdiomas', 25, 35, 29, 29, 29, 0, 0, 0, 1, 1, 1, 1, 1, 1);
end
------------------------------- Fin script del módulo Foto  ------------------------------

------------------------------- Inicio script del módulo Foto_Idioma  ------------------------------

set @IdEntidad  = (SELECT Id FROM Entidades WHERE Aplicacion = 'CollectorsClub' AND Nombre = 'Foto_Idioma')
if (@IdEntidad IS NULL)
begin
	INSERT INTO Entidades (Aplicacion, Nombre) VALUES ('CollectorsClub', 'Foto_Idioma')	
	set @IdEntidad = Scope_Identity()
end

 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Foto_Idioma' AND Propiedad = 'Id')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Foto_Idioma', 'Id', 'Id', 14, 21, 4, 4, 4, 1, 1);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Foto_Idioma' AND Propiedad = 'IdRegistro')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Foto_Idioma', 'IdRegistro', 'IdRegistro', 8, 19, 8, 8, 8, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Foto_Idioma' AND Propiedad = 'Cultura')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Foto_Idioma', 'Cultura', 'Cultura', 1, 17, 1, 1, 1, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Foto_Idioma' AND Propiedad = 'Nombre')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Foto_Idioma', 'Nombre', 'Nombre', 1, 18, 7, 7, 7, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Foto_Idioma' AND Propiedad = 'Descripcion')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Foto_Idioma', 'Descripcion', 'Descripcion', 1, 18, 3, 3, 3, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Foto_Idioma' AND Propiedad = 'Registro')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario) VALUES ('CollectorsClub', @IdEntidad, 'Foto_Idioma', 'Registro', 'Registro', 25, 19, 25, 25, 25, 0, 1, 0);
end
------------------------------- Fin script del módulo Foto_Idioma  ------------------------------

------------------------------- Inicio script del módulo Marca  ------------------------------

set @IdEntidad  = (SELECT Id FROM Entidades WHERE Aplicacion = 'CollectorsClub' AND Nombre = 'Marca')
if (@IdEntidad IS NULL)
begin
	INSERT INTO Entidades (Aplicacion, Nombre) VALUES ('CollectorsClub', 'Marca')	
	set @IdEntidad = Scope_Identity()
end

 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Marca' AND Propiedad = 'Id')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Marca', 'Id', 'Id', 1, 17, 1, 1, 1, 1, 1);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Marca' AND Propiedad = 'Nombre')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Marca', 'Nombre', 'Nombre', 1, 17, 1, 1, 1, 0, 0);
end
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Marca' AND Propiedad = 'Calendarios')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario, PermitirCrear, PermitirGuardar, PermitirBorrar, BusquedaAutomatica, IdModoInicio, HabilitarFiltro) VALUES ('CollectorsClub', @IdEntidad,'Marca', 'Calendarios', 'Calendarios', 25, 35, 29, 29, 29, 0, 0, 0, 1, 1, 1, 1, 1, 1);
end
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Marca' AND Propiedad = 'CategoriasFotos')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario, PermitirCrear, PermitirGuardar, PermitirBorrar, BusquedaAutomatica, IdModoInicio, HabilitarFiltro) VALUES ('CollectorsClub', @IdEntidad,'Marca', 'CategoriasFotos', 'CategoriasFotos', 25, 35, 29, 29, 29, 0, 0, 0, 1, 1, 1, 1, 1, 1);
end
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Marca' AND Propiedad = 'Entidades')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario, PermitirCrear, PermitirGuardar, PermitirBorrar, BusquedaAutomatica, IdModoInicio, HabilitarFiltro) VALUES ('CollectorsClub', @IdEntidad,'Marca', 'Entidades', 'Entidades', 25, 35, 29, 29, 29, 0, 0, 0, 1, 1, 1, 1, 1, 1);
end
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Marca' AND Propiedad = 'EstadosCalendario')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario, PermitirCrear, PermitirGuardar, PermitirBorrar, BusquedaAutomatica, IdModoInicio, HabilitarFiltro) VALUES ('CollectorsClub', @IdEntidad,'Marca', 'EstadosCalendario', 'EstadosCalendario', 25, 35, 29, 29, 29, 0, 0, 0, 1, 1, 1, 1, 1, 1);
end
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Marca' AND Propiedad = 'Fabricantes')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario, PermitirCrear, PermitirGuardar, PermitirBorrar, BusquedaAutomatica, IdModoInicio, HabilitarFiltro) VALUES ('CollectorsClub', @IdEntidad,'Marca', 'Fabricantes', 'Fabricantes', 25, 35, 29, 29, 29, 0, 0, 0, 1, 1, 1, 1, 1, 1);
end
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Marca' AND Propiedad = 'Fotos')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario, PermitirCrear, PermitirGuardar, PermitirBorrar, BusquedaAutomatica, IdModoInicio, HabilitarFiltro) VALUES ('CollectorsClub', @IdEntidad,'Marca', 'Fotos', 'Fotos', 25, 35, 29, 29, 29, 0, 0, 0, 1, 1, 1, 1, 1, 1);
end
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Marca' AND Propiedad = 'SolicitudesContacto')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario, PermitirCrear, PermitirGuardar, PermitirBorrar, BusquedaAutomatica, IdModoInicio, HabilitarFiltro) VALUES ('CollectorsClub', @IdEntidad,'Marca', 'SolicitudesContacto', 'SolicitudesContacto', 25, 35, 29, 29, 29, 0, 0, 0, 1, 1, 1, 1, 1, 1);
end
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Marca' AND Propiedad = 'SubcategoriasCalendario')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario, PermitirCrear, PermitirGuardar, PermitirBorrar, BusquedaAutomatica, IdModoInicio, HabilitarFiltro) VALUES ('CollectorsClub', @IdEntidad,'Marca', 'SubcategoriasCalendario', 'SubcategoriasCalendario', 25, 35, 29, 29, 29, 0, 0, 0, 1, 1, 1, 1, 1, 1);
end
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Marca' AND Propiedad = 'Usuarios')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario, PermitirCrear, PermitirGuardar, PermitirBorrar, BusquedaAutomatica, IdModoInicio, HabilitarFiltro) VALUES ('CollectorsClub', @IdEntidad,'Marca', 'Usuarios', 'Usuarios', 25, 35, 29, 29, 29, 0, 0, 0, 1, 1, 1, 1, 1, 1);
end
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Marca' AND Propiedad = 'Videos')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario, PermitirCrear, PermitirGuardar, PermitirBorrar, BusquedaAutomatica, IdModoInicio, HabilitarFiltro) VALUES ('CollectorsClub', @IdEntidad,'Marca', 'Videos', 'Videos', 25, 35, 29, 29, 29, 0, 0, 0, 1, 1, 1, 1, 1, 1);
end
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Marca' AND Propiedad = 'Eventos')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario, PermitirCrear, PermitirGuardar, PermitirBorrar, BusquedaAutomatica, IdModoInicio, HabilitarFiltro) VALUES ('CollectorsClub', @IdEntidad,'Marca', 'Eventos', 'Eventos', 25, 35, 29, 29, 29, 0, 0, 0, 1, 1, 1, 1, 1, 1);
end
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Marca' AND Propiedad = 'TiposEvento')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario, PermitirCrear, PermitirGuardar, PermitirBorrar, BusquedaAutomatica, IdModoInicio, HabilitarFiltro) VALUES ('CollectorsClub', @IdEntidad,'Marca', 'TiposEvento', 'TiposEvento', 25, 35, 29, 29, 29, 0, 0, 0, 1, 1, 1, 1, 1, 1);
end
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Marca' AND Propiedad = 'CategoriasCalendario')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario, PermitirCrear, PermitirGuardar, PermitirBorrar, BusquedaAutomatica, IdModoInicio, HabilitarFiltro) VALUES ('CollectorsClub', @IdEntidad,'Marca', 'CategoriasCalendario', 'CategoriasCalendario', 25, 35, 29, 29, 29, 0, 0, 0, 1, 1, 1, 1, 1, 1);
end
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Marca' AND Propiedad = 'TiposColeccionCalendario')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario, PermitirCrear, PermitirGuardar, PermitirBorrar, BusquedaAutomatica, IdModoInicio, HabilitarFiltro) VALUES ('CollectorsClub', @IdEntidad,'Marca', 'TiposColeccionCalendario', 'TiposColeccionCalendario', 25, 35, 29, 29, 29, 0, 0, 0, 1, 1, 1, 1, 1, 1);
end
------------------------------- Fin script del módulo Marca  ------------------------------

------------------------------- Inicio script del módulo SolicitudContacto  ------------------------------

set @IdEntidad  = (SELECT Id FROM Entidades WHERE Aplicacion = 'CollectorsClub' AND Nombre = 'SolicitudContacto')
if (@IdEntidad IS NULL)
begin
	INSERT INTO Entidades (Aplicacion, Nombre) VALUES ('CollectorsClub', 'SolicitudContacto')	
	set @IdEntidad = Scope_Identity()
end

 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'SolicitudContacto' AND Propiedad = 'Id')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'SolicitudContacto', 'Id', 'Id', 14, 21, 4, 4, 4, 1, 1);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'SolicitudContacto' AND Propiedad = 'Nombre')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'SolicitudContacto', 'Nombre', 'Nombre', 1, 17, 1, 1, 1, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'SolicitudContacto' AND Propiedad = 'CorreoElectronico')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'SolicitudContacto', 'CorreoElectronico', 'CorreoElectronico', 1, 17, 1, 1, 1, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'SolicitudContacto' AND Propiedad = 'Asunto')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'SolicitudContacto', 'Asunto', 'Asunto', 1, 17, 1, 1, 1, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'SolicitudContacto' AND Propiedad = 'Contenido')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'SolicitudContacto', 'Contenido', 'Contenido', 1, 18, 3, 3, 3, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'SolicitudContacto' AND Propiedad = 'FechaAlta')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'SolicitudContacto', 'FechaAlta', 'FechaAlta', 39, 40, 38, 38, 38, 1, 1);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'SolicitudContacto' AND Propiedad = 'FechaUltimaModificacion')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'SolicitudContacto', 'FechaUltimaModificacion', 'FechaUltimaModificacion', 39, 40, 38, 38, 38, 1, 1);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'SolicitudContacto' AND Propiedad = 'IdMarca')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'SolicitudContacto', 'IdMarca', 'IdMarca', 8, 1, 8, 8, 8, 1, 1);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'SolicitudContacto' AND Propiedad = 'Marca')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario) VALUES ('CollectorsClub', @IdEntidad, 'SolicitudContacto', 'Marca', 'Marca', 25, 19, 25, 25, 25, 0, 1, 0);
end
------------------------------- Fin script del módulo SolicitudContacto  ------------------------------

------------------------------- Inicio script del módulo SubcategoriaCalendario  ------------------------------

set @IdEntidad  = (SELECT Id FROM Entidades WHERE Aplicacion = 'CollectorsClub' AND Nombre = 'SubcategoriaCalendario')
if (@IdEntidad IS NULL)
begin
	INSERT INTO Entidades (Aplicacion, Nombre) VALUES ('CollectorsClub', 'SubcategoriaCalendario')	
	set @IdEntidad = Scope_Identity()
end

 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'SubcategoriaCalendario' AND Propiedad = 'Id')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'SubcategoriaCalendario', 'Id', 'Id', 14, 21, 4, 4, 4, 1, 1);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'SubcategoriaCalendario' AND Propiedad = 'Nombre')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'SubcategoriaCalendario', 'Nombre', 'Nombre', 1, 17, 1, 1, 1, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'SubcategoriaCalendario' AND Propiedad = 'Codigo')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'SubcategoriaCalendario', 'Codigo', 'Codigo', 1, 17, 1, 1, 1, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'SubcategoriaCalendario' AND Propiedad = 'IdMarca')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'SubcategoriaCalendario', 'IdMarca', 'IdMarca', 8, 1, 8, 8, 8, 1, 1);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'SubcategoriaCalendario' AND Propiedad = 'IdCategoria')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'SubcategoriaCalendario', 'IdCategoria', 'IdCategoria', 8, 19, 8, 8, 8, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'SubcategoriaCalendario' AND Propiedad = 'Marca')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario) VALUES ('CollectorsClub', @IdEntidad, 'SubcategoriaCalendario', 'Marca', 'Marca', 25, 19, 25, 25, 25, 0, 1, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'SubcategoriaCalendario' AND Propiedad = 'Categoria')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario) VALUES ('CollectorsClub', @IdEntidad, 'SubcategoriaCalendario', 'Categoria', 'Categoria', 25, 19, 25, 25, 25, 0, 1, 0);
end
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'SubcategoriaCalendario' AND Propiedad = 'Calendarios')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario, PermitirCrear, PermitirGuardar, PermitirBorrar, BusquedaAutomatica, IdModoInicio, HabilitarFiltro) VALUES ('CollectorsClub', @IdEntidad,'SubcategoriaCalendario', 'Calendarios', 'Calendarios', 25, 35, 29, 29, 29, 0, 0, 0, 1, 1, 1, 1, 1, 1);
end
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'SubcategoriaCalendario' AND Propiedad = 'RegistrosIdiomas')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario, PermitirCrear, PermitirGuardar, PermitirBorrar, BusquedaAutomatica, IdModoInicio, HabilitarFiltro) VALUES ('CollectorsClub', @IdEntidad,'SubcategoriaCalendario', 'RegistrosIdiomas', 'RegistrosIdiomas', 25, 35, 29, 29, 29, 0, 0, 0, 1, 1, 1, 1, 1, 1);
end
------------------------------- Fin script del módulo SubcategoriaCalendario  ------------------------------

------------------------------- Inicio script del módulo SubcategoriaCalendario_Idioma  ------------------------------

set @IdEntidad  = (SELECT Id FROM Entidades WHERE Aplicacion = 'CollectorsClub' AND Nombre = 'SubcategoriaCalendario_Idioma')
if (@IdEntidad IS NULL)
begin
	INSERT INTO Entidades (Aplicacion, Nombre) VALUES ('CollectorsClub', 'SubcategoriaCalendario_Idioma')	
	set @IdEntidad = Scope_Identity()
end

 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'SubcategoriaCalendario_Idioma' AND Propiedad = 'Id')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'SubcategoriaCalendario_Idioma', 'Id', 'Id', 14, 21, 4, 4, 4, 1, 1);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'SubcategoriaCalendario_Idioma' AND Propiedad = 'IdRegistro')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'SubcategoriaCalendario_Idioma', 'IdRegistro', 'IdRegistro', 8, 19, 8, 8, 8, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'SubcategoriaCalendario_Idioma' AND Propiedad = 'Cultura')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'SubcategoriaCalendario_Idioma', 'Cultura', 'Cultura', 1, 17, 1, 1, 1, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'SubcategoriaCalendario_Idioma' AND Propiedad = 'Nombre')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'SubcategoriaCalendario_Idioma', 'Nombre', 'Nombre', 1, 17, 1, 1, 1, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'SubcategoriaCalendario_Idioma' AND Propiedad = 'Registro')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario) VALUES ('CollectorsClub', @IdEntidad, 'SubcategoriaCalendario_Idioma', 'Registro', 'Registro', 25, 19, 25, 25, 25, 0, 1, 0);
end
------------------------------- Fin script del módulo SubcategoriaCalendario_Idioma  ------------------------------

------------------------------- Inicio script del módulo TipoColeccionCalendario  ------------------------------

set @IdEntidad  = (SELECT Id FROM Entidades WHERE Aplicacion = 'CollectorsClub' AND Nombre = 'TipoColeccionCalendario')
if (@IdEntidad IS NULL)
begin
	INSERT INTO Entidades (Aplicacion, Nombre) VALUES ('CollectorsClub', 'TipoColeccionCalendario')	
	set @IdEntidad = Scope_Identity()
end

 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'TipoColeccionCalendario' AND Propiedad = 'Id')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'TipoColeccionCalendario', 'Id', 'Id', 14, 21, 4, 4, 4, 1, 1);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'TipoColeccionCalendario' AND Propiedad = 'Nombre')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'TipoColeccionCalendario', 'Nombre', 'Nombre', 1, 17, 1, 1, 1, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'TipoColeccionCalendario' AND Propiedad = 'Codigo')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'TipoColeccionCalendario', 'Codigo', 'Codigo', 1, 17, 1, 1, 1, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'TipoColeccionCalendario' AND Propiedad = 'IdMarca')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'TipoColeccionCalendario', 'IdMarca', 'IdMarca', 8, 19, 8, 8, 8, 1, 1);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'TipoColeccionCalendario' AND Propiedad = 'Marca')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario) VALUES ('CollectorsClub', @IdEntidad, 'TipoColeccionCalendario', 'Marca', 'Marca', 25, 19, 25, 25, 25, 0, 1, 0);
end
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'TipoColeccionCalendario' AND Propiedad = 'Calendarios')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario, PermitirCrear, PermitirGuardar, PermitirBorrar, BusquedaAutomatica, IdModoInicio, HabilitarFiltro) VALUES ('CollectorsClub', @IdEntidad,'TipoColeccionCalendario', 'Calendarios', 'Calendarios', 25, 35, 29, 29, 29, 0, 0, 0, 1, 1, 1, 1, 1, 1);
end
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'TipoColeccionCalendario' AND Propiedad = 'RegistrosIdiomas')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario, PermitirCrear, PermitirGuardar, PermitirBorrar, BusquedaAutomatica, IdModoInicio, HabilitarFiltro) VALUES ('CollectorsClub', @IdEntidad,'TipoColeccionCalendario', 'RegistrosIdiomas', 'RegistrosIdiomas', 25, 35, 29, 29, 29, 0, 0, 0, 1, 1, 1, 1, 1, 1);
end
------------------------------- Fin script del módulo TipoColeccionCalendario  ------------------------------

------------------------------- Inicio script del módulo TipoColeccionCalendario_Idioma  ------------------------------

set @IdEntidad  = (SELECT Id FROM Entidades WHERE Aplicacion = 'CollectorsClub' AND Nombre = 'TipoColeccionCalendario_Idioma')
if (@IdEntidad IS NULL)
begin
	INSERT INTO Entidades (Aplicacion, Nombre) VALUES ('CollectorsClub', 'TipoColeccionCalendario_Idioma')	
	set @IdEntidad = Scope_Identity()
end

 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'TipoColeccionCalendario_Idioma' AND Propiedad = 'Id')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'TipoColeccionCalendario_Idioma', 'Id', 'Id', 14, 21, 4, 4, 4, 1, 1);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'TipoColeccionCalendario_Idioma' AND Propiedad = 'IdRegistro')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'TipoColeccionCalendario_Idioma', 'IdRegistro', 'IdRegistro', 8, 19, 8, 8, 8, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'TipoColeccionCalendario_Idioma' AND Propiedad = 'Cultura')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'TipoColeccionCalendario_Idioma', 'Cultura', 'Cultura', 1, 17, 1, 1, 1, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'TipoColeccionCalendario_Idioma' AND Propiedad = 'Nombre')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'TipoColeccionCalendario_Idioma', 'Nombre', 'Nombre', 1, 17, 1, 1, 1, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'TipoColeccionCalendario_Idioma' AND Propiedad = 'Registro')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario) VALUES ('CollectorsClub', @IdEntidad, 'TipoColeccionCalendario_Idioma', 'Registro', 'Registro', 25, 19, 25, 25, 25, 0, 1, 0);
end
------------------------------- Fin script del módulo TipoColeccionCalendario_Idioma  ------------------------------

------------------------------- Inicio script del módulo TipoEvento  ------------------------------

set @IdEntidad  = (SELECT Id FROM Entidades WHERE Aplicacion = 'CollectorsClub' AND Nombre = 'TipoEvento')
if (@IdEntidad IS NULL)
begin
	INSERT INTO Entidades (Aplicacion, Nombre) VALUES ('CollectorsClub', 'TipoEvento')	
	set @IdEntidad = Scope_Identity()
end

 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'TipoEvento' AND Propiedad = 'Id')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'TipoEvento', 'Id', 'Id', 14, 21, 4, 4, 4, 1, 1);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'TipoEvento' AND Propiedad = 'Nombre')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'TipoEvento', 'Nombre', 'Nombre', 1, 17, 1, 1, 1, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'TipoEvento' AND Propiedad = 'Codigo')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'TipoEvento', 'Codigo', 'Codigo', 1, 17, 1, 1, 1, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'TipoEvento' AND Propiedad = 'Orden')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'TipoEvento', 'Orden', 'Orden', 14, 21, 4, 4, 4, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'TipoEvento' AND Propiedad = 'IdMarca')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'TipoEvento', 'IdMarca', 'IdMarca', 8, 19, 8, 8, 8, 1, 1);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'TipoEvento' AND Propiedad = 'Marca')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario) VALUES ('CollectorsClub', @IdEntidad, 'TipoEvento', 'Marca', 'Marca', 25, 19, 25, 25, 25, 0, 1, 0);
end
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'TipoEvento' AND Propiedad = 'Eventos')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario, PermitirCrear, PermitirGuardar, PermitirBorrar, BusquedaAutomatica, IdModoInicio, HabilitarFiltro) VALUES ('CollectorsClub', @IdEntidad,'TipoEvento', 'Eventos', 'Eventos', 25, 35, 29, 29, 29, 0, 0, 0, 1, 1, 1, 1, 1, 1);
end
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'TipoEvento' AND Propiedad = 'RegistrosIdiomas')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario, PermitirCrear, PermitirGuardar, PermitirBorrar, BusquedaAutomatica, IdModoInicio, HabilitarFiltro) VALUES ('CollectorsClub', @IdEntidad,'TipoEvento', 'RegistrosIdiomas', 'RegistrosIdiomas', 25, 35, 29, 29, 29, 0, 0, 0, 1, 1, 1, 1, 1, 1);
end
------------------------------- Fin script del módulo TipoEvento  ------------------------------

------------------------------- Inicio script del módulo TipoEvento_Idioma  ------------------------------

set @IdEntidad  = (SELECT Id FROM Entidades WHERE Aplicacion = 'CollectorsClub' AND Nombre = 'TipoEvento_Idioma')
if (@IdEntidad IS NULL)
begin
	INSERT INTO Entidades (Aplicacion, Nombre) VALUES ('CollectorsClub', 'TipoEvento_Idioma')	
	set @IdEntidad = Scope_Identity()
end

 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'TipoEvento_Idioma' AND Propiedad = 'Id')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'TipoEvento_Idioma', 'Id', 'Id', 14, 21, 4, 4, 4, 1, 1);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'TipoEvento_Idioma' AND Propiedad = 'IdRegistro')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'TipoEvento_Idioma', 'IdRegistro', 'IdRegistro', 8, 19, 8, 8, 8, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'TipoEvento_Idioma' AND Propiedad = 'Cultura')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'TipoEvento_Idioma', 'Cultura', 'Cultura', 1, 17, 1, 1, 1, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'TipoEvento_Idioma' AND Propiedad = 'Nombre')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'TipoEvento_Idioma', 'Nombre', 'Nombre', 1, 17, 1, 1, 1, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'TipoEvento_Idioma' AND Propiedad = 'Registro')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario) VALUES ('CollectorsClub', @IdEntidad, 'TipoEvento_Idioma', 'Registro', 'Registro', 25, 19, 25, 25, 25, 0, 1, 0);
end
------------------------------- Fin script del módulo TipoEvento_Idioma  ------------------------------

------------------------------- Inicio script del módulo Usuario  ------------------------------

set @IdEntidad  = (SELECT Id FROM Entidades WHERE Aplicacion = 'CollectorsClub' AND Nombre = 'Usuario')
if (@IdEntidad IS NULL)
begin
	INSERT INTO Entidades (Aplicacion, Nombre) VALUES ('CollectorsClub', 'Usuario')	
	set @IdEntidad = Scope_Identity()
end

 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Usuario' AND Propiedad = 'Id')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Usuario', 'Id', 'Id', 14, 21, 4, 4, 4, 1, 1);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Usuario' AND Propiedad = 'Nombre')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Usuario', 'Nombre', 'Nombre', 1, 17, 1, 1, 1, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Usuario' AND Propiedad = 'PrimerApellido')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Usuario', 'PrimerApellido', 'PrimerApellido', 1, 17, 1, 1, 1, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Usuario' AND Propiedad = 'SegundoApellido')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Usuario', 'SegundoApellido', 'SegundoApellido', 1, 17, 1, 1, 1, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Usuario' AND Propiedad = 'NombreDeUsuario')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Usuario', 'NombreDeUsuario', 'NombreDeUsuario', 1, 17, 1, 1, 1, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Usuario' AND Propiedad = 'CorreoElectronico')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Usuario', 'CorreoElectronico', 'CorreoElectronico', 1, 17, 24, 24, 24, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Usuario' AND Propiedad = 'IdMarca')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Usuario', 'IdMarca', 'IdMarca', 8, 1, 8, 8, 8, 1, 1);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Usuario' AND Propiedad = 'Marca')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario) VALUES ('CollectorsClub', @IdEntidad, 'Usuario', 'Marca', 'Marca', 25, 19, 25, 25, 25, 0, 1, 0);
end
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Usuario' AND Propiedad = 'Calendarios')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario, PermitirCrear, PermitirGuardar, PermitirBorrar, BusquedaAutomatica, IdModoInicio, HabilitarFiltro) VALUES ('CollectorsClub', @IdEntidad,'Usuario', 'Calendarios', 'Calendarios', 25, 35, 29, 29, 29, 0, 0, 0, 1, 1, 1, 1, 1, 1);
end
------------------------------- Fin script del módulo Usuario  ------------------------------

------------------------------- Inicio script del módulo Video  ------------------------------

set @IdEntidad  = (SELECT Id FROM Entidades WHERE Aplicacion = 'CollectorsClub' AND Nombre = 'Video')
if (@IdEntidad IS NULL)
begin
	INSERT INTO Entidades (Aplicacion, Nombre) VALUES ('CollectorsClub', 'Video')	
	set @IdEntidad = Scope_Identity()
end

 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Video' AND Propiedad = 'Id')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Video', 'Id', 'Id', 14, 21, 4, 4, 4, 1, 1);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Video' AND Propiedad = 'FechaAlta')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Video', 'FechaAlta', 'FechaAlta', 39, 40, 38, 38, 38, 1, 1);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Video' AND Propiedad = 'FechaUltimaModificacion')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Video', 'FechaUltimaModificacion', 'FechaUltimaModificacion', 39, 40, 38, 38, 38, 1, 1);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Video' AND Propiedad = 'Nombre')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Video', 'Nombre', 'Nombre', 1, 17, 1, 1, 1, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Video' AND Propiedad = 'Descripcion')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Video', 'Descripcion', 'Descripcion', 1, 18, 3, 3, 3, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Video' AND Propiedad = 'Url')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Video', 'Url', 'Url', 1, 17, 46, 46, 46, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Video' AND Propiedad = 'IdMarca')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Video', 'IdMarca', 'IdMarca', 8, 1, 8, 8, 8, 1, 1);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Video' AND Propiedad = 'Marca')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario) VALUES ('CollectorsClub', @IdEntidad, 'Video', 'Marca', 'Marca', 25, 19, 25, 25, 25, 0, 1, 0);
end
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Video' AND Propiedad = 'RegistrosIdiomas')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario, PermitirCrear, PermitirGuardar, PermitirBorrar, BusquedaAutomatica, IdModoInicio, HabilitarFiltro) VALUES ('CollectorsClub', @IdEntidad,'Video', 'RegistrosIdiomas', 'RegistrosIdiomas', 25, 35, 29, 29, 29, 0, 0, 0, 1, 1, 1, 1, 1, 1);
end
------------------------------- Fin script del módulo Video  ------------------------------

------------------------------- Inicio script del módulo Video_Idioma  ------------------------------

set @IdEntidad  = (SELECT Id FROM Entidades WHERE Aplicacion = 'CollectorsClub' AND Nombre = 'Video_Idioma')
if (@IdEntidad IS NULL)
begin
	INSERT INTO Entidades (Aplicacion, Nombre) VALUES ('CollectorsClub', 'Video_Idioma')	
	set @IdEntidad = Scope_Identity()
end

 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Video_Idioma' AND Propiedad = 'Id')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Video_Idioma', 'Id', 'Id', 14, 21, 4, 4, 4, 1, 1);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Video_Idioma' AND Propiedad = 'IdRegistro')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Video_Idioma', 'IdRegistro', 'IdRegistro', 8, 19, 8, 8, 8, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Video_Idioma' AND Propiedad = 'Cultura')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Video_Idioma', 'Cultura', 'Cultura', 1, 17, 1, 1, 1, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Video_Idioma' AND Propiedad = 'Nombre')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Video_Idioma', 'Nombre', 'Nombre', 1, 17, 1, 1, 1, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Video_Idioma' AND Propiedad = 'Descripcion')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Video_Idioma', 'Descripcion', 'Descripcion', 1, 18, 3, 3, 3, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Video_Idioma' AND Propiedad = 'Url')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, SoloLecturaInsercion, SoloLecturaEdicion) VALUES ('CollectorsClub', @IdEntidad, 'Video_Idioma', 'Url', 'Url', 1, 17, 46, 46, 46, 0, 0);
end
 
if not exists (SELECT * FROM Propiedades WHERE Aplicacion = 'CollectorsClub' AND IdEntidad = @IdEntidad AND EntidadAnt = 'Video_Idioma' AND Propiedad = 'Registro')
begin
	INSERT INTO Propiedades (Aplicacion, IdEntidad, EntidadAnt, Propiedad, Literal, IdTipoCampoFiltro, IdTipoCampoListado, IdTipoCampoFormulario, IdTipoCampoFormularioCopia, IdTipoCampoFormularioEdicionMultiple, VisibleEnFiltro, VisibleEnListado, VisibleEnFormulario) VALUES ('CollectorsClub', @IdEntidad, 'Video_Idioma', 'Registro', 'Registro', 25, 19, 25, 25, 25, 0, 1, 0);
end
------------------------------- Fin script del módulo Video_Idioma  ------------------------------

