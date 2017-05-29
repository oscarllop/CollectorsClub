
USE CollectorsClub;
GO

ALTER PROCEDURE [dbo].[Calendario_ObtenerPorFiltros](@RegistroInicial int = NULL, @RegistroFinal int = NULL, @ColumnaOrden nvarchar(50) = 'Id', @TipoOrden smallint = 1, @IdDesde as int, @IdHasta as int, @IdTipoColeccion as smallint, @Visible as bit, @IdCategoria as smallint, @IdSubcategoria as smallint, @Imagen as nvarchar(250), @Nombre as nvarchar(50), @IdEstado as smallint, @Anyo as varchar(50), @IdEntidad as int, @Serie as nvarchar(50), @NumeroRepetidosDesde as smallint, @NumeroRepetidosHasta as smallint, @NumeroSerie as nvarchar(50), @IdEntidadContratante as int, @DL as nvarchar(50), @Variante as nvarchar(50), @IdFabricante as int, @PaginaWeb as nvarchar(100), @Codigo as varchar(50), @IdUsuario as int, @Cultura as varchar(5), @IdMarca as char(3)) AS
BEGIN
	--declare @RegistroInicial int = 1
	--declare @RegistroFinal int = 50
	--declare @ColumnaOrden nvarchar(50) = 'Id'
	--declare @TipoOrden smallint = 0
	--declare @IdDesde as int, @IdHasta as int = null
	--declare @IdTipoColeccion as smallint = null
	--declare @Visible as bit = null
	--declare @IdCategoria as smallint = null
	--declare @IdSubcategoria as smallint = null
	--declare @Imagen as nvarchar(250) = null
	--declare @Nombre as nvarchar(50) = null
	--declare @IdEstado as smallint = null
	--declare @Anyo as varchar(50) = null
	--declare @IdEntidad as int = null
	--declare @Serie as nvarchar(50) = null
	--declare @NumeroRepetidosDesde as smallint, @NumeroRepetidosHasta as smallint = null
	--declare @NumeroSerie as nvarchar(50) = null
	--declare @IdEntidadContratante as int = null
	--declare @DL as nvarchar(50) = null
	--declare @Variante as nvarchar(50) = null
	--declare @IdFabricante as int = null
	--declare @PaginaWeb as nvarchar(100) = null
	--declare @Codigo as varchar(50) = null
	--declare @IdUsuario as int = null
	--declare @Cultura as varchar(5) = null
	--declare @IdMarca as char(3) = null

	;WITH DATOS AS (
		SELECT ROW_NUMBER() OVER ( 
			ORDER BY
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Id' THEN Calendarios.Id END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Id' THEN Calendarios.Id END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Nombre' THEN Calendarios.Nombre END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Nombre' THEN Calendarios.Nombre END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'IdTipoColeccion' THEN Calendarios.IdTipoColeccion END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'IdTipoColeccion' THEN Calendarios.IdTipoColeccion END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'IdCategoria' THEN Calendarios.IdCategoria END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'IdCategoria' THEN Calendarios.IdCategoria END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'IdSubcategoria' THEN Calendarios.IdSubcategoria END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'IdSubcategoria' THEN Calendarios.IdSubcategoria END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Codigo' THEN Calendarios.Codigo END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Codigo' THEN Calendarios.Codigo END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Anyo' THEN Calendarios.Anyo END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Anyo' THEN Calendarios.Anyo END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Serie' THEN Calendarios.Serie END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Serie' THEN Calendarios.Serie END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'IdEntidad' THEN Calendarios.IdEntidad END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'IdEntidad' THEN Calendarios.IdEntidad END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'NumeroRepetidos' THEN Calendarios.NumeroRepetidos END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'NumeroRepetidos' THEN Calendarios.NumeroRepetidos END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'NumeroSerie' THEN Calendarios.NumeroSerie END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'NumeroSerie' THEN Calendarios.NumeroSerie END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'IdEstado' THEN Calendarios.IdEstado END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'IdEstado' THEN Calendarios.IdEstado END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'DL' THEN Calendarios.DL END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'DL' THEN Calendarios.DL END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'IdEntidadContratante' THEN Calendarios.IdEntidadContratante END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'IdEntidadContratante' THEN Calendarios.IdEntidadContratante END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Variante' THEN Calendarios.Variante END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Variante' THEN Calendarios.Variante END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'IdFabricante' THEN Calendarios.IdFabricante END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'IdFabricante' THEN Calendarios.IdFabricante END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'PaginaWeb' THEN Calendarios.PaginaWeb END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'PaginaWeb' THEN Calendarios.PaginaWeb END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'IdUsuario' THEN Calendarios.IdUsuario END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'IdUsuario' THEN Calendarios.IdUsuario END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Imagen' THEN Calendarios.Imagen END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Imagen' THEN Calendarios.Imagen END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'ImagenEnBinario' THEN Calendarios.ImagenEnBinario END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'ImagenEnBinario' THEN Calendarios.ImagenEnBinario END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Visible' THEN Calendarios.Visible END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Visible' THEN Calendarios.Visible END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'IdMarca' THEN Calendarios.IdMarca END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'IdMarca' THEN Calendarios.IdMarca END DESC
			) AS NumeroRegistro,
			Calendarios.Id AS Id, Calendarios.Nombre AS Nombre, Calendarios.IdTipoColeccion AS IdTipoColeccion, TiposColeccionCalendario_TipoColeccionCalendario.Nombre AS TipoColeccionCalendario, Calendarios.IdCategoria AS IdCategoria, CategoriasCalendario_Categoria.Nombre AS Categoria, Calendarios.IdSubcategoria AS IdSubcategoria, SubcategoriasCalendario_Subcategoria.Nombre AS Subcategoria, Calendarios.Codigo AS Codigo, Calendarios.Anyo AS Anyo, Calendarios.Serie AS Serie, Calendarios.IdEntidad AS IdEntidad, Entidades_Entidad.Nombre AS Entidad, Calendarios.NumeroRepetidos AS NumeroRepetidos, Calendarios.NumeroSerie AS NumeroSerie, Calendarios.IdEstado AS IdEstado, EstadosCalendario_Estado.Nombre AS Estado, Calendarios.DL AS DL, Calendarios.IdEntidadContratante AS IdEntidadContratante, Entidades_EntidadContratante.Nombre AS EntidadContratante, Calendarios.Variante AS Variante, Calendarios.IdFabricante AS IdFabricante, Fabricantes_Fabricante.Nombre AS Fabricante, Calendarios.PaginaWeb AS PaginaWeb, Calendarios.IdUsuario AS IdUsuario, Usuarios_Usuario.Nombre AS Usuario, Calendarios.Imagen AS Imagen, Calendarios.ImagenEnBinario AS ImagenEnBinario, Calendarios.Visible AS Visible, Calendarios.IdMarca AS IdMarca, Marcas_Marca.Nombre AS Marca
		FROM Calendarios
			INNER JOIN Entidades AS Entidades_Entidad ON Entidades_Entidad.Id = Calendarios.IdEntidad
			INNER JOIN TiposColeccionCalendario AS TiposColeccionCalendario_TipoColeccionCalendario ON TiposColeccionCalendario_TipoColeccionCalendario.Id = Calendarios.IdTipoColeccion
			INNER JOIN CategoriasCalendario AS CategoriasCalendario_Categoria ON CategoriasCalendario_Categoria.Id = Calendarios.IdCategoria
			INNER JOIN SubcategoriasCalendario AS SubcategoriasCalendario_Subcategoria ON SubcategoriasCalendario_Subcategoria.Id = Calendarios.IdSubcategoria
			INNER JOIN Usuarios AS Usuarios_Usuario ON Usuarios_Usuario.Id = Calendarios.IdUsuario
			INNER JOIN Marcas AS Marcas_Marca ON Marcas_Marca.Id = Calendarios.IdMarca
			LEFT OUTER JOIN Entidades AS Entidades_EntidadContratante ON Entidades_EntidadContratante.Id = Calendarios.IdEntidadContratante
			LEFT OUTER JOIN EstadosCalendario AS EstadosCalendario_Estado ON EstadosCalendario_Estado.Id = Calendarios.IdEstado
			LEFT OUTER JOIN Fabricantes AS Fabricantes_Fabricante ON Fabricantes_Fabricante.Id = Calendarios.IdFabricante
		WHERE (@IdDesde IS NULL OR @IdHasta IS NULL OR (Calendarios.Id >= @IdDesde AND Calendarios.Id < DateAdd(d, 1, @IdHasta)))
		AND (@IdTipoColeccion IS NULL OR Calendarios.IdTipoColeccion = @IdTipoColeccion)
		AND (@Visible IS NULL OR Calendarios.Visible = @Visible)
		AND (@IdCategoria IS NULL OR Calendarios.IdCategoria = @IdCategoria)
		AND (@IdSubcategoria IS NULL OR Calendarios.IdSubcategoria = @IdSubcategoria)
		AND (@Imagen IS NULL OR Calendarios.Imagen LIKE '%' + @Imagen + '%')
		AND (@Nombre IS NULL OR Calendarios.Nombre LIKE '%' + @Nombre + '%')
		AND (@IdEstado IS NULL OR Calendarios.IdEstado = @IdEstado)
		AND (@Anyo IS NULL OR Calendarios.Anyo LIKE '%' + @Anyo + '%')
		AND (@IdEntidad IS NULL OR Calendarios.IdEntidad = @IdEntidad)
		AND (@Serie IS NULL OR Calendarios.Serie LIKE '%' + @Serie + '%')
		AND (@NumeroRepetidosDesde IS NULL OR @NumeroRepetidosHasta IS NULL OR (Calendarios.NumeroRepetidos >= @NumeroRepetidosDesde AND Calendarios.NumeroRepetidos < DateAdd(d, 1, @NumeroRepetidosHasta)))
		AND (@NumeroSerie IS NULL OR Calendarios.NumeroSerie LIKE '%' + @NumeroSerie + '%')
		AND (@IdEntidadContratante IS NULL OR Calendarios.IdEntidadContratante = @IdEntidadContratante)
		AND (@DL IS NULL OR Calendarios.DL LIKE '%' + @DL + '%')
		AND (@Variante IS NULL OR Calendarios.Variante LIKE '%' + @Variante + '%')
		AND (@IdFabricante IS NULL OR Calendarios.IdFabricante = @IdFabricante)
		AND (@PaginaWeb IS NULL OR Calendarios.PaginaWeb LIKE '%' + @PaginaWeb + '%')
		AND (@Codigo IS NULL OR Calendarios.Codigo LIKE '%' + @Codigo + '%')
		AND (@IdUsuario IS NULL OR Calendarios.IdUsuario = @IdUsuario)
		AND (@IdMarca IS NULL OR Calendarios.IdMarca = @IdMarca)

	)
	SELECT Id, Nombre, IdTipoColeccion, TipoColeccionCalendario, IdCategoria, Categoria, IdSubcategoria, Subcategoria, Codigo, Anyo, Serie, IdEntidad, Entidad, NumeroRepetidos, NumeroSerie, IdEstado, Estado, DL, IdEntidadContratante, EntidadContratante, Variante, IdFabricante, Fabricante, PaginaWeb, IdUsuario, Usuario, Imagen, ImagenEnBinario, Visible, IdMarca, Marca
	FROM DATOS
	WHERE (@RegistroInicial IS NULL AND @RegistroFinal IS NULL OR (NumeroRegistro >= @RegistroInicial AND NumeroRegistro <= @RegistroFinal)) 
END
GO

ALTER PROCEDURE [dbo].[Calendario_ObtenerCantidadPorFiltros](@IdDesde as int, @IdHasta as int, @IdTipoColeccion as smallint, @Visible as bit, @IdCategoria as smallint, @IdSubcategoria as smallint, @Imagen as nvarchar(250), @Nombre as nvarchar(50), @IdEstado as smallint, @Anyo as varchar(50), @IdEntidad as int, @Serie as nvarchar(50), @NumeroRepetidosDesde as smallint, @NumeroRepetidosHasta as smallint, @NumeroSerie as nvarchar(50), @IdEntidadContratante as int, @DL as nvarchar(50), @Variante as nvarchar(50), @IdFabricante as int, @PaginaWeb as nvarchar(100), @Codigo as varchar(50), @IdUsuario as int, @Cultura as varchar(5), @IdMarca as char(3)) AS
BEGIN
	--declare @IdDesde as int, @IdHasta as int = null
	--declare @IdTipoColeccion as smallint = null
	--declare @Visible as bit = null
	--declare @IdCategoria as smallint = null
	--declare @IdSubcategoria as smallint = null
	--declare @Imagen as nvarchar(250) = null
	--declare @Nombre as nvarchar(50) = null
	--declare @IdEstado as smallint = null
	--declare @Anyo as varchar(50) = null
	--declare @IdEntidad as int = null
	--declare @Serie as nvarchar(50) = null
	--declare @NumeroRepetidosDesde as smallint, @NumeroRepetidosHasta as smallint = null
	--declare @NumeroSerie as nvarchar(50) = null
	--declare @IdEntidadContratante as int = null
	--declare @DL as nvarchar(50) = null
	--declare @Variante as nvarchar(50) = null
	--declare @IdFabricante as int = null
	--declare @PaginaWeb as nvarchar(100) = null
	--declare @Codigo as varchar(50) = null
	--declare @IdUsuario as int = null
	--declare @Cultura as varchar(5) = null
	--declare @IdMarca as char(3) = null

	SELECT COUNT(*)
	FROM Calendarios
	WHERE (@IdDesde IS NULL OR @IdHasta IS NULL OR (Calendarios.Id >= @IdDesde AND Calendarios.Id < DateAdd(d, 1, @IdHasta)))
		AND (@IdTipoColeccion IS NULL OR Calendarios.IdTipoColeccion = @IdTipoColeccion)
		AND (@Visible IS NULL OR Calendarios.Visible = @Visible)
		AND (@IdCategoria IS NULL OR Calendarios.IdCategoria = @IdCategoria)
		AND (@IdSubcategoria IS NULL OR Calendarios.IdSubcategoria = @IdSubcategoria)
		AND (@Imagen IS NULL OR Calendarios.Imagen LIKE '%' + @Imagen + '%')
		AND (@Nombre IS NULL OR Calendarios.Nombre LIKE '%' + @Nombre + '%')
		AND (@IdEstado IS NULL OR Calendarios.IdEstado = @IdEstado)
		AND (@Anyo IS NULL OR Calendarios.Anyo LIKE '%' + @Anyo + '%')
		AND (@IdEntidad IS NULL OR Calendarios.IdEntidad = @IdEntidad)
		AND (@Serie IS NULL OR Calendarios.Serie LIKE '%' + @Serie + '%')
		AND (@NumeroRepetidosDesde IS NULL OR @NumeroRepetidosHasta IS NULL OR (Calendarios.NumeroRepetidos >= @NumeroRepetidosDesde AND Calendarios.NumeroRepetidos < DateAdd(d, 1, @NumeroRepetidosHasta)))
		AND (@NumeroSerie IS NULL OR Calendarios.NumeroSerie LIKE '%' + @NumeroSerie + '%')
		AND (@IdEntidadContratante IS NULL OR Calendarios.IdEntidadContratante = @IdEntidadContratante)
		AND (@DL IS NULL OR Calendarios.DL LIKE '%' + @DL + '%')
		AND (@Variante IS NULL OR Calendarios.Variante LIKE '%' + @Variante + '%')
		AND (@IdFabricante IS NULL OR Calendarios.IdFabricante = @IdFabricante)
		AND (@PaginaWeb IS NULL OR Calendarios.PaginaWeb LIKE '%' + @PaginaWeb + '%')
		AND (@Codigo IS NULL OR Calendarios.Codigo LIKE '%' + @Codigo + '%')
		AND (@IdUsuario IS NULL OR Calendarios.IdUsuario = @IdUsuario)
		AND (@IdMarca IS NULL OR Calendarios.IdMarca = @IdMarca)

END
GO

ALTER PROCEDURE [dbo].[Calendario_ObtenerComboPorIdMarca](@IdMarca as char(3), @Cultura as varchar(5)) AS
BEGIN
	--declare @IdMarca as char(3) = 'CCB'
		--declare @Cultura as varchar(5) = 'es-ES'
	
	SELECT Calendarios.Id AS Id, COALESCE(Calendarios_idiomas.Nombre, Calendarios.Nombre) AS Nombre
	FROM Calendarios
		LEFT OUTER JOIN Calendarios_Idiomas ON Calendarios_Idiomas.IdRegistro = Calendarios.Id AND Calendarios_Idiomas.Cultura = @Cultura
	WHERE Calendarios.IdMarca = @IdMarca
	ORDER BY Nombre
END
GO


ALTER PROCEDURE [dbo].[Calendario_ObtenerLista](@Lista as varchar(500)) AS
BEGIN
	--declare @Lista as varchar(500) = '1,2'

	SELECT Calendarios.Id AS Id, Calendarios.Nombre AS Nombre, Calendarios.IdTipoColeccion AS IdTipoColeccion, TiposColeccionCalendario_TipoColeccionCalendario.Nombre AS TipoColeccionCalendario, Calendarios.IdCategoria AS IdCategoria, CategoriasCalendario_Categoria.Nombre AS Categoria, Calendarios.IdSubcategoria AS IdSubcategoria, SubcategoriasCalendario_Subcategoria.Nombre AS Subcategoria, Calendarios.Codigo AS Codigo, Calendarios.Anyo AS Anyo, Calendarios.Serie AS Serie, Calendarios.IdEntidad AS IdEntidad, Entidades_Entidad.Nombre AS Entidad, Calendarios.NumeroRepetidos AS NumeroRepetidos, Calendarios.NumeroSerie AS NumeroSerie, Calendarios.IdEstado AS IdEstado, EstadosCalendario_Estado.Nombre AS Estado, Calendarios.DL AS DL, Calendarios.IdEntidadContratante AS IdEntidadContratante, Entidades_EntidadContratante.Nombre AS EntidadContratante, Calendarios.Variante AS Variante, Calendarios.IdFabricante AS IdFabricante, Fabricantes_Fabricante.Nombre AS Fabricante, Calendarios.PaginaWeb AS PaginaWeb, Calendarios.IdUsuario AS IdUsuario, Usuarios_Usuario.Nombre AS Usuario, Calendarios.Imagen AS Imagen, Calendarios.ImagenEnBinario AS ImagenEnBinario, Calendarios.Visible AS Visible, Calendarios.IdMarca AS IdMarca, Marcas_Marca.Nombre AS Marca
	FROM Calendarios
		INNER JOIN dbo.fnArrayATabla(@Lista, ',') l ON l.number = Calendarios.Id
			INNER JOIN Entidades AS Entidades_Entidad ON Entidades_Entidad.Id = Calendarios.IdEntidad
			INNER JOIN TiposColeccionCalendario AS TiposColeccionCalendario_TipoColeccionCalendario ON TiposColeccionCalendario_TipoColeccionCalendario.Id = Calendarios.IdTipoColeccion
			INNER JOIN CategoriasCalendario AS CategoriasCalendario_Categoria ON CategoriasCalendario_Categoria.Id = Calendarios.IdCategoria
			INNER JOIN SubcategoriasCalendario AS SubcategoriasCalendario_Subcategoria ON SubcategoriasCalendario_Subcategoria.Id = Calendarios.IdSubcategoria
			INNER JOIN Usuarios AS Usuarios_Usuario ON Usuarios_Usuario.Id = Calendarios.IdUsuario
			INNER JOIN Marcas AS Marcas_Marca ON Marcas_Marca.Id = Calendarios.IdMarca
			LEFT OUTER JOIN Entidades AS Entidades_EntidadContratante ON Entidades_EntidadContratante.Id = Calendarios.IdEntidadContratante
			LEFT OUTER JOIN EstadosCalendario AS EstadosCalendario_Estado ON EstadosCalendario_Estado.Id = Calendarios.IdEstado
			LEFT OUTER JOIN Fabricantes AS Fabricantes_Fabricante ON Fabricantes_Fabricante.Id = Calendarios.IdFabricante
END
GO

ALTER PROCEDURE [dbo].[Calendario_Idioma_ObtenerPorFiltros](@RegistroInicial int = NULL, @RegistroFinal int = NULL, @ColumnaOrden nvarchar(50) = 'Id', @TipoOrden smallint = 1, @IdDesde as int, @IdHasta as int, @IdRegistro as int, @Cultura as varchar(5), @Nombre as nvarchar(50), @Variante as nvarchar(50)) AS
BEGIN
	--declare @RegistroInicial int = 1
	--declare @RegistroFinal int = 50
	--declare @ColumnaOrden nvarchar(50) = 'Id'
	--declare @TipoOrden smallint = 0
	--declare @IdDesde as int, @IdHasta as int = null
	--declare @IdRegistro as int = null
	--declare @Cultura as varchar(5) = null
	--declare @Nombre as nvarchar(50) = null
	--declare @Variante as nvarchar(50) = null

	;WITH DATOS AS (
		SELECT ROW_NUMBER() OVER ( 
			ORDER BY
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Id' THEN Calendarios_Idiomas.Id END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Id' THEN Calendarios_Idiomas.Id END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'IdRegistro' THEN Calendarios_Idiomas.IdRegistro END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'IdRegistro' THEN Calendarios_Idiomas.IdRegistro END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Cultura' THEN Calendarios_Idiomas.Cultura END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Cultura' THEN Calendarios_Idiomas.Cultura END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Nombre' THEN Calendarios_Idiomas.Nombre END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Nombre' THEN Calendarios_Idiomas.Nombre END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Variante' THEN Calendarios_Idiomas.Variante END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Variante' THEN Calendarios_Idiomas.Variante END DESC
			) AS NumeroRegistro,
			Calendarios_Idiomas.Id AS Id, Calendarios_Idiomas.IdRegistro AS IdRegistro, Calendarios_Registro.Nombre AS Registro, Calendarios_Idiomas.Cultura AS Cultura, Calendarios_Idiomas.Nombre AS Nombre, Calendarios_Idiomas.Variante AS Variante
		FROM Calendarios_Idiomas
			INNER JOIN Calendarios AS Calendarios_Registro ON Calendarios_Registro.Id = Calendarios_Idiomas.IdRegistro
		WHERE (@IdDesde IS NULL OR @IdHasta IS NULL OR (Calendarios_Idiomas.Id >= @IdDesde AND Calendarios_Idiomas.Id < DateAdd(d, 1, @IdHasta)))
		AND (@IdRegistro IS NULL OR Calendarios_Idiomas.IdRegistro = @IdRegistro)
		AND (@Cultura IS NULL OR Calendarios_Idiomas.Cultura = @Cultura)
		AND (@Nombre IS NULL OR Calendarios_Idiomas.Nombre LIKE '%' + @Nombre + '%')
		AND (@Variante IS NULL OR Calendarios_Idiomas.Variante LIKE '%' + @Variante + '%')

	)
	SELECT Id, IdRegistro, Registro, Cultura, Nombre, Variante
	FROM DATOS
	WHERE (@RegistroInicial IS NULL AND @RegistroFinal IS NULL OR (NumeroRegistro >= @RegistroInicial AND NumeroRegistro <= @RegistroFinal)) 
END
GO

ALTER PROCEDURE [dbo].[Calendario_Idioma_ObtenerCantidadPorFiltros](@IdDesde as int, @IdHasta as int, @IdRegistro as int, @Cultura as varchar(5), @Nombre as nvarchar(50), @Variante as nvarchar(50)) AS
BEGIN
	--declare @IdDesde as int, @IdHasta as int = null
	--declare @IdRegistro as int = null
	--declare @Cultura as varchar(5) = null
	--declare @Nombre as nvarchar(50) = null
	--declare @Variante as nvarchar(50) = null

	SELECT COUNT(*)
	FROM Calendarios_Idiomas
	WHERE (@IdDesde IS NULL OR @IdHasta IS NULL OR (Calendarios_Idiomas.Id >= @IdDesde AND Calendarios_Idiomas.Id < DateAdd(d, 1, @IdHasta)))
		AND (@IdRegistro IS NULL OR Calendarios_Idiomas.IdRegistro = @IdRegistro)
		AND (@Cultura IS NULL OR Calendarios_Idiomas.Cultura = @Cultura)
		AND (@Nombre IS NULL OR Calendarios_Idiomas.Nombre LIKE '%' + @Nombre + '%')
		AND (@Variante IS NULL OR Calendarios_Idiomas.Variante LIKE '%' + @Variante + '%')

END
GO

ALTER PROCEDURE [dbo].[Calendario_Idioma_ObtenerCombo] AS
BEGIN
	SELECT Calendarios_Idiomas.Id AS Id, Calendarios_Idiomas.Nombre AS Nombre
	FROM Calendarios_Idiomas
	ORDER BY Nombre
END
GO


ALTER PROCEDURE [dbo].[Calendario_Idioma_ObtenerLista](@Lista as varchar(500)) AS
BEGIN
	--declare @Lista as varchar(500) = '1,2'

	SELECT Calendarios_Idiomas.Id AS Id, Calendarios_Idiomas.IdRegistro AS IdRegistro, Calendarios_Registro.Nombre AS Registro, Calendarios_Idiomas.Cultura AS Cultura, Calendarios_Idiomas.Nombre AS Nombre, Calendarios_Idiomas.Variante AS Variante
	FROM Calendarios_Idiomas
		INNER JOIN dbo.fnArrayATabla(@Lista, ',') l ON l.number = Calendarios_Idiomas.Id
			INNER JOIN Calendarios AS Calendarios_Registro ON Calendarios_Registro.Id = Calendarios_Idiomas.IdRegistro
END
GO

ALTER PROCEDURE [dbo].[CategoriaCalendario_ObtenerPorFiltros](@RegistroInicial int = NULL, @RegistroFinal int = NULL, @ColumnaOrden nvarchar(50) = 'Id', @TipoOrden smallint = 1, @IdDesde as smallint, @IdHasta as smallint, @Nombre as nvarchar(50), @Codigo as varchar(50), @Cultura as varchar(5), @IdMarca as char(3)) AS
BEGIN
	--declare @RegistroInicial int = 1
	--declare @RegistroFinal int = 50
	--declare @ColumnaOrden nvarchar(50) = 'Id'
	--declare @TipoOrden smallint = 0
	--declare @IdDesde as smallint, @IdHasta as smallint = null
	--declare @Nombre as nvarchar(50) = null
	--declare @Codigo as varchar(50) = null
	--declare @Cultura as varchar(5) = null
	--declare @IdMarca as char(3) = null

	;WITH DATOS AS (
		SELECT ROW_NUMBER() OVER ( 
			ORDER BY
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Id' THEN CategoriasCalendario.Id END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Id' THEN CategoriasCalendario.Id END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Nombre' THEN CategoriasCalendario.Nombre END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Nombre' THEN CategoriasCalendario.Nombre END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Codigo' THEN CategoriasCalendario.Codigo END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Codigo' THEN CategoriasCalendario.Codigo END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'IdMarca' THEN CategoriasCalendario.IdMarca END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'IdMarca' THEN CategoriasCalendario.IdMarca END DESC
			) AS NumeroRegistro,
			CategoriasCalendario.Id AS Id, CategoriasCalendario.Nombre AS Nombre, CategoriasCalendario.Codigo AS Codigo, CategoriasCalendario.IdMarca AS IdMarca, Marcas_Marca.Nombre AS Marca
		FROM CategoriasCalendario
			INNER JOIN Marcas AS Marcas_Marca ON Marcas_Marca.Id = CategoriasCalendario.IdMarca
		WHERE (@IdDesde IS NULL OR @IdHasta IS NULL OR (CategoriasCalendario.Id >= @IdDesde AND CategoriasCalendario.Id < DateAdd(d, 1, @IdHasta)))
		AND (@Nombre IS NULL OR CategoriasCalendario.Nombre LIKE '%' + @Nombre + '%')
		AND (@Codigo IS NULL OR CategoriasCalendario.Codigo LIKE '%' + @Codigo + '%')
		AND (@IdMarca IS NULL OR CategoriasCalendario.IdMarca = @IdMarca)

	)
	SELECT Id, Nombre, Codigo, IdMarca, Marca
	FROM DATOS
	WHERE (@RegistroInicial IS NULL AND @RegistroFinal IS NULL OR (NumeroRegistro >= @RegistroInicial AND NumeroRegistro <= @RegistroFinal)) 
END
GO

ALTER PROCEDURE [dbo].[CategoriaCalendario_ObtenerCantidadPorFiltros](@IdDesde as smallint, @IdHasta as smallint, @Nombre as nvarchar(50), @Codigo as varchar(50), @Cultura as varchar(5), @IdMarca as char(3)) AS
BEGIN
	--declare @IdDesde as smallint, @IdHasta as smallint = null
	--declare @Nombre as nvarchar(50) = null
	--declare @Codigo as varchar(50) = null
	--declare @Cultura as varchar(5) = null
	--declare @IdMarca as char(3) = null

	SELECT COUNT(*)
	FROM CategoriasCalendario
	WHERE (@IdDesde IS NULL OR @IdHasta IS NULL OR (CategoriasCalendario.Id >= @IdDesde AND CategoriasCalendario.Id < DateAdd(d, 1, @IdHasta)))
		AND (@Nombre IS NULL OR CategoriasCalendario.Nombre LIKE '%' + @Nombre + '%')
		AND (@Codigo IS NULL OR CategoriasCalendario.Codigo LIKE '%' + @Codigo + '%')
		AND (@IdMarca IS NULL OR CategoriasCalendario.IdMarca = @IdMarca)

END
GO

ALTER PROCEDURE [dbo].[CategoriaCalendario_ObtenerComboPorIdMarca](@IdMarca as char(3), @Cultura as varchar(5)) AS
BEGIN
	--declare @IdMarca as char(3) = 'CCB'
		--declare @Cultura as varchar(5) = 'es-ES'
	
	SELECT CategoriasCalendario.Id AS Id, COALESCE(CategoriasCalendario_idiomas.Nombre, CategoriasCalendario.Nombre) AS Nombre
	FROM CategoriasCalendario
		LEFT OUTER JOIN CategoriasCalendario_Idiomas ON CategoriasCalendario_Idiomas.IdRegistro = CategoriasCalendario.Id AND CategoriasCalendario_Idiomas.Cultura = @Cultura
	WHERE CategoriasCalendario.IdMarca = @IdMarca
	ORDER BY Nombre
END
GO


ALTER PROCEDURE [dbo].[CategoriaCalendario_ObtenerLista](@Lista as varchar(500)) AS
BEGIN
	--declare @Lista as varchar(500) = '1,2'

	SELECT CategoriasCalendario.Id AS Id, CategoriasCalendario.Nombre AS Nombre, CategoriasCalendario.Codigo AS Codigo, CategoriasCalendario.IdMarca AS IdMarca, Marcas_Marca.Nombre AS Marca
	FROM CategoriasCalendario
		INNER JOIN dbo.fnArrayATabla(@Lista, ',') l ON l.number = CategoriasCalendario.Id
			INNER JOIN Marcas AS Marcas_Marca ON Marcas_Marca.Id = CategoriasCalendario.IdMarca
END
GO

ALTER PROCEDURE [dbo].[CategoriaCalendario_Idioma_ObtenerPorFiltros](@RegistroInicial int = NULL, @RegistroFinal int = NULL, @ColumnaOrden nvarchar(50) = 'Id', @TipoOrden smallint = 1, @IdDesde as int, @IdHasta as int, @IdRegistroDesde as smallint, @IdRegistroHasta as smallint, @Cultura as varchar(5), @Nombre as nvarchar(50)) AS
BEGIN
	--declare @RegistroInicial int = 1
	--declare @RegistroFinal int = 50
	--declare @ColumnaOrden nvarchar(50) = 'Id'
	--declare @TipoOrden smallint = 0
	--declare @IdDesde as int, @IdHasta as int = null
	--declare @IdRegistroDesde as smallint, @IdRegistroHasta as smallint = null
	--declare @Cultura as varchar(5) = null
	--declare @Nombre as nvarchar(50) = null

	;WITH DATOS AS (
		SELECT ROW_NUMBER() OVER ( 
			ORDER BY
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Id' THEN CategoriasCalendario_Idiomas.Id END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Id' THEN CategoriasCalendario_Idiomas.Id END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'IdRegistro' THEN CategoriasCalendario_Idiomas.IdRegistro END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'IdRegistro' THEN CategoriasCalendario_Idiomas.IdRegistro END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Cultura' THEN CategoriasCalendario_Idiomas.Cultura END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Cultura' THEN CategoriasCalendario_Idiomas.Cultura END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Nombre' THEN CategoriasCalendario_Idiomas.Nombre END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Nombre' THEN CategoriasCalendario_Idiomas.Nombre END DESC
			) AS NumeroRegistro,
			CategoriasCalendario_Idiomas.Id AS Id, CategoriasCalendario_Idiomas.IdRegistro AS IdRegistro, CategoriasCalendario_Registro.Nombre AS Registro, CategoriasCalendario_Idiomas.Cultura AS Cultura, CategoriasCalendario_Idiomas.Nombre AS Nombre
		FROM CategoriasCalendario_Idiomas
			INNER JOIN CategoriasCalendario AS CategoriasCalendario_Registro ON CategoriasCalendario_Registro.Id = CategoriasCalendario_Idiomas.IdRegistro
		WHERE (@IdDesde IS NULL OR @IdHasta IS NULL OR (CategoriasCalendario_Idiomas.Id >= @IdDesde AND CategoriasCalendario_Idiomas.Id < DateAdd(d, 1, @IdHasta)))
		AND (@IdRegistroDesde IS NULL OR @IdRegistroHasta IS NULL OR (CategoriasCalendario_Idiomas.IdRegistro >= @IdRegistroDesde AND CategoriasCalendario_Idiomas.IdRegistro < DateAdd(d, 1, @IdRegistroHasta)))
		AND (@Cultura IS NULL OR CategoriasCalendario_Idiomas.Cultura = @Cultura)
		AND (@Nombre IS NULL OR CategoriasCalendario_Idiomas.Nombre LIKE '%' + @Nombre + '%')

	)
	SELECT Id, IdRegistro, Registro, Cultura, Nombre
	FROM DATOS
	WHERE (@RegistroInicial IS NULL AND @RegistroFinal IS NULL OR (NumeroRegistro >= @RegistroInicial AND NumeroRegistro <= @RegistroFinal)) 
END
GO

ALTER PROCEDURE [dbo].[CategoriaCalendario_Idioma_ObtenerCantidadPorFiltros](@IdDesde as int, @IdHasta as int, @IdRegistroDesde as smallint, @IdRegistroHasta as smallint, @Cultura as varchar(5), @Nombre as nvarchar(50)) AS
BEGIN
	--declare @IdDesde as int, @IdHasta as int = null
	--declare @IdRegistroDesde as smallint, @IdRegistroHasta as smallint = null
	--declare @Cultura as varchar(5) = null
	--declare @Nombre as nvarchar(50) = null

	SELECT COUNT(*)
	FROM CategoriasCalendario_Idiomas
	WHERE (@IdDesde IS NULL OR @IdHasta IS NULL OR (CategoriasCalendario_Idiomas.Id >= @IdDesde AND CategoriasCalendario_Idiomas.Id < DateAdd(d, 1, @IdHasta)))
		AND (@IdRegistroDesde IS NULL OR @IdRegistroHasta IS NULL OR (CategoriasCalendario_Idiomas.IdRegistro >= @IdRegistroDesde AND CategoriasCalendario_Idiomas.IdRegistro < DateAdd(d, 1, @IdRegistroHasta)))
		AND (@Cultura IS NULL OR CategoriasCalendario_Idiomas.Cultura = @Cultura)
		AND (@Nombre IS NULL OR CategoriasCalendario_Idiomas.Nombre LIKE '%' + @Nombre + '%')

END
GO

ALTER PROCEDURE [dbo].[CategoriaCalendario_Idioma_ObtenerCombo] AS
BEGIN
	SELECT CategoriasCalendario_Idiomas.Id AS Id, CategoriasCalendario_Idiomas.Nombre AS Nombre
	FROM CategoriasCalendario_Idiomas
	ORDER BY Nombre
END
GO


ALTER PROCEDURE [dbo].[CategoriaCalendario_Idioma_ObtenerLista](@Lista as varchar(500)) AS
BEGIN
	--declare @Lista as varchar(500) = '1,2'

	SELECT CategoriasCalendario_Idiomas.Id AS Id, CategoriasCalendario_Idiomas.IdRegistro AS IdRegistro, CategoriasCalendario_Registro.Nombre AS Registro, CategoriasCalendario_Idiomas.Cultura AS Cultura, CategoriasCalendario_Idiomas.Nombre AS Nombre
	FROM CategoriasCalendario_Idiomas
		INNER JOIN dbo.fnArrayATabla(@Lista, ',') l ON l.number = CategoriasCalendario_Idiomas.Id
			INNER JOIN CategoriasCalendario AS CategoriasCalendario_Registro ON CategoriasCalendario_Registro.Id = CategoriasCalendario_Idiomas.IdRegistro
END
GO

ALTER PROCEDURE [dbo].[CategoriaFoto_ObtenerPorFiltros](@RegistroInicial int = NULL, @RegistroFinal int = NULL, @ColumnaOrden nvarchar(50) = 'Id', @TipoOrden smallint = 1, @IdDesde as int, @IdHasta as int, @OrdenDesde as smallint, @OrdenHasta as smallint, @Activa as bit, @Nombre as nvarchar(150), @FechaAltaDesde as datetime, @FechaAltaHasta as datetime, @FechaUltimaModificacionDesde as datetime, @FechaUltimaModificacionHasta as datetime, @Cultura as varchar(5), @IdMarca as char(3)) AS
BEGIN
	--declare @RegistroInicial int = 1
	--declare @RegistroFinal int = 50
	--declare @ColumnaOrden nvarchar(50) = 'Id'
	--declare @TipoOrden smallint = 0
	--declare @IdDesde as int, @IdHasta as int = null
	--declare @OrdenDesde as smallint, @OrdenHasta as smallint = null
	--declare @Activa as bit = null
	--declare @Nombre as nvarchar(150) = null
	--declare @FechaAltaDesde as datetime, @FechaAltaHasta as datetime = null
	--declare @FechaUltimaModificacionDesde as datetime, @FechaUltimaModificacionHasta as datetime = null
	--declare @Cultura as varchar(5) = null
	--declare @IdMarca as char(3) = null

	;WITH DATOS AS (
		SELECT ROW_NUMBER() OVER ( 
			ORDER BY
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Id' THEN CategoriasFotos.Id END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Id' THEN CategoriasFotos.Id END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'FechaAlta' THEN CategoriasFotos.FechaAlta END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'FechaAlta' THEN CategoriasFotos.FechaAlta END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'FechaUltimaModificacion' THEN CategoriasFotos.FechaUltimaModificacion END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'FechaUltimaModificacion' THEN CategoriasFotos.FechaUltimaModificacion END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Activa' THEN CategoriasFotos.Activa END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Activa' THEN CategoriasFotos.Activa END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Orden' THEN CategoriasFotos.Orden END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Orden' THEN CategoriasFotos.Orden END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Nombre' THEN CategoriasFotos.Nombre END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Nombre' THEN CategoriasFotos.Nombre END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'IdMarca' THEN CategoriasFotos.IdMarca END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'IdMarca' THEN CategoriasFotos.IdMarca END DESC
			) AS NumeroRegistro,
			CategoriasFotos.Id AS Id, CategoriasFotos.FechaAlta AS FechaAlta, CategoriasFotos.FechaUltimaModificacion AS FechaUltimaModificacion, CategoriasFotos.Activa AS Activa, CategoriasFotos.Orden AS Orden, CategoriasFotos.Nombre AS Nombre, CategoriasFotos.IdMarca AS IdMarca, Marcas_Marca.Nombre AS Marca
		FROM CategoriasFotos
			INNER JOIN Marcas AS Marcas_Marca ON Marcas_Marca.Id = CategoriasFotos.IdMarca
		WHERE (@IdDesde IS NULL OR @IdHasta IS NULL OR (CategoriasFotos.Id >= @IdDesde AND CategoriasFotos.Id < DateAdd(d, 1, @IdHasta)))
		AND (@OrdenDesde IS NULL OR @OrdenHasta IS NULL OR (CategoriasFotos.Orden >= @OrdenDesde AND CategoriasFotos.Orden < DateAdd(d, 1, @OrdenHasta)))
		AND (@Activa IS NULL OR CategoriasFotos.Activa = @Activa)
		AND (@Nombre IS NULL OR CategoriasFotos.Nombre LIKE '%' + @Nombre + '%')
		AND (@FechaAltaDesde IS NULL OR @FechaAltaHasta IS NULL OR (CategoriasFotos.FechaAlta >= @FechaAltaDesde AND CategoriasFotos.FechaAlta < DateAdd(d, 1, @FechaAltaHasta)))
		AND (@FechaUltimaModificacionDesde IS NULL OR @FechaUltimaModificacionHasta IS NULL OR (CategoriasFotos.FechaUltimaModificacion >= @FechaUltimaModificacionDesde AND CategoriasFotos.FechaUltimaModificacion < DateAdd(d, 1, @FechaUltimaModificacionHasta)))
		AND (@IdMarca IS NULL OR CategoriasFotos.IdMarca = @IdMarca)

	)
	SELECT Id, FechaAlta, FechaUltimaModificacion, Activa, Orden, Nombre, IdMarca, Marca
	FROM DATOS
	WHERE (@RegistroInicial IS NULL AND @RegistroFinal IS NULL OR (NumeroRegistro >= @RegistroInicial AND NumeroRegistro <= @RegistroFinal)) 
END
GO

ALTER PROCEDURE [dbo].[CategoriaFoto_ObtenerCantidadPorFiltros](@IdDesde as int, @IdHasta as int, @OrdenDesde as smallint, @OrdenHasta as smallint, @Activa as bit, @Nombre as nvarchar(150), @FechaAltaDesde as datetime, @FechaAltaHasta as datetime, @FechaUltimaModificacionDesde as datetime, @FechaUltimaModificacionHasta as datetime, @Cultura as varchar(5), @IdMarca as char(3)) AS
BEGIN
	--declare @IdDesde as int, @IdHasta as int = null
	--declare @OrdenDesde as smallint, @OrdenHasta as smallint = null
	--declare @Activa as bit = null
	--declare @Nombre as nvarchar(150) = null
	--declare @FechaAltaDesde as datetime, @FechaAltaHasta as datetime = null
	--declare @FechaUltimaModificacionDesde as datetime, @FechaUltimaModificacionHasta as datetime = null
	--declare @Cultura as varchar(5) = null
	--declare @IdMarca as char(3) = null

	SELECT COUNT(*)
	FROM CategoriasFotos
	WHERE (@IdDesde IS NULL OR @IdHasta IS NULL OR (CategoriasFotos.Id >= @IdDesde AND CategoriasFotos.Id < DateAdd(d, 1, @IdHasta)))
		AND (@OrdenDesde IS NULL OR @OrdenHasta IS NULL OR (CategoriasFotos.Orden >= @OrdenDesde AND CategoriasFotos.Orden < DateAdd(d, 1, @OrdenHasta)))
		AND (@Activa IS NULL OR CategoriasFotos.Activa = @Activa)
		AND (@Nombre IS NULL OR CategoriasFotos.Nombre LIKE '%' + @Nombre + '%')
		AND (@FechaAltaDesde IS NULL OR @FechaAltaHasta IS NULL OR (CategoriasFotos.FechaAlta >= @FechaAltaDesde AND CategoriasFotos.FechaAlta < DateAdd(d, 1, @FechaAltaHasta)))
		AND (@FechaUltimaModificacionDesde IS NULL OR @FechaUltimaModificacionHasta IS NULL OR (CategoriasFotos.FechaUltimaModificacion >= @FechaUltimaModificacionDesde AND CategoriasFotos.FechaUltimaModificacion < DateAdd(d, 1, @FechaUltimaModificacionHasta)))
		AND (@IdMarca IS NULL OR CategoriasFotos.IdMarca = @IdMarca)

END
GO

ALTER PROCEDURE [dbo].[CategoriaFoto_ObtenerComboPorIdMarca](@IdMarca as char(3), @Cultura as varchar(5)) AS
BEGIN
	--declare @IdMarca as char(3) = 'CCB'
		--declare @Cultura as varchar(5) = 'es-ES'
	
	SELECT CategoriasFotos.Id AS Id, COALESCE(CategoriasFotos_idiomas.Nombre, CategoriasFotos.Nombre) AS Nombre
	FROM CategoriasFotos
		LEFT OUTER JOIN CategoriasFotos_Idiomas ON CategoriasFotos_Idiomas.IdRegistro = CategoriasFotos.Id AND CategoriasFotos_Idiomas.Cultura = @Cultura
	WHERE CategoriasFotos.IdMarca = @IdMarca
	ORDER BY Nombre
END
GO


ALTER PROCEDURE [dbo].[CategoriaFoto_ObtenerLista](@Lista as varchar(500)) AS
BEGIN
	--declare @Lista as varchar(500) = '1,2'

	SELECT CategoriasFotos.Id AS Id, CategoriasFotos.FechaAlta AS FechaAlta, CategoriasFotos.FechaUltimaModificacion AS FechaUltimaModificacion, CategoriasFotos.Activa AS Activa, CategoriasFotos.Orden AS Orden, CategoriasFotos.Nombre AS Nombre, CategoriasFotos.IdMarca AS IdMarca, Marcas_Marca.Nombre AS Marca
	FROM CategoriasFotos
		INNER JOIN dbo.fnArrayATabla(@Lista, ',') l ON l.number = CategoriasFotos.Id
			INNER JOIN Marcas AS Marcas_Marca ON Marcas_Marca.Id = CategoriasFotos.IdMarca
END
GO

ALTER PROCEDURE [dbo].[CategoriaFoto_Idioma_ObtenerPorFiltros](@RegistroInicial int = NULL, @RegistroFinal int = NULL, @ColumnaOrden nvarchar(50) = 'Id', @TipoOrden smallint = 1, @IdDesde as int, @IdHasta as int, @IdRegistro as int, @Cultura as varchar(5), @Nombre as nvarchar(150)) AS
BEGIN
	--declare @RegistroInicial int = 1
	--declare @RegistroFinal int = 50
	--declare @ColumnaOrden nvarchar(50) = 'Id'
	--declare @TipoOrden smallint = 0
	--declare @IdDesde as int, @IdHasta as int = null
	--declare @IdRegistro as int = null
	--declare @Cultura as varchar(5) = null
	--declare @Nombre as nvarchar(150) = null

	;WITH DATOS AS (
		SELECT ROW_NUMBER() OVER ( 
			ORDER BY
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Id' THEN CategoriasFotos_Idiomas.Id END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Id' THEN CategoriasFotos_Idiomas.Id END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'IdRegistro' THEN CategoriasFotos_Idiomas.IdRegistro END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'IdRegistro' THEN CategoriasFotos_Idiomas.IdRegistro END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Cultura' THEN CategoriasFotos_Idiomas.Cultura END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Cultura' THEN CategoriasFotos_Idiomas.Cultura END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Nombre' THEN CategoriasFotos_Idiomas.Nombre END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Nombre' THEN CategoriasFotos_Idiomas.Nombre END DESC
			) AS NumeroRegistro,
			CategoriasFotos_Idiomas.Id AS Id, CategoriasFotos_Idiomas.IdRegistro AS IdRegistro, CategoriasFotos_Registro.Nombre AS Registro, CategoriasFotos_Idiomas.Cultura AS Cultura, CategoriasFotos_Idiomas.Nombre AS Nombre
		FROM CategoriasFotos_Idiomas
			INNER JOIN CategoriasFotos AS CategoriasFotos_Registro ON CategoriasFotos_Registro.Id = CategoriasFotos_Idiomas.IdRegistro
		WHERE (@IdDesde IS NULL OR @IdHasta IS NULL OR (CategoriasFotos_Idiomas.Id >= @IdDesde AND CategoriasFotos_Idiomas.Id < DateAdd(d, 1, @IdHasta)))
		AND (@IdRegistro IS NULL OR CategoriasFotos_Idiomas.IdRegistro = @IdRegistro)
		AND (@Cultura IS NULL OR CategoriasFotos_Idiomas.Cultura = @Cultura)
		AND (@Nombre IS NULL OR CategoriasFotos_Idiomas.Nombre LIKE '%' + @Nombre + '%')

	)
	SELECT Id, IdRegistro, Registro, Cultura, Nombre
	FROM DATOS
	WHERE (@RegistroInicial IS NULL AND @RegistroFinal IS NULL OR (NumeroRegistro >= @RegistroInicial AND NumeroRegistro <= @RegistroFinal)) 
END
GO

ALTER PROCEDURE [dbo].[CategoriaFoto_Idioma_ObtenerCantidadPorFiltros](@IdDesde as int, @IdHasta as int, @IdRegistro as int, @Cultura as varchar(5), @Nombre as nvarchar(150)) AS
BEGIN
	--declare @IdDesde as int, @IdHasta as int = null
	--declare @IdRegistro as int = null
	--declare @Cultura as varchar(5) = null
	--declare @Nombre as nvarchar(150) = null

	SELECT COUNT(*)
	FROM CategoriasFotos_Idiomas
	WHERE (@IdDesde IS NULL OR @IdHasta IS NULL OR (CategoriasFotos_Idiomas.Id >= @IdDesde AND CategoriasFotos_Idiomas.Id < DateAdd(d, 1, @IdHasta)))
		AND (@IdRegistro IS NULL OR CategoriasFotos_Idiomas.IdRegistro = @IdRegistro)
		AND (@Cultura IS NULL OR CategoriasFotos_Idiomas.Cultura = @Cultura)
		AND (@Nombre IS NULL OR CategoriasFotos_Idiomas.Nombre LIKE '%' + @Nombre + '%')

END
GO

ALTER PROCEDURE [dbo].[CategoriaFoto_Idioma_ObtenerCombo] AS
BEGIN
	SELECT CategoriasFotos_Idiomas.Id AS Id, CategoriasFotos_Idiomas.Nombre AS Nombre
	FROM CategoriasFotos_Idiomas
	ORDER BY Nombre
END
GO


ALTER PROCEDURE [dbo].[CategoriaFoto_Idioma_ObtenerLista](@Lista as varchar(500)) AS
BEGIN
	--declare @Lista as varchar(500) = '1,2'

	SELECT CategoriasFotos_Idiomas.Id AS Id, CategoriasFotos_Idiomas.IdRegistro AS IdRegistro, CategoriasFotos_Registro.Nombre AS Registro, CategoriasFotos_Idiomas.Cultura AS Cultura, CategoriasFotos_Idiomas.Nombre AS Nombre
	FROM CategoriasFotos_Idiomas
		INNER JOIN dbo.fnArrayATabla(@Lista, ',') l ON l.number = CategoriasFotos_Idiomas.Id
			INNER JOIN CategoriasFotos AS CategoriasFotos_Registro ON CategoriasFotos_Registro.Id = CategoriasFotos_Idiomas.IdRegistro
END
GO

ALTER PROCEDURE [dbo].[Entidad_ObtenerPorFiltros](@RegistroInicial int = NULL, @RegistroFinal int = NULL, @ColumnaOrden nvarchar(50) = 'Id', @TipoOrden smallint = 1, @IdDesde as int, @IdHasta as int, @Nombre as nvarchar(50), @Codigo as varchar(50), @Cultura as varchar(5), @IdMarca as char(3)) AS
BEGIN
	--declare @RegistroInicial int = 1
	--declare @RegistroFinal int = 50
	--declare @ColumnaOrden nvarchar(50) = 'Id'
	--declare @TipoOrden smallint = 0
	--declare @IdDesde as int, @IdHasta as int = null
	--declare @Nombre as nvarchar(50) = null
	--declare @Codigo as varchar(50) = null
	--declare @Cultura as varchar(5) = null
	--declare @IdMarca as char(3) = null

	;WITH DATOS AS (
		SELECT ROW_NUMBER() OVER ( 
			ORDER BY
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Id' THEN Entidades.Id END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Id' THEN Entidades.Id END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Nombre' THEN Entidades.Nombre END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Nombre' THEN Entidades.Nombre END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Codigo' THEN Entidades.Codigo END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Codigo' THEN Entidades.Codigo END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'IdMarca' THEN Entidades.IdMarca END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'IdMarca' THEN Entidades.IdMarca END DESC
			) AS NumeroRegistro,
			Entidades.Id AS Id, Entidades.Nombre AS Nombre, Entidades.Codigo AS Codigo, Entidades.IdMarca AS IdMarca, Marcas_Marca.Nombre AS Marca
		FROM Entidades
			INNER JOIN Marcas AS Marcas_Marca ON Marcas_Marca.Id = Entidades.IdMarca
		WHERE (@IdDesde IS NULL OR @IdHasta IS NULL OR (Entidades.Id >= @IdDesde AND Entidades.Id < DateAdd(d, 1, @IdHasta)))
		AND (@Nombre IS NULL OR Entidades.Nombre LIKE '%' + @Nombre + '%')
		AND (@Codigo IS NULL OR Entidades.Codigo LIKE '%' + @Codigo + '%')
		AND (@IdMarca IS NULL OR Entidades.IdMarca = @IdMarca)

	)
	SELECT Id, Nombre, Codigo, IdMarca, Marca
	FROM DATOS
	WHERE (@RegistroInicial IS NULL AND @RegistroFinal IS NULL OR (NumeroRegistro >= @RegistroInicial AND NumeroRegistro <= @RegistroFinal)) 
END
GO

ALTER PROCEDURE [dbo].[Entidad_ObtenerCantidadPorFiltros](@IdDesde as int, @IdHasta as int, @Nombre as nvarchar(50), @Codigo as varchar(50), @Cultura as varchar(5), @IdMarca as char(3)) AS
BEGIN
	--declare @IdDesde as int, @IdHasta as int = null
	--declare @Nombre as nvarchar(50) = null
	--declare @Codigo as varchar(50) = null
	--declare @Cultura as varchar(5) = null
	--declare @IdMarca as char(3) = null

	SELECT COUNT(*)
	FROM Entidades
	WHERE (@IdDesde IS NULL OR @IdHasta IS NULL OR (Entidades.Id >= @IdDesde AND Entidades.Id < DateAdd(d, 1, @IdHasta)))
		AND (@Nombre IS NULL OR Entidades.Nombre LIKE '%' + @Nombre + '%')
		AND (@Codigo IS NULL OR Entidades.Codigo LIKE '%' + @Codigo + '%')
		AND (@IdMarca IS NULL OR Entidades.IdMarca = @IdMarca)

END
GO

ALTER PROCEDURE [dbo].[Entidad_ObtenerComboPorIdMarca](@IdMarca as char(3), @Cultura as varchar(5)) AS
BEGIN
	--declare @IdMarca as char(3) = 'CCB'
		--declare @Cultura as varchar(5) = 'es-ES'
	
	SELECT Entidades.Id AS Id, COALESCE(Entidades_idiomas.Nombre, Entidades.Nombre) AS Nombre
	FROM Entidades
		LEFT OUTER JOIN Entidades_Idiomas ON Entidades_Idiomas.IdRegistro = Entidades.Id AND Entidades_Idiomas.Cultura = @Cultura
	WHERE Entidades.IdMarca = @IdMarca
	ORDER BY Nombre
END
GO


ALTER PROCEDURE [dbo].[Entidad_ObtenerLista](@Lista as varchar(500)) AS
BEGIN
	--declare @Lista as varchar(500) = '1,2'

	SELECT Entidades.Id AS Id, Entidades.Nombre AS Nombre, Entidades.Codigo AS Codigo, Entidades.IdMarca AS IdMarca, Marcas_Marca.Nombre AS Marca
	FROM Entidades
		INNER JOIN dbo.fnArrayATabla(@Lista, ',') l ON l.number = Entidades.Id
			INNER JOIN Marcas AS Marcas_Marca ON Marcas_Marca.Id = Entidades.IdMarca
END
GO

ALTER PROCEDURE [dbo].[Entidad_Idioma_ObtenerPorFiltros](@RegistroInicial int = NULL, @RegistroFinal int = NULL, @ColumnaOrden nvarchar(50) = 'Id', @TipoOrden smallint = 1, @IdDesde as int, @IdHasta as int, @IdRegistro as int, @Cultura as varchar(5), @Nombre as nvarchar(50)) AS
BEGIN
	--declare @RegistroInicial int = 1
	--declare @RegistroFinal int = 50
	--declare @ColumnaOrden nvarchar(50) = 'Id'
	--declare @TipoOrden smallint = 0
	--declare @IdDesde as int, @IdHasta as int = null
	--declare @IdRegistro as int = null
	--declare @Cultura as varchar(5) = null
	--declare @Nombre as nvarchar(50) = null

	;WITH DATOS AS (
		SELECT ROW_NUMBER() OVER ( 
			ORDER BY
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Id' THEN Entidades_Idiomas.Id END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Id' THEN Entidades_Idiomas.Id END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'IdRegistro' THEN Entidades_Idiomas.IdRegistro END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'IdRegistro' THEN Entidades_Idiomas.IdRegistro END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Cultura' THEN Entidades_Idiomas.Cultura END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Cultura' THEN Entidades_Idiomas.Cultura END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Nombre' THEN Entidades_Idiomas.Nombre END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Nombre' THEN Entidades_Idiomas.Nombre END DESC
			) AS NumeroRegistro,
			Entidades_Idiomas.Id AS Id, Entidades_Idiomas.IdRegistro AS IdRegistro, Entidades_Registro.Nombre AS Registro, Entidades_Idiomas.Cultura AS Cultura, Entidades_Idiomas.Nombre AS Nombre
		FROM Entidades_Idiomas
			INNER JOIN Entidades AS Entidades_Registro ON Entidades_Registro.Id = Entidades_Idiomas.IdRegistro
		WHERE (@IdDesde IS NULL OR @IdHasta IS NULL OR (Entidades_Idiomas.Id >= @IdDesde AND Entidades_Idiomas.Id < DateAdd(d, 1, @IdHasta)))
		AND (@IdRegistro IS NULL OR Entidades_Idiomas.IdRegistro = @IdRegistro)
		AND (@Cultura IS NULL OR Entidades_Idiomas.Cultura = @Cultura)
		AND (@Nombre IS NULL OR Entidades_Idiomas.Nombre LIKE '%' + @Nombre + '%')

	)
	SELECT Id, IdRegistro, Registro, Cultura, Nombre
	FROM DATOS
	WHERE (@RegistroInicial IS NULL AND @RegistroFinal IS NULL OR (NumeroRegistro >= @RegistroInicial AND NumeroRegistro <= @RegistroFinal)) 
END
GO

ALTER PROCEDURE [dbo].[Entidad_Idioma_ObtenerCantidadPorFiltros](@IdDesde as int, @IdHasta as int, @IdRegistro as int, @Cultura as varchar(5), @Nombre as nvarchar(50)) AS
BEGIN
	--declare @IdDesde as int, @IdHasta as int = null
	--declare @IdRegistro as int = null
	--declare @Cultura as varchar(5) = null
	--declare @Nombre as nvarchar(50) = null

	SELECT COUNT(*)
	FROM Entidades_Idiomas
	WHERE (@IdDesde IS NULL OR @IdHasta IS NULL OR (Entidades_Idiomas.Id >= @IdDesde AND Entidades_Idiomas.Id < DateAdd(d, 1, @IdHasta)))
		AND (@IdRegistro IS NULL OR Entidades_Idiomas.IdRegistro = @IdRegistro)
		AND (@Cultura IS NULL OR Entidades_Idiomas.Cultura = @Cultura)
		AND (@Nombre IS NULL OR Entidades_Idiomas.Nombre LIKE '%' + @Nombre + '%')

END
GO

ALTER PROCEDURE [dbo].[Entidad_Idioma_ObtenerCombo] AS
BEGIN
	SELECT Entidades_Idiomas.Id AS Id, Entidades_Idiomas.Nombre AS Nombre
	FROM Entidades_Idiomas
	ORDER BY Nombre
END
GO


ALTER PROCEDURE [dbo].[Entidad_Idioma_ObtenerLista](@Lista as varchar(500)) AS
BEGIN
	--declare @Lista as varchar(500) = '1,2'

	SELECT Entidades_Idiomas.Id AS Id, Entidades_Idiomas.IdRegistro AS IdRegistro, Entidades_Registro.Nombre AS Registro, Entidades_Idiomas.Cultura AS Cultura, Entidades_Idiomas.Nombre AS Nombre
	FROM Entidades_Idiomas
		INNER JOIN dbo.fnArrayATabla(@Lista, ',') l ON l.number = Entidades_Idiomas.Id
			INNER JOIN Entidades AS Entidades_Registro ON Entidades_Registro.Id = Entidades_Idiomas.IdRegistro
END
GO

ALTER PROCEDURE [dbo].[EstadoCalendario_ObtenerPorFiltros](@RegistroInicial int = NULL, @RegistroFinal int = NULL, @ColumnaOrden nvarchar(50) = 'Id', @TipoOrden smallint = 1, @IdDesde as smallint, @IdHasta as smallint, @Nombre as nvarchar(50), @Codigo as varchar(50), @Cultura as varchar(5), @IdMarca as char(3)) AS
BEGIN
	--declare @RegistroInicial int = 1
	--declare @RegistroFinal int = 50
	--declare @ColumnaOrden nvarchar(50) = 'Id'
	--declare @TipoOrden smallint = 0
	--declare @IdDesde as smallint, @IdHasta as smallint = null
	--declare @Nombre as nvarchar(50) = null
	--declare @Codigo as varchar(50) = null
	--declare @Cultura as varchar(5) = null
	--declare @IdMarca as char(3) = null

	;WITH DATOS AS (
		SELECT ROW_NUMBER() OVER ( 
			ORDER BY
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Id' THEN EstadosCalendario.Id END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Id' THEN EstadosCalendario.Id END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Nombre' THEN EstadosCalendario.Nombre END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Nombre' THEN EstadosCalendario.Nombre END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Codigo' THEN EstadosCalendario.Codigo END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Codigo' THEN EstadosCalendario.Codigo END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'IdMarca' THEN EstadosCalendario.IdMarca END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'IdMarca' THEN EstadosCalendario.IdMarca END DESC
			) AS NumeroRegistro,
			EstadosCalendario.Id AS Id, EstadosCalendario.Nombre AS Nombre, EstadosCalendario.Codigo AS Codigo, EstadosCalendario.IdMarca AS IdMarca, Marcas_Marca.Nombre AS Marca
		FROM EstadosCalendario
			INNER JOIN Marcas AS Marcas_Marca ON Marcas_Marca.Id = EstadosCalendario.IdMarca
		WHERE (@IdDesde IS NULL OR @IdHasta IS NULL OR (EstadosCalendario.Id >= @IdDesde AND EstadosCalendario.Id < DateAdd(d, 1, @IdHasta)))
		AND (@Nombre IS NULL OR EstadosCalendario.Nombre LIKE '%' + @Nombre + '%')
		AND (@Codigo IS NULL OR EstadosCalendario.Codigo LIKE '%' + @Codigo + '%')
		AND (@IdMarca IS NULL OR EstadosCalendario.IdMarca = @IdMarca)

	)
	SELECT Id, Nombre, Codigo, IdMarca, Marca
	FROM DATOS
	WHERE (@RegistroInicial IS NULL AND @RegistroFinal IS NULL OR (NumeroRegistro >= @RegistroInicial AND NumeroRegistro <= @RegistroFinal)) 
END
GO

ALTER PROCEDURE [dbo].[EstadoCalendario_ObtenerCantidadPorFiltros](@IdDesde as smallint, @IdHasta as smallint, @Nombre as nvarchar(50), @Codigo as varchar(50), @Cultura as varchar(5), @IdMarca as char(3)) AS
BEGIN
	--declare @IdDesde as smallint, @IdHasta as smallint = null
	--declare @Nombre as nvarchar(50) = null
	--declare @Codigo as varchar(50) = null
	--declare @Cultura as varchar(5) = null
	--declare @IdMarca as char(3) = null

	SELECT COUNT(*)
	FROM EstadosCalendario
	WHERE (@IdDesde IS NULL OR @IdHasta IS NULL OR (EstadosCalendario.Id >= @IdDesde AND EstadosCalendario.Id < DateAdd(d, 1, @IdHasta)))
		AND (@Nombre IS NULL OR EstadosCalendario.Nombre LIKE '%' + @Nombre + '%')
		AND (@Codigo IS NULL OR EstadosCalendario.Codigo LIKE '%' + @Codigo + '%')
		AND (@IdMarca IS NULL OR EstadosCalendario.IdMarca = @IdMarca)

END
GO

ALTER PROCEDURE [dbo].[EstadoCalendario_ObtenerComboPorIdMarca](@IdMarca as char(3), @Cultura as varchar(5)) AS
BEGIN
	--declare @IdMarca as char(3) = 'CCB'
		--declare @Cultura as varchar(5) = 'es-ES'
	
	SELECT EstadosCalendario.Id AS Id, COALESCE(EstadosCalendario_idiomas.Nombre, EstadosCalendario.Nombre) AS Nombre
	FROM EstadosCalendario
		LEFT OUTER JOIN EstadosCalendario_Idiomas ON EstadosCalendario_Idiomas.IdRegistro = EstadosCalendario.Id AND EstadosCalendario_Idiomas.Cultura = @Cultura
	WHERE EstadosCalendario.IdMarca = @IdMarca
	ORDER BY Nombre
END
GO


ALTER PROCEDURE [dbo].[EstadoCalendario_ObtenerLista](@Lista as varchar(500)) AS
BEGIN
	--declare @Lista as varchar(500) = '1,2'

	SELECT EstadosCalendario.Id AS Id, EstadosCalendario.Nombre AS Nombre, EstadosCalendario.Codigo AS Codigo, EstadosCalendario.IdMarca AS IdMarca, Marcas_Marca.Nombre AS Marca
	FROM EstadosCalendario
		INNER JOIN dbo.fnArrayATabla(@Lista, ',') l ON l.number = EstadosCalendario.Id
			INNER JOIN Marcas AS Marcas_Marca ON Marcas_Marca.Id = EstadosCalendario.IdMarca
END
GO

ALTER PROCEDURE [dbo].[EstadoCalendario_Idioma_ObtenerPorFiltros](@RegistroInicial int = NULL, @RegistroFinal int = NULL, @ColumnaOrden nvarchar(50) = 'Id', @TipoOrden smallint = 1, @IdDesde as int, @IdHasta as int, @IdRegistro as smallint, @Cultura as varchar(5), @Nombre as nvarchar(50)) AS
BEGIN
	--declare @RegistroInicial int = 1
	--declare @RegistroFinal int = 50
	--declare @ColumnaOrden nvarchar(50) = 'Id'
	--declare @TipoOrden smallint = 0
	--declare @IdDesde as int, @IdHasta as int = null
	--declare @IdRegistro as smallint = null
	--declare @Cultura as varchar(5) = null
	--declare @Nombre as nvarchar(50) = null

	;WITH DATOS AS (
		SELECT ROW_NUMBER() OVER ( 
			ORDER BY
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Id' THEN EstadosCalendario_Idiomas.Id END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Id' THEN EstadosCalendario_Idiomas.Id END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'IdRegistro' THEN EstadosCalendario_Idiomas.IdRegistro END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'IdRegistro' THEN EstadosCalendario_Idiomas.IdRegistro END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Cultura' THEN EstadosCalendario_Idiomas.Cultura END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Cultura' THEN EstadosCalendario_Idiomas.Cultura END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Nombre' THEN EstadosCalendario_Idiomas.Nombre END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Nombre' THEN EstadosCalendario_Idiomas.Nombre END DESC
			) AS NumeroRegistro,
			EstadosCalendario_Idiomas.Id AS Id, EstadosCalendario_Idiomas.IdRegistro AS IdRegistro, EstadosCalendario_Registro.Nombre AS Registro, EstadosCalendario_Idiomas.Cultura AS Cultura, EstadosCalendario_Idiomas.Nombre AS Nombre
		FROM EstadosCalendario_Idiomas
			INNER JOIN EstadosCalendario AS EstadosCalendario_Registro ON EstadosCalendario_Registro.Id = EstadosCalendario_Idiomas.IdRegistro
		WHERE (@IdDesde IS NULL OR @IdHasta IS NULL OR (EstadosCalendario_Idiomas.Id >= @IdDesde AND EstadosCalendario_Idiomas.Id < DateAdd(d, 1, @IdHasta)))
		AND (@IdRegistro IS NULL OR EstadosCalendario_Idiomas.IdRegistro = @IdRegistro)
		AND (@Cultura IS NULL OR EstadosCalendario_Idiomas.Cultura = @Cultura)
		AND (@Nombre IS NULL OR EstadosCalendario_Idiomas.Nombre LIKE '%' + @Nombre + '%')

	)
	SELECT Id, IdRegistro, Registro, Cultura, Nombre
	FROM DATOS
	WHERE (@RegistroInicial IS NULL AND @RegistroFinal IS NULL OR (NumeroRegistro >= @RegistroInicial AND NumeroRegistro <= @RegistroFinal)) 
END
GO

ALTER PROCEDURE [dbo].[EstadoCalendario_Idioma_ObtenerCantidadPorFiltros](@IdDesde as int, @IdHasta as int, @IdRegistro as smallint, @Cultura as varchar(5), @Nombre as nvarchar(50)) AS
BEGIN
	--declare @IdDesde as int, @IdHasta as int = null
	--declare @IdRegistro as smallint = null
	--declare @Cultura as varchar(5) = null
	--declare @Nombre as nvarchar(50) = null

	SELECT COUNT(*)
	FROM EstadosCalendario_Idiomas
	WHERE (@IdDesde IS NULL OR @IdHasta IS NULL OR (EstadosCalendario_Idiomas.Id >= @IdDesde AND EstadosCalendario_Idiomas.Id < DateAdd(d, 1, @IdHasta)))
		AND (@IdRegistro IS NULL OR EstadosCalendario_Idiomas.IdRegistro = @IdRegistro)
		AND (@Cultura IS NULL OR EstadosCalendario_Idiomas.Cultura = @Cultura)
		AND (@Nombre IS NULL OR EstadosCalendario_Idiomas.Nombre LIKE '%' + @Nombre + '%')

END
GO

ALTER PROCEDURE [dbo].[EstadoCalendario_Idioma_ObtenerCombo] AS
BEGIN
	SELECT EstadosCalendario_Idiomas.Id AS Id, EstadosCalendario_Idiomas.Nombre AS Nombre
	FROM EstadosCalendario_Idiomas
	ORDER BY Nombre
END
GO


ALTER PROCEDURE [dbo].[EstadoCalendario_Idioma_ObtenerLista](@Lista as varchar(500)) AS
BEGIN
	--declare @Lista as varchar(500) = '1,2'

	SELECT EstadosCalendario_Idiomas.Id AS Id, EstadosCalendario_Idiomas.IdRegistro AS IdRegistro, EstadosCalendario_Registro.Nombre AS Registro, EstadosCalendario_Idiomas.Cultura AS Cultura, EstadosCalendario_Idiomas.Nombre AS Nombre
	FROM EstadosCalendario_Idiomas
		INNER JOIN dbo.fnArrayATabla(@Lista, ',') l ON l.number = EstadosCalendario_Idiomas.Id
			INNER JOIN EstadosCalendario AS EstadosCalendario_Registro ON EstadosCalendario_Registro.Id = EstadosCalendario_Idiomas.IdRegistro
END
GO

ALTER PROCEDURE [dbo].[Evento_ObtenerPorFiltros](@RegistroInicial int = NULL, @RegistroFinal int = NULL, @ColumnaOrden nvarchar(50) = 'Id', @TipoOrden smallint = 1, @IdDesde as int, @IdHasta as int, @IdTipo as smallint, @Activa as bit, @Nombre as nvarchar(750), @FechaDesde as date, @FechaHasta as date, @HoraInicioDesde as time, @HoraInicioHasta as time, @HoraFinDesde as time, @HoraFinHasta as time, @Ubicacion as nvarchar(500), @Descripcion as nvarchar(max), @FechaAltaDesde as datetime, @FechaAltaHasta as datetime, @FechaUltimaModificacionDesde as datetime, @FechaUltimaModificacionHasta as datetime, @Cultura as varchar(5), @IdMarca as char(3)) AS
BEGIN
	--declare @RegistroInicial int = 1
	--declare @RegistroFinal int = 50
	--declare @ColumnaOrden nvarchar(50) = 'Id'
	--declare @TipoOrden smallint = 0
	--declare @IdDesde as int, @IdHasta as int = null
	--declare @IdTipo as smallint = null
	--declare @Activa as bit = null
	--declare @Nombre as nvarchar(750) = null
	--declare @FechaDesde as date, @FechaHasta as date = null
	--declare @HoraInicioDesde as time, @HoraInicioHasta as time = null
	--declare @HoraFinDesde as time, @HoraFinHasta as time = null
	--declare @Ubicacion as nvarchar(500) = null
	--declare @Descripcion as nvarchar(max) = null
	--declare @FechaAltaDesde as datetime, @FechaAltaHasta as datetime = null
	--declare @FechaUltimaModificacionDesde as datetime, @FechaUltimaModificacionHasta as datetime = null
	--declare @Cultura as varchar(5) = null
	--declare @IdMarca as char(3) = null

	;WITH DATOS AS (
		SELECT ROW_NUMBER() OVER ( 
			ORDER BY
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Id' THEN Eventos.Id END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Id' THEN Eventos.Id END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'FechaAlta' THEN Eventos.FechaAlta END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'FechaAlta' THEN Eventos.FechaAlta END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'FechaUltimaModificacion' THEN Eventos.FechaUltimaModificacion END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'FechaUltimaModificacion' THEN Eventos.FechaUltimaModificacion END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Fecha' THEN Eventos.Fecha END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Fecha' THEN Eventos.Fecha END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'HoraInicio' THEN Eventos.HoraInicio END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'HoraInicio' THEN Eventos.HoraInicio END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'HoraFin' THEN Eventos.HoraFin END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'HoraFin' THEN Eventos.HoraFin END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'IdTipo' THEN Eventos.IdTipo END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'IdTipo' THEN Eventos.IdTipo END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Activa' THEN Eventos.Activa END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Activa' THEN Eventos.Activa END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'IdMarca' THEN Eventos.IdMarca END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'IdMarca' THEN Eventos.IdMarca END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Nombre' THEN Eventos.Nombre END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Nombre' THEN Eventos.Nombre END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Descripcion' THEN Eventos.Descripcion END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Descripcion' THEN Eventos.Descripcion END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Ubicacion' THEN Eventos.Ubicacion END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Ubicacion' THEN Eventos.Ubicacion END DESC
			) AS NumeroRegistro,
			Eventos.Id AS Id, Eventos.FechaAlta AS FechaAlta, Eventos.FechaUltimaModificacion AS FechaUltimaModificacion, Eventos.Fecha AS Fecha, Eventos.HoraInicio AS HoraInicio, Eventos.HoraFin AS HoraFin, Eventos.IdTipo AS IdTipo, TiposEvento_Tipo.Nombre AS Tipo, Eventos.Activa AS Activa, Eventos.IdMarca AS IdMarca, Marcas_Marca.Nombre AS Marca, Eventos.Nombre AS Nombre, Eventos.Descripcion AS Descripcion, Eventos.Ubicacion AS Ubicacion
		FROM Eventos
			INNER JOIN Marcas AS Marcas_Marca ON Marcas_Marca.Id = Eventos.IdMarca
			INNER JOIN TiposEvento AS TiposEvento_Tipo ON TiposEvento_Tipo.Id = Eventos.IdTipo
		WHERE (@IdDesde IS NULL OR @IdHasta IS NULL OR (Eventos.Id >= @IdDesde AND Eventos.Id < DateAdd(d, 1, @IdHasta)))
		AND (@IdTipo IS NULL OR Eventos.IdTipo = @IdTipo)
		AND (@Activa IS NULL OR Eventos.Activa = @Activa)
		AND (@Nombre IS NULL OR Eventos.Nombre LIKE '%' + @Nombre + '%')
		AND (@FechaDesde IS NULL OR @FechaHasta IS NULL OR (Eventos.Fecha >= @FechaDesde AND Eventos.Fecha < DateAdd(d, 1, @FechaHasta)))
		AND (@HoraInicioDesde IS NULL OR @HoraInicioHasta IS NULL OR (Eventos.HoraInicio >= @HoraInicioDesde AND Eventos.HoraInicio < DateAdd(d, 1, @HoraInicioHasta)))
		AND (@HoraFinDesde IS NULL OR @HoraFinHasta IS NULL OR (Eventos.HoraFin >= @HoraFinDesde AND Eventos.HoraFin < DateAdd(d, 1, @HoraFinHasta)))
		AND (@Ubicacion IS NULL OR Eventos.Ubicacion LIKE '%' + @Ubicacion + '%')
		AND (@Descripcion IS NULL OR Eventos.Descripcion LIKE '%' + @Descripcion + '%')
		AND (@FechaAltaDesde IS NULL OR @FechaAltaHasta IS NULL OR (Eventos.FechaAlta >= @FechaAltaDesde AND Eventos.FechaAlta < DateAdd(d, 1, @FechaAltaHasta)))
		AND (@FechaUltimaModificacionDesde IS NULL OR @FechaUltimaModificacionHasta IS NULL OR (Eventos.FechaUltimaModificacion >= @FechaUltimaModificacionDesde AND Eventos.FechaUltimaModificacion < DateAdd(d, 1, @FechaUltimaModificacionHasta)))
		AND (@IdMarca IS NULL OR Eventos.IdMarca = @IdMarca)

	)
	SELECT Id, FechaAlta, FechaUltimaModificacion, Fecha, HoraInicio, HoraFin, IdTipo, Tipo, Activa, IdMarca, Marca, Nombre, Descripcion, Ubicacion
	FROM DATOS
	WHERE (@RegistroInicial IS NULL AND @RegistroFinal IS NULL OR (NumeroRegistro >= @RegistroInicial AND NumeroRegistro <= @RegistroFinal)) 
END
GO

ALTER PROCEDURE [dbo].[Evento_ObtenerCantidadPorFiltros](@IdDesde as int, @IdHasta as int, @IdTipo as smallint, @Activa as bit, @Nombre as nvarchar(750), @FechaDesde as date, @FechaHasta as date, @HoraInicioDesde as time, @HoraInicioHasta as time, @HoraFinDesde as time, @HoraFinHasta as time, @Ubicacion as nvarchar(500), @Descripcion as nvarchar(max), @FechaAltaDesde as datetime, @FechaAltaHasta as datetime, @FechaUltimaModificacionDesde as datetime, @FechaUltimaModificacionHasta as datetime, @Cultura as varchar(5), @IdMarca as char(3)) AS
BEGIN
	--declare @IdDesde as int, @IdHasta as int = null
	--declare @IdTipo as smallint = null
	--declare @Activa as bit = null
	--declare @Nombre as nvarchar(750) = null
	--declare @FechaDesde as date, @FechaHasta as date = null
	--declare @HoraInicioDesde as time, @HoraInicioHasta as time = null
	--declare @HoraFinDesde as time, @HoraFinHasta as time = null
	--declare @Ubicacion as nvarchar(500) = null
	--declare @Descripcion as nvarchar(max) = null
	--declare @FechaAltaDesde as datetime, @FechaAltaHasta as datetime = null
	--declare @FechaUltimaModificacionDesde as datetime, @FechaUltimaModificacionHasta as datetime = null
	--declare @Cultura as varchar(5) = null
	--declare @IdMarca as char(3) = null

	SELECT COUNT(*)
	FROM Eventos
	WHERE (@IdDesde IS NULL OR @IdHasta IS NULL OR (Eventos.Id >= @IdDesde AND Eventos.Id < DateAdd(d, 1, @IdHasta)))
		AND (@IdTipo IS NULL OR Eventos.IdTipo = @IdTipo)
		AND (@Activa IS NULL OR Eventos.Activa = @Activa)
		AND (@Nombre IS NULL OR Eventos.Nombre LIKE '%' + @Nombre + '%')
		AND (@FechaDesde IS NULL OR @FechaHasta IS NULL OR (Eventos.Fecha >= @FechaDesde AND Eventos.Fecha < DateAdd(d, 1, @FechaHasta)))
		AND (@HoraInicioDesde IS NULL OR @HoraInicioHasta IS NULL OR (Eventos.HoraInicio >= @HoraInicioDesde AND Eventos.HoraInicio < DateAdd(d, 1, @HoraInicioHasta)))
		AND (@HoraFinDesde IS NULL OR @HoraFinHasta IS NULL OR (Eventos.HoraFin >= @HoraFinDesde AND Eventos.HoraFin < DateAdd(d, 1, @HoraFinHasta)))
		AND (@Ubicacion IS NULL OR Eventos.Ubicacion LIKE '%' + @Ubicacion + '%')
		AND (@Descripcion IS NULL OR Eventos.Descripcion LIKE '%' + @Descripcion + '%')
		AND (@FechaAltaDesde IS NULL OR @FechaAltaHasta IS NULL OR (Eventos.FechaAlta >= @FechaAltaDesde AND Eventos.FechaAlta < DateAdd(d, 1, @FechaAltaHasta)))
		AND (@FechaUltimaModificacionDesde IS NULL OR @FechaUltimaModificacionHasta IS NULL OR (Eventos.FechaUltimaModificacion >= @FechaUltimaModificacionDesde AND Eventos.FechaUltimaModificacion < DateAdd(d, 1, @FechaUltimaModificacionHasta)))
		AND (@IdMarca IS NULL OR Eventos.IdMarca = @IdMarca)

END
GO

ALTER PROCEDURE [dbo].[Evento_ObtenerComboPorIdMarca](@IdMarca as char(3), @Cultura as varchar(5)) AS
BEGIN
	--declare @IdMarca as char(3) = 'CCB'
		--declare @Cultura as varchar(5) = 'es-ES'
	
	SELECT Eventos.Id AS Id, COALESCE(Eventos_idiomas.Nombre, Eventos.Nombre) AS Nombre
	FROM Eventos
		LEFT OUTER JOIN Eventos_Idiomas ON Eventos_Idiomas.IdRegistro = Eventos.Id AND Eventos_Idiomas.Cultura = @Cultura
	WHERE Eventos.IdMarca = @IdMarca
	ORDER BY Nombre
END
GO


ALTER PROCEDURE [dbo].[Evento_ObtenerLista](@Lista as varchar(500)) AS
BEGIN
	--declare @Lista as varchar(500) = '1,2'

	SELECT Eventos.Id AS Id, Eventos.FechaAlta AS FechaAlta, Eventos.FechaUltimaModificacion AS FechaUltimaModificacion, Eventos.Fecha AS Fecha, Eventos.HoraInicio AS HoraInicio, Eventos.HoraFin AS HoraFin, Eventos.IdTipo AS IdTipo, TiposEvento_Tipo.Nombre AS Tipo, Eventos.Activa AS Activa, Eventos.IdMarca AS IdMarca, Marcas_Marca.Nombre AS Marca, Eventos.Nombre AS Nombre, Eventos.Descripcion AS Descripcion, Eventos.Ubicacion AS Ubicacion
	FROM Eventos
		INNER JOIN dbo.fnArrayATabla(@Lista, ',') l ON l.number = Eventos.Id
			INNER JOIN Marcas AS Marcas_Marca ON Marcas_Marca.Id = Eventos.IdMarca
			INNER JOIN TiposEvento AS TiposEvento_Tipo ON TiposEvento_Tipo.Id = Eventos.IdTipo
END
GO

ALTER PROCEDURE [dbo].[Evento_Idioma_ObtenerPorFiltros](@RegistroInicial int = NULL, @RegistroFinal int = NULL, @ColumnaOrden nvarchar(50) = 'Id', @TipoOrden smallint = 1, @IdDesde as int, @IdHasta as int, @IdRegistro as int, @Cultura as varchar(5), @Ubicacion as nvarchar(500), @Nombre as nvarchar(750), @Descripcion as nvarchar(max)) AS
BEGIN
	--declare @RegistroInicial int = 1
	--declare @RegistroFinal int = 50
	--declare @ColumnaOrden nvarchar(50) = 'Id'
	--declare @TipoOrden smallint = 0
	--declare @IdDesde as int, @IdHasta as int = null
	--declare @IdRegistro as int = null
	--declare @Cultura as varchar(5) = null
	--declare @Ubicacion as nvarchar(500) = null
	--declare @Nombre as nvarchar(750) = null
	--declare @Descripcion as nvarchar(max) = null

	;WITH DATOS AS (
		SELECT ROW_NUMBER() OVER ( 
			ORDER BY
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Id' THEN Eventos_Idiomas.Id END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Id' THEN Eventos_Idiomas.Id END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'IdRegistro' THEN Eventos_Idiomas.IdRegistro END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'IdRegistro' THEN Eventos_Idiomas.IdRegistro END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Cultura' THEN Eventos_Idiomas.Cultura END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Cultura' THEN Eventos_Idiomas.Cultura END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Ubicacion' THEN Eventos_Idiomas.Ubicacion END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Ubicacion' THEN Eventos_Idiomas.Ubicacion END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Nombre' THEN Eventos_Idiomas.Nombre END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Nombre' THEN Eventos_Idiomas.Nombre END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Descripcion' THEN Eventos_Idiomas.Descripcion END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Descripcion' THEN Eventos_Idiomas.Descripcion END DESC
			) AS NumeroRegistro,
			Eventos_Idiomas.Id AS Id, Eventos_Idiomas.IdRegistro AS IdRegistro, Eventos_Registro.Nombre AS Registro, Eventos_Idiomas.Cultura AS Cultura, Eventos_Idiomas.Ubicacion AS Ubicacion, Eventos_Idiomas.Nombre AS Nombre, Eventos_Idiomas.Descripcion AS Descripcion
		FROM Eventos_Idiomas
			INNER JOIN Eventos AS Eventos_Registro ON Eventos_Registro.Id = Eventos_Idiomas.IdRegistro
		WHERE (@IdDesde IS NULL OR @IdHasta IS NULL OR (Eventos_Idiomas.Id >= @IdDesde AND Eventos_Idiomas.Id < DateAdd(d, 1, @IdHasta)))
		AND (@IdRegistro IS NULL OR Eventos_Idiomas.IdRegistro = @IdRegistro)
		AND (@Cultura IS NULL OR Eventos_Idiomas.Cultura = @Cultura)
		AND (@Ubicacion IS NULL OR Eventos_Idiomas.Ubicacion LIKE '%' + @Ubicacion + '%')
		AND (@Nombre IS NULL OR Eventos_Idiomas.Nombre LIKE '%' + @Nombre + '%')
		AND (@Descripcion IS NULL OR Eventos_Idiomas.Descripcion LIKE '%' + @Descripcion + '%')

	)
	SELECT Id, IdRegistro, Registro, Cultura, Ubicacion, Nombre, Descripcion
	FROM DATOS
	WHERE (@RegistroInicial IS NULL AND @RegistroFinal IS NULL OR (NumeroRegistro >= @RegistroInicial AND NumeroRegistro <= @RegistroFinal)) 
END
GO

ALTER PROCEDURE [dbo].[Evento_Idioma_ObtenerCantidadPorFiltros](@IdDesde as int, @IdHasta as int, @IdRegistro as int, @Cultura as varchar(5), @Ubicacion as nvarchar(500), @Nombre as nvarchar(750), @Descripcion as nvarchar(max)) AS
BEGIN
	--declare @IdDesde as int, @IdHasta as int = null
	--declare @IdRegistro as int = null
	--declare @Cultura as varchar(5) = null
	--declare @Ubicacion as nvarchar(500) = null
	--declare @Nombre as nvarchar(750) = null
	--declare @Descripcion as nvarchar(max) = null

	SELECT COUNT(*)
	FROM Eventos_Idiomas
	WHERE (@IdDesde IS NULL OR @IdHasta IS NULL OR (Eventos_Idiomas.Id >= @IdDesde AND Eventos_Idiomas.Id < DateAdd(d, 1, @IdHasta)))
		AND (@IdRegistro IS NULL OR Eventos_Idiomas.IdRegistro = @IdRegistro)
		AND (@Cultura IS NULL OR Eventos_Idiomas.Cultura = @Cultura)
		AND (@Ubicacion IS NULL OR Eventos_Idiomas.Ubicacion LIKE '%' + @Ubicacion + '%')
		AND (@Nombre IS NULL OR Eventos_Idiomas.Nombre LIKE '%' + @Nombre + '%')
		AND (@Descripcion IS NULL OR Eventos_Idiomas.Descripcion LIKE '%' + @Descripcion + '%')

END
GO

ALTER PROCEDURE [dbo].[Evento_Idioma_ObtenerCombo] AS
BEGIN
	SELECT Eventos_Idiomas.Id AS Id, Eventos_Idiomas.Nombre AS Nombre
	FROM Eventos_Idiomas
	ORDER BY Nombre
END
GO


ALTER PROCEDURE [dbo].[Evento_Idioma_ObtenerLista](@Lista as varchar(500)) AS
BEGIN
	--declare @Lista as varchar(500) = '1,2'

	SELECT Eventos_Idiomas.Id AS Id, Eventos_Idiomas.IdRegistro AS IdRegistro, Eventos_Registro.Nombre AS Registro, Eventos_Idiomas.Cultura AS Cultura, Eventos_Idiomas.Ubicacion AS Ubicacion, Eventos_Idiomas.Nombre AS Nombre, Eventos_Idiomas.Descripcion AS Descripcion
	FROM Eventos_Idiomas
		INNER JOIN dbo.fnArrayATabla(@Lista, ',') l ON l.number = Eventos_Idiomas.Id
			INNER JOIN Eventos AS Eventos_Registro ON Eventos_Registro.Id = Eventos_Idiomas.IdRegistro
END
GO

ALTER PROCEDURE [dbo].[Fabricante_ObtenerPorFiltros](@RegistroInicial int = NULL, @RegistroFinal int = NULL, @ColumnaOrden nvarchar(50) = 'Id', @TipoOrden smallint = 1, @IdDesde as int, @IdHasta as int, @Nombre as nvarchar(50), @Codigo as varchar(50), @Cultura as varchar(5), @IdMarca as char(3)) AS
BEGIN
	--declare @RegistroInicial int = 1
	--declare @RegistroFinal int = 50
	--declare @ColumnaOrden nvarchar(50) = 'Id'
	--declare @TipoOrden smallint = 0
	--declare @IdDesde as int, @IdHasta as int = null
	--declare @Nombre as nvarchar(50) = null
	--declare @Codigo as varchar(50) = null
	--declare @Cultura as varchar(5) = null
	--declare @IdMarca as char(3) = null

	;WITH DATOS AS (
		SELECT ROW_NUMBER() OVER ( 
			ORDER BY
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Id' THEN Fabricantes.Id END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Id' THEN Fabricantes.Id END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Nombre' THEN Fabricantes.Nombre END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Nombre' THEN Fabricantes.Nombre END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Codigo' THEN Fabricantes.Codigo END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Codigo' THEN Fabricantes.Codigo END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'IdMarca' THEN Fabricantes.IdMarca END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'IdMarca' THEN Fabricantes.IdMarca END DESC
			) AS NumeroRegistro,
			Fabricantes.Id AS Id, Fabricantes.Nombre AS Nombre, Fabricantes.Codigo AS Codigo, Fabricantes.IdMarca AS IdMarca, Marcas_Marca.Nombre AS Marca
		FROM Fabricantes
			INNER JOIN Marcas AS Marcas_Marca ON Marcas_Marca.Id = Fabricantes.IdMarca
		WHERE (@IdDesde IS NULL OR @IdHasta IS NULL OR (Fabricantes.Id >= @IdDesde AND Fabricantes.Id < DateAdd(d, 1, @IdHasta)))
		AND (@Nombre IS NULL OR Fabricantes.Nombre LIKE '%' + @Nombre + '%')
		AND (@Codigo IS NULL OR Fabricantes.Codigo LIKE '%' + @Codigo + '%')
		AND (@IdMarca IS NULL OR Fabricantes.IdMarca = @IdMarca)

	)
	SELECT Id, Nombre, Codigo, IdMarca, Marca
	FROM DATOS
	WHERE (@RegistroInicial IS NULL AND @RegistroFinal IS NULL OR (NumeroRegistro >= @RegistroInicial AND NumeroRegistro <= @RegistroFinal)) 
END
GO

ALTER PROCEDURE [dbo].[Fabricante_ObtenerCantidadPorFiltros](@IdDesde as int, @IdHasta as int, @Nombre as nvarchar(50), @Codigo as varchar(50), @Cultura as varchar(5), @IdMarca as char(3)) AS
BEGIN
	--declare @IdDesde as int, @IdHasta as int = null
	--declare @Nombre as nvarchar(50) = null
	--declare @Codigo as varchar(50) = null
	--declare @Cultura as varchar(5) = null
	--declare @IdMarca as char(3) = null

	SELECT COUNT(*)
	FROM Fabricantes
	WHERE (@IdDesde IS NULL OR @IdHasta IS NULL OR (Fabricantes.Id >= @IdDesde AND Fabricantes.Id < DateAdd(d, 1, @IdHasta)))
		AND (@Nombre IS NULL OR Fabricantes.Nombre LIKE '%' + @Nombre + '%')
		AND (@Codigo IS NULL OR Fabricantes.Codigo LIKE '%' + @Codigo + '%')
		AND (@IdMarca IS NULL OR Fabricantes.IdMarca = @IdMarca)

END
GO

ALTER PROCEDURE [dbo].[Fabricante_ObtenerComboPorIdMarca](@IdMarca as char(3), @Cultura as varchar(5)) AS
BEGIN
	--declare @IdMarca as char(3) = 'CCB'
		--declare @Cultura as varchar(5) = 'es-ES'
	
	SELECT Fabricantes.Id AS Id, COALESCE(Fabricantes_idiomas.Nombre, Fabricantes.Nombre) AS Nombre
	FROM Fabricantes
		LEFT OUTER JOIN Fabricantes_Idiomas ON Fabricantes_Idiomas.IdRegistro = Fabricantes.Id AND Fabricantes_Idiomas.Cultura = @Cultura
	WHERE Fabricantes.IdMarca = @IdMarca
	ORDER BY Nombre
END
GO


ALTER PROCEDURE [dbo].[Fabricante_ObtenerLista](@Lista as varchar(500)) AS
BEGIN
	--declare @Lista as varchar(500) = '1,2'

	SELECT Fabricantes.Id AS Id, Fabricantes.Nombre AS Nombre, Fabricantes.Codigo AS Codigo, Fabricantes.IdMarca AS IdMarca, Marcas_Marca.Nombre AS Marca
	FROM Fabricantes
		INNER JOIN dbo.fnArrayATabla(@Lista, ',') l ON l.number = Fabricantes.Id
			INNER JOIN Marcas AS Marcas_Marca ON Marcas_Marca.Id = Fabricantes.IdMarca
END
GO

ALTER PROCEDURE [dbo].[Fabricante_Idioma_ObtenerPorFiltros](@RegistroInicial int = NULL, @RegistroFinal int = NULL, @ColumnaOrden nvarchar(50) = 'Id', @TipoOrden smallint = 1, @IdDesde as int, @IdHasta as int, @IdRegistro as int, @Cultura as varchar(5), @Nombre as nvarchar(50)) AS
BEGIN
	--declare @RegistroInicial int = 1
	--declare @RegistroFinal int = 50
	--declare @ColumnaOrden nvarchar(50) = 'Id'
	--declare @TipoOrden smallint = 0
	--declare @IdDesde as int, @IdHasta as int = null
	--declare @IdRegistro as int = null
	--declare @Cultura as varchar(5) = null
	--declare @Nombre as nvarchar(50) = null

	;WITH DATOS AS (
		SELECT ROW_NUMBER() OVER ( 
			ORDER BY
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Id' THEN Fabricantes_Idiomas.Id END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Id' THEN Fabricantes_Idiomas.Id END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'IdRegistro' THEN Fabricantes_Idiomas.IdRegistro END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'IdRegistro' THEN Fabricantes_Idiomas.IdRegistro END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Cultura' THEN Fabricantes_Idiomas.Cultura END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Cultura' THEN Fabricantes_Idiomas.Cultura END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Nombre' THEN Fabricantes_Idiomas.Nombre END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Nombre' THEN Fabricantes_Idiomas.Nombre END DESC
			) AS NumeroRegistro,
			Fabricantes_Idiomas.Id AS Id, Fabricantes_Idiomas.IdRegistro AS IdRegistro, Fabricantes_Registro.Nombre AS Registro, Fabricantes_Idiomas.Cultura AS Cultura, Fabricantes_Idiomas.Nombre AS Nombre
		FROM Fabricantes_Idiomas
			INNER JOIN Fabricantes AS Fabricantes_Registro ON Fabricantes_Registro.Id = Fabricantes_Idiomas.IdRegistro
		WHERE (@IdDesde IS NULL OR @IdHasta IS NULL OR (Fabricantes_Idiomas.Id >= @IdDesde AND Fabricantes_Idiomas.Id < DateAdd(d, 1, @IdHasta)))
		AND (@IdRegistro IS NULL OR Fabricantes_Idiomas.IdRegistro = @IdRegistro)
		AND (@Cultura IS NULL OR Fabricantes_Idiomas.Cultura = @Cultura)
		AND (@Nombre IS NULL OR Fabricantes_Idiomas.Nombre LIKE '%' + @Nombre + '%')

	)
	SELECT Id, IdRegistro, Registro, Cultura, Nombre
	FROM DATOS
	WHERE (@RegistroInicial IS NULL AND @RegistroFinal IS NULL OR (NumeroRegistro >= @RegistroInicial AND NumeroRegistro <= @RegistroFinal)) 
END
GO

ALTER PROCEDURE [dbo].[Fabricante_Idioma_ObtenerCantidadPorFiltros](@IdDesde as int, @IdHasta as int, @IdRegistro as int, @Cultura as varchar(5), @Nombre as nvarchar(50)) AS
BEGIN
	--declare @IdDesde as int, @IdHasta as int = null
	--declare @IdRegistro as int = null
	--declare @Cultura as varchar(5) = null
	--declare @Nombre as nvarchar(50) = null

	SELECT COUNT(*)
	FROM Fabricantes_Idiomas
	WHERE (@IdDesde IS NULL OR @IdHasta IS NULL OR (Fabricantes_Idiomas.Id >= @IdDesde AND Fabricantes_Idiomas.Id < DateAdd(d, 1, @IdHasta)))
		AND (@IdRegistro IS NULL OR Fabricantes_Idiomas.IdRegistro = @IdRegistro)
		AND (@Cultura IS NULL OR Fabricantes_Idiomas.Cultura = @Cultura)
		AND (@Nombre IS NULL OR Fabricantes_Idiomas.Nombre LIKE '%' + @Nombre + '%')

END
GO

ALTER PROCEDURE [dbo].[Fabricante_Idioma_ObtenerCombo] AS
BEGIN
	SELECT Fabricantes_Idiomas.Id AS Id, Fabricantes_Idiomas.Nombre AS Nombre
	FROM Fabricantes_Idiomas
	ORDER BY Nombre
END
GO


ALTER PROCEDURE [dbo].[Fabricante_Idioma_ObtenerLista](@Lista as varchar(500)) AS
BEGIN
	--declare @Lista as varchar(500) = '1,2'

	SELECT Fabricantes_Idiomas.Id AS Id, Fabricantes_Idiomas.IdRegistro AS IdRegistro, Fabricantes_Registro.Nombre AS Registro, Fabricantes_Idiomas.Cultura AS Cultura, Fabricantes_Idiomas.Nombre AS Nombre
	FROM Fabricantes_Idiomas
		INNER JOIN dbo.fnArrayATabla(@Lista, ',') l ON l.number = Fabricantes_Idiomas.Id
			INNER JOIN Fabricantes AS Fabricantes_Registro ON Fabricantes_Registro.Id = Fabricantes_Idiomas.IdRegistro
END
GO

ALTER PROCEDURE [dbo].[Foto_ObtenerPorFiltros](@RegistroInicial int = NULL, @RegistroFinal int = NULL, @ColumnaOrden nvarchar(50) = 'Id', @TipoOrden smallint = 1, @IdDesde as int, @IdHasta as int, @OrdenDesde as smallint, @OrdenHasta as smallint, @IdCategoria as int, @Activa as bit, @Nombre as nvarchar(750), @Descripcion as nvarchar(max), @NombreArchivoImagen as nvarchar(150), @FechaAltaDesde as datetime, @FechaAltaHasta as datetime, @FechaUltimaModificacionDesde as datetime, @FechaUltimaModificacionHasta as datetime, @Cultura as varchar(5), @IdMarca as char(3)) AS
BEGIN
	--declare @RegistroInicial int = 1
	--declare @RegistroFinal int = 50
	--declare @ColumnaOrden nvarchar(50) = 'Id'
	--declare @TipoOrden smallint = 0
	--declare @IdDesde as int, @IdHasta as int = null
	--declare @OrdenDesde as smallint, @OrdenHasta as smallint = null
	--declare @IdCategoria as int = null
	--declare @Activa as bit = null
	--declare @Nombre as nvarchar(750) = null
	--declare @Descripcion as nvarchar(max) = null
	--declare @NombreArchivoImagen as nvarchar(150) = null
	--declare @FechaAltaDesde as datetime, @FechaAltaHasta as datetime = null
	--declare @FechaUltimaModificacionDesde as datetime, @FechaUltimaModificacionHasta as datetime = null
	--declare @Cultura as varchar(5) = null
	--declare @IdMarca as char(3) = null

	;WITH DATOS AS (
		SELECT ROW_NUMBER() OVER ( 
			ORDER BY
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Id' THEN Fotos.Id END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Id' THEN Fotos.Id END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'FechaAlta' THEN Fotos.FechaAlta END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'FechaAlta' THEN Fotos.FechaAlta END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'FechaUltimaModificacion' THEN Fotos.FechaUltimaModificacion END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'FechaUltimaModificacion' THEN Fotos.FechaUltimaModificacion END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'NombreArchivoImagen' THEN Fotos.NombreArchivoImagen END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'NombreArchivoImagen' THEN Fotos.NombreArchivoImagen END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Orden' THEN Fotos.Orden END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Orden' THEN Fotos.Orden END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Activa' THEN Fotos.Activa END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Activa' THEN Fotos.Activa END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'IdCategoria' THEN Fotos.IdCategoria END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'IdCategoria' THEN Fotos.IdCategoria END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Nombre' THEN Fotos.Nombre END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Nombre' THEN Fotos.Nombre END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Descripcion' THEN Fotos.Descripcion END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Descripcion' THEN Fotos.Descripcion END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'IdMarca' THEN Fotos.IdMarca END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'IdMarca' THEN Fotos.IdMarca END DESC
			) AS NumeroRegistro,
			Fotos.Id AS Id, Fotos.FechaAlta AS FechaAlta, Fotos.FechaUltimaModificacion AS FechaUltimaModificacion, Fotos.NombreArchivoImagen AS NombreArchivoImagen, Fotos.Orden AS Orden, Fotos.Activa AS Activa, Fotos.IdCategoria AS IdCategoria, CategoriasFotos_Categoria.Nombre AS Categoria, Fotos.Nombre AS Nombre, Fotos.Descripcion AS Descripcion, Fotos.IdMarca AS IdMarca, Marcas_Marca.Nombre AS Marca
		FROM Fotos
			INNER JOIN CategoriasFotos AS CategoriasFotos_Categoria ON CategoriasFotos_Categoria.Id = Fotos.IdCategoria
			INNER JOIN Marcas AS Marcas_Marca ON Marcas_Marca.Id = Fotos.IdMarca
		WHERE (@IdDesde IS NULL OR @IdHasta IS NULL OR (Fotos.Id >= @IdDesde AND Fotos.Id < DateAdd(d, 1, @IdHasta)))
		AND (@OrdenDesde IS NULL OR @OrdenHasta IS NULL OR (Fotos.Orden >= @OrdenDesde AND Fotos.Orden < DateAdd(d, 1, @OrdenHasta)))
		AND (@IdCategoria IS NULL OR Fotos.IdCategoria = @IdCategoria)
		AND (@Activa IS NULL OR Fotos.Activa = @Activa)
		AND (@Nombre IS NULL OR Fotos.Nombre LIKE '%' + @Nombre + '%')
		AND (@Descripcion IS NULL OR Fotos.Descripcion LIKE '%' + @Descripcion + '%')
		AND (@NombreArchivoImagen IS NULL OR Fotos.NombreArchivoImagen LIKE '%' + @NombreArchivoImagen + '%')
		AND (@FechaAltaDesde IS NULL OR @FechaAltaHasta IS NULL OR (Fotos.FechaAlta >= @FechaAltaDesde AND Fotos.FechaAlta < DateAdd(d, 1, @FechaAltaHasta)))
		AND (@FechaUltimaModificacionDesde IS NULL OR @FechaUltimaModificacionHasta IS NULL OR (Fotos.FechaUltimaModificacion >= @FechaUltimaModificacionDesde AND Fotos.FechaUltimaModificacion < DateAdd(d, 1, @FechaUltimaModificacionHasta)))
		AND (@IdMarca IS NULL OR Fotos.IdMarca = @IdMarca)

	)
	SELECT Id, FechaAlta, FechaUltimaModificacion, NombreArchivoImagen, Orden, Activa, IdCategoria, Categoria, Nombre, Descripcion, IdMarca, Marca
	FROM DATOS
	WHERE (@RegistroInicial IS NULL AND @RegistroFinal IS NULL OR (NumeroRegistro >= @RegistroInicial AND NumeroRegistro <= @RegistroFinal)) 
END
GO

ALTER PROCEDURE [dbo].[Foto_ObtenerCantidadPorFiltros](@IdDesde as int, @IdHasta as int, @OrdenDesde as smallint, @OrdenHasta as smallint, @IdCategoria as int, @Activa as bit, @Nombre as nvarchar(750), @Descripcion as nvarchar(max), @NombreArchivoImagen as nvarchar(150), @FechaAltaDesde as datetime, @FechaAltaHasta as datetime, @FechaUltimaModificacionDesde as datetime, @FechaUltimaModificacionHasta as datetime, @Cultura as varchar(5), @IdMarca as char(3)) AS
BEGIN
	--declare @IdDesde as int, @IdHasta as int = null
	--declare @OrdenDesde as smallint, @OrdenHasta as smallint = null
	--declare @IdCategoria as int = null
	--declare @Activa as bit = null
	--declare @Nombre as nvarchar(750) = null
	--declare @Descripcion as nvarchar(max) = null
	--declare @NombreArchivoImagen as nvarchar(150) = null
	--declare @FechaAltaDesde as datetime, @FechaAltaHasta as datetime = null
	--declare @FechaUltimaModificacionDesde as datetime, @FechaUltimaModificacionHasta as datetime = null
	--declare @Cultura as varchar(5) = null
	--declare @IdMarca as char(3) = null

	SELECT COUNT(*)
	FROM Fotos
	WHERE (@IdDesde IS NULL OR @IdHasta IS NULL OR (Fotos.Id >= @IdDesde AND Fotos.Id < DateAdd(d, 1, @IdHasta)))
		AND (@OrdenDesde IS NULL OR @OrdenHasta IS NULL OR (Fotos.Orden >= @OrdenDesde AND Fotos.Orden < DateAdd(d, 1, @OrdenHasta)))
		AND (@IdCategoria IS NULL OR Fotos.IdCategoria = @IdCategoria)
		AND (@Activa IS NULL OR Fotos.Activa = @Activa)
		AND (@Nombre IS NULL OR Fotos.Nombre LIKE '%' + @Nombre + '%')
		AND (@Descripcion IS NULL OR Fotos.Descripcion LIKE '%' + @Descripcion + '%')
		AND (@NombreArchivoImagen IS NULL OR Fotos.NombreArchivoImagen LIKE '%' + @NombreArchivoImagen + '%')
		AND (@FechaAltaDesde IS NULL OR @FechaAltaHasta IS NULL OR (Fotos.FechaAlta >= @FechaAltaDesde AND Fotos.FechaAlta < DateAdd(d, 1, @FechaAltaHasta)))
		AND (@FechaUltimaModificacionDesde IS NULL OR @FechaUltimaModificacionHasta IS NULL OR (Fotos.FechaUltimaModificacion >= @FechaUltimaModificacionDesde AND Fotos.FechaUltimaModificacion < DateAdd(d, 1, @FechaUltimaModificacionHasta)))
		AND (@IdMarca IS NULL OR Fotos.IdMarca = @IdMarca)

END
GO

ALTER PROCEDURE [dbo].[Foto_ObtenerComboPorIdMarca](@IdMarca as char(3), @Cultura as varchar(5)) AS
BEGIN
	--declare @IdMarca as char(3) = 'CCB'
		--declare @Cultura as varchar(5) = 'es-ES'
	
	SELECT Fotos.Id AS Id, COALESCE(Fotos_idiomas.Nombre, Fotos.Nombre) AS Nombre
	FROM Fotos
		LEFT OUTER JOIN Fotos_Idiomas ON Fotos_Idiomas.IdRegistro = Fotos.Id AND Fotos_Idiomas.Cultura = @Cultura
	WHERE Fotos.IdMarca = @IdMarca
	ORDER BY Nombre
END
GO


ALTER PROCEDURE [dbo].[Foto_ObtenerLista](@Lista as varchar(500)) AS
BEGIN
	--declare @Lista as varchar(500) = '1,2'

	SELECT Fotos.Id AS Id, Fotos.FechaAlta AS FechaAlta, Fotos.FechaUltimaModificacion AS FechaUltimaModificacion, Fotos.NombreArchivoImagen AS NombreArchivoImagen, Fotos.Orden AS Orden, Fotos.Activa AS Activa, Fotos.IdCategoria AS IdCategoria, CategoriasFotos_Categoria.Nombre AS Categoria, Fotos.Nombre AS Nombre, Fotos.Descripcion AS Descripcion, Fotos.IdMarca AS IdMarca, Marcas_Marca.Nombre AS Marca
	FROM Fotos
		INNER JOIN dbo.fnArrayATabla(@Lista, ',') l ON l.number = Fotos.Id
			INNER JOIN CategoriasFotos AS CategoriasFotos_Categoria ON CategoriasFotos_Categoria.Id = Fotos.IdCategoria
			INNER JOIN Marcas AS Marcas_Marca ON Marcas_Marca.Id = Fotos.IdMarca
END
GO

ALTER PROCEDURE [dbo].[Foto_Idioma_ObtenerPorFiltros](@RegistroInicial int = NULL, @RegistroFinal int = NULL, @ColumnaOrden nvarchar(50) = 'Id', @TipoOrden smallint = 1, @IdDesde as int, @IdHasta as int, @IdRegistro as int, @Cultura as varchar(5), @Nombre as nvarchar(750), @Descripcion as nvarchar(max)) AS
BEGIN
	--declare @RegistroInicial int = 1
	--declare @RegistroFinal int = 50
	--declare @ColumnaOrden nvarchar(50) = 'Id'
	--declare @TipoOrden smallint = 0
	--declare @IdDesde as int, @IdHasta as int = null
	--declare @IdRegistro as int = null
	--declare @Cultura as varchar(5) = null
	--declare @Nombre as nvarchar(750) = null
	--declare @Descripcion as nvarchar(max) = null

	;WITH DATOS AS (
		SELECT ROW_NUMBER() OVER ( 
			ORDER BY
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Id' THEN Fotos_Idiomas.Id END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Id' THEN Fotos_Idiomas.Id END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'IdRegistro' THEN Fotos_Idiomas.IdRegistro END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'IdRegistro' THEN Fotos_Idiomas.IdRegistro END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Cultura' THEN Fotos_Idiomas.Cultura END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Cultura' THEN Fotos_Idiomas.Cultura END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Nombre' THEN Fotos_Idiomas.Nombre END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Nombre' THEN Fotos_Idiomas.Nombre END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Descripcion' THEN Fotos_Idiomas.Descripcion END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Descripcion' THEN Fotos_Idiomas.Descripcion END DESC
			) AS NumeroRegistro,
			Fotos_Idiomas.Id AS Id, Fotos_Idiomas.IdRegistro AS IdRegistro, Fotos_Registro.Nombre AS Registro, Fotos_Idiomas.Cultura AS Cultura, Fotos_Idiomas.Nombre AS Nombre, Fotos_Idiomas.Descripcion AS Descripcion
		FROM Fotos_Idiomas
			INNER JOIN Fotos AS Fotos_Registro ON Fotos_Registro.Id = Fotos_Idiomas.IdRegistro
		WHERE (@IdDesde IS NULL OR @IdHasta IS NULL OR (Fotos_Idiomas.Id >= @IdDesde AND Fotos_Idiomas.Id < DateAdd(d, 1, @IdHasta)))
		AND (@IdRegistro IS NULL OR Fotos_Idiomas.IdRegistro = @IdRegistro)
		AND (@Cultura IS NULL OR Fotos_Idiomas.Cultura = @Cultura)
		AND (@Nombre IS NULL OR Fotos_Idiomas.Nombre LIKE '%' + @Nombre + '%')
		AND (@Descripcion IS NULL OR Fotos_Idiomas.Descripcion LIKE '%' + @Descripcion + '%')

	)
	SELECT Id, IdRegistro, Registro, Cultura, Nombre, Descripcion
	FROM DATOS
	WHERE (@RegistroInicial IS NULL AND @RegistroFinal IS NULL OR (NumeroRegistro >= @RegistroInicial AND NumeroRegistro <= @RegistroFinal)) 
END
GO

ALTER PROCEDURE [dbo].[Foto_Idioma_ObtenerCantidadPorFiltros](@IdDesde as int, @IdHasta as int, @IdRegistro as int, @Cultura as varchar(5), @Nombre as nvarchar(750), @Descripcion as nvarchar(max)) AS
BEGIN
	--declare @IdDesde as int, @IdHasta as int = null
	--declare @IdRegistro as int = null
	--declare @Cultura as varchar(5) = null
	--declare @Nombre as nvarchar(750) = null
	--declare @Descripcion as nvarchar(max) = null

	SELECT COUNT(*)
	FROM Fotos_Idiomas
	WHERE (@IdDesde IS NULL OR @IdHasta IS NULL OR (Fotos_Idiomas.Id >= @IdDesde AND Fotos_Idiomas.Id < DateAdd(d, 1, @IdHasta)))
		AND (@IdRegistro IS NULL OR Fotos_Idiomas.IdRegistro = @IdRegistro)
		AND (@Cultura IS NULL OR Fotos_Idiomas.Cultura = @Cultura)
		AND (@Nombre IS NULL OR Fotos_Idiomas.Nombre LIKE '%' + @Nombre + '%')
		AND (@Descripcion IS NULL OR Fotos_Idiomas.Descripcion LIKE '%' + @Descripcion + '%')

END
GO

ALTER PROCEDURE [dbo].[Foto_Idioma_ObtenerCombo] AS
BEGIN
	SELECT Fotos_Idiomas.Id AS Id, Fotos_Idiomas.Nombre AS Nombre
	FROM Fotos_Idiomas
	ORDER BY Nombre
END
GO


ALTER PROCEDURE [dbo].[Foto_Idioma_ObtenerLista](@Lista as varchar(500)) AS
BEGIN
	--declare @Lista as varchar(500) = '1,2'

	SELECT Fotos_Idiomas.Id AS Id, Fotos_Idiomas.IdRegistro AS IdRegistro, Fotos_Registro.Nombre AS Registro, Fotos_Idiomas.Cultura AS Cultura, Fotos_Idiomas.Nombre AS Nombre, Fotos_Idiomas.Descripcion AS Descripcion
	FROM Fotos_Idiomas
		INNER JOIN dbo.fnArrayATabla(@Lista, ',') l ON l.number = Fotos_Idiomas.Id
			INNER JOIN Fotos AS Fotos_Registro ON Fotos_Registro.Id = Fotos_Idiomas.IdRegistro
END
GO

ALTER PROCEDURE [dbo].[Marca_ObtenerPorFiltros](@RegistroInicial int = NULL, @RegistroFinal int = NULL, @ColumnaOrden nvarchar(50) = 'Id', @TipoOrden smallint = 1, @Id as char(3), @Nombre as nvarchar(50)) AS
BEGIN
	--declare @RegistroInicial int = 1
	--declare @RegistroFinal int = 50
	--declare @ColumnaOrden nvarchar(50) = 'Id'
	--declare @TipoOrden smallint = 0
	--declare @Id as char(3) = null
	--declare @Nombre as nvarchar(50) = null

	;WITH DATOS AS (
		SELECT ROW_NUMBER() OVER ( 
			ORDER BY
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Id' THEN Marcas.Id END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Id' THEN Marcas.Id END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Nombre' THEN Marcas.Nombre END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Nombre' THEN Marcas.Nombre END DESC
			) AS NumeroRegistro,
			Marcas.Id AS Id, Marcas.Nombre AS Nombre
		FROM Marcas
		WHERE (@Id IS NULL OR Marcas.Id = @Id)
		AND (@Nombre IS NULL OR Marcas.Nombre LIKE '%' + @Nombre + '%')

	)
	SELECT Id, Nombre
	FROM DATOS
	WHERE (@RegistroInicial IS NULL AND @RegistroFinal IS NULL OR (NumeroRegistro >= @RegistroInicial AND NumeroRegistro <= @RegistroFinal)) 
END
GO

ALTER PROCEDURE [dbo].[Marca_ObtenerCantidadPorFiltros](@Id as char(3), @Nombre as nvarchar(50)) AS
BEGIN
	--declare @Id as char(3) = null
	--declare @Nombre as nvarchar(50) = null

	SELECT COUNT(*)
	FROM Marcas
	WHERE (@Id IS NULL OR Marcas.Id = @Id)
		AND (@Nombre IS NULL OR Marcas.Nombre LIKE '%' + @Nombre + '%')

END
GO

ALTER PROCEDURE [dbo].[Marca_ObtenerCombo] AS
BEGIN
	SELECT Marcas.Id AS Id, Marcas.Nombre AS Nombre
	FROM Marcas
	ORDER BY Nombre
END
GO


ALTER PROCEDURE [dbo].[Marca_ObtenerLista](@Lista as varchar(500)) AS
BEGIN
	--declare @Lista as varchar(500) = '1,2'

	SELECT Marcas.Id AS Id, Marcas.Nombre AS Nombre
	FROM Marcas
		INNER JOIN dbo.fnArrayATabla(@Lista, ',') l ON l.number = Marcas.Id
END
GO

ALTER PROCEDURE [dbo].[SolicitudContacto_ObtenerPorFiltros](@RegistroInicial int = NULL, @RegistroFinal int = NULL, @ColumnaOrden nvarchar(50) = 'Id', @TipoOrden smallint = 1, @IdDesde as int, @IdHasta as int, @Nombre as nvarchar(150), @CorreoElectronico as nvarchar(150), @Asunto as nvarchar(150), @Contenido as nvarchar(max), @FechaAltaDesde as datetime, @FechaAltaHasta as datetime, @FechaUltimaModificacionDesde as datetime, @FechaUltimaModificacionHasta as datetime, @IdMarca as char(3)) AS
BEGIN
	--declare @RegistroInicial int = 1
	--declare @RegistroFinal int = 50
	--declare @ColumnaOrden nvarchar(50) = 'Id'
	--declare @TipoOrden smallint = 0
	--declare @IdDesde as int, @IdHasta as int = null
	--declare @Nombre as nvarchar(150) = null
	--declare @CorreoElectronico as nvarchar(150) = null
	--declare @Asunto as nvarchar(150) = null
	--declare @Contenido as nvarchar(max) = null
	--declare @FechaAltaDesde as datetime, @FechaAltaHasta as datetime = null
	--declare @FechaUltimaModificacionDesde as datetime, @FechaUltimaModificacionHasta as datetime = null
	--declare @IdMarca as char(3) = null

	;WITH DATOS AS (
		SELECT ROW_NUMBER() OVER ( 
			ORDER BY
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Id' THEN SolicitudesContacto.Id END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Id' THEN SolicitudesContacto.Id END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Nombre' THEN SolicitudesContacto.Nombre END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Nombre' THEN SolicitudesContacto.Nombre END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'CorreoElectronico' THEN SolicitudesContacto.CorreoElectronico END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'CorreoElectronico' THEN SolicitudesContacto.CorreoElectronico END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Asunto' THEN SolicitudesContacto.Asunto END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Asunto' THEN SolicitudesContacto.Asunto END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Contenido' THEN SolicitudesContacto.Contenido END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Contenido' THEN SolicitudesContacto.Contenido END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'FechaAlta' THEN SolicitudesContacto.FechaAlta END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'FechaAlta' THEN SolicitudesContacto.FechaAlta END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'FechaUltimaModificacion' THEN SolicitudesContacto.FechaUltimaModificacion END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'FechaUltimaModificacion' THEN SolicitudesContacto.FechaUltimaModificacion END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'IdMarca' THEN SolicitudesContacto.IdMarca END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'IdMarca' THEN SolicitudesContacto.IdMarca END DESC
			) AS NumeroRegistro,
			SolicitudesContacto.Id AS Id, SolicitudesContacto.Nombre AS Nombre, SolicitudesContacto.CorreoElectronico AS CorreoElectronico, SolicitudesContacto.Asunto AS Asunto, SolicitudesContacto.Contenido AS Contenido, SolicitudesContacto.FechaAlta AS FechaAlta, SolicitudesContacto.FechaUltimaModificacion AS FechaUltimaModificacion, SolicitudesContacto.IdMarca AS IdMarca, Marcas_Marca.Nombre AS Marca
		FROM SolicitudesContacto
			INNER JOIN Marcas AS Marcas_Marca ON Marcas_Marca.Id = SolicitudesContacto.IdMarca
		WHERE (@IdDesde IS NULL OR @IdHasta IS NULL OR (SolicitudesContacto.Id >= @IdDesde AND SolicitudesContacto.Id < DateAdd(d, 1, @IdHasta)))
		AND (@Nombre IS NULL OR SolicitudesContacto.Nombre LIKE '%' + @Nombre + '%')
		AND (@CorreoElectronico IS NULL OR SolicitudesContacto.CorreoElectronico LIKE '%' + @CorreoElectronico + '%')
		AND (@Asunto IS NULL OR SolicitudesContacto.Asunto LIKE '%' + @Asunto + '%')
		AND (@Contenido IS NULL OR SolicitudesContacto.Contenido LIKE '%' + @Contenido + '%')
		AND (@FechaAltaDesde IS NULL OR @FechaAltaHasta IS NULL OR (SolicitudesContacto.FechaAlta >= @FechaAltaDesde AND SolicitudesContacto.FechaAlta < DateAdd(d, 1, @FechaAltaHasta)))
		AND (@FechaUltimaModificacionDesde IS NULL OR @FechaUltimaModificacionHasta IS NULL OR (SolicitudesContacto.FechaUltimaModificacion >= @FechaUltimaModificacionDesde AND SolicitudesContacto.FechaUltimaModificacion < DateAdd(d, 1, @FechaUltimaModificacionHasta)))
		AND (@IdMarca IS NULL OR SolicitudesContacto.IdMarca = @IdMarca)

	)
	SELECT Id, Nombre, CorreoElectronico, Asunto, Contenido, FechaAlta, FechaUltimaModificacion, IdMarca, Marca
	FROM DATOS
	WHERE (@RegistroInicial IS NULL AND @RegistroFinal IS NULL OR (NumeroRegistro >= @RegistroInicial AND NumeroRegistro <= @RegistroFinal)) 
END
GO

ALTER PROCEDURE [dbo].[SolicitudContacto_ObtenerCantidadPorFiltros](@IdDesde as int, @IdHasta as int, @Nombre as nvarchar(150), @CorreoElectronico as nvarchar(150), @Asunto as nvarchar(150), @Contenido as nvarchar(max), @FechaAltaDesde as datetime, @FechaAltaHasta as datetime, @FechaUltimaModificacionDesde as datetime, @FechaUltimaModificacionHasta as datetime, @IdMarca as char(3)) AS
BEGIN
	--declare @IdDesde as int, @IdHasta as int = null
	--declare @Nombre as nvarchar(150) = null
	--declare @CorreoElectronico as nvarchar(150) = null
	--declare @Asunto as nvarchar(150) = null
	--declare @Contenido as nvarchar(max) = null
	--declare @FechaAltaDesde as datetime, @FechaAltaHasta as datetime = null
	--declare @FechaUltimaModificacionDesde as datetime, @FechaUltimaModificacionHasta as datetime = null
	--declare @IdMarca as char(3) = null

	SELECT COUNT(*)
	FROM SolicitudesContacto
	WHERE (@IdDesde IS NULL OR @IdHasta IS NULL OR (SolicitudesContacto.Id >= @IdDesde AND SolicitudesContacto.Id < DateAdd(d, 1, @IdHasta)))
		AND (@Nombre IS NULL OR SolicitudesContacto.Nombre LIKE '%' + @Nombre + '%')
		AND (@CorreoElectronico IS NULL OR SolicitudesContacto.CorreoElectronico LIKE '%' + @CorreoElectronico + '%')
		AND (@Asunto IS NULL OR SolicitudesContacto.Asunto LIKE '%' + @Asunto + '%')
		AND (@Contenido IS NULL OR SolicitudesContacto.Contenido LIKE '%' + @Contenido + '%')
		AND (@FechaAltaDesde IS NULL OR @FechaAltaHasta IS NULL OR (SolicitudesContacto.FechaAlta >= @FechaAltaDesde AND SolicitudesContacto.FechaAlta < DateAdd(d, 1, @FechaAltaHasta)))
		AND (@FechaUltimaModificacionDesde IS NULL OR @FechaUltimaModificacionHasta IS NULL OR (SolicitudesContacto.FechaUltimaModificacion >= @FechaUltimaModificacionDesde AND SolicitudesContacto.FechaUltimaModificacion < DateAdd(d, 1, @FechaUltimaModificacionHasta)))
		AND (@IdMarca IS NULL OR SolicitudesContacto.IdMarca = @IdMarca)

END
GO

ALTER PROCEDURE [dbo].[SolicitudContacto_ObtenerComboPorIdMarca](@IdMarca as char(3)) AS
BEGIN
	--declare @IdMarca as char(3) = 'CCB'
	
	SELECT SolicitudesContacto.Id AS Id, SolicitudesContacto.Nombre AS Nombre
	FROM SolicitudesContacto
	WHERE SolicitudesContacto.IdMarca = @IdMarca
	ORDER BY Nombre
END
GO


ALTER PROCEDURE [dbo].[SolicitudContacto_ObtenerLista](@Lista as varchar(500)) AS
BEGIN
	--declare @Lista as varchar(500) = '1,2'

	SELECT SolicitudesContacto.Id AS Id, SolicitudesContacto.Nombre AS Nombre, SolicitudesContacto.CorreoElectronico AS CorreoElectronico, SolicitudesContacto.Asunto AS Asunto, SolicitudesContacto.Contenido AS Contenido, SolicitudesContacto.FechaAlta AS FechaAlta, SolicitudesContacto.FechaUltimaModificacion AS FechaUltimaModificacion, SolicitudesContacto.IdMarca AS IdMarca, Marcas_Marca.Nombre AS Marca
	FROM SolicitudesContacto
		INNER JOIN dbo.fnArrayATabla(@Lista, ',') l ON l.number = SolicitudesContacto.Id
			INNER JOIN Marcas AS Marcas_Marca ON Marcas_Marca.Id = SolicitudesContacto.IdMarca
END
GO

ALTER PROCEDURE [dbo].[SubcategoriaCalendario_ObtenerPorFiltros](@RegistroInicial int = NULL, @RegistroFinal int = NULL, @ColumnaOrden nvarchar(50) = 'Id', @TipoOrden smallint = 1, @IdDesde as smallint, @IdHasta as smallint, @IdCategoria as smallint, @Nombre as nvarchar(50), @Codigo as varchar(50), @Cultura as varchar(5), @IdMarca as char(3)) AS
BEGIN
	--declare @RegistroInicial int = 1
	--declare @RegistroFinal int = 50
	--declare @ColumnaOrden nvarchar(50) = 'Id'
	--declare @TipoOrden smallint = 0
	--declare @IdDesde as smallint, @IdHasta as smallint = null
	--declare @IdCategoria as smallint = null
	--declare @Nombre as nvarchar(50) = null
	--declare @Codigo as varchar(50) = null
	--declare @Cultura as varchar(5) = null
	--declare @IdMarca as char(3) = null

	;WITH DATOS AS (
		SELECT ROW_NUMBER() OVER ( 
			ORDER BY
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Id' THEN SubcategoriasCalendario.Id END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Id' THEN SubcategoriasCalendario.Id END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Nombre' THEN SubcategoriasCalendario.Nombre END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Nombre' THEN SubcategoriasCalendario.Nombre END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Codigo' THEN SubcategoriasCalendario.Codigo END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Codigo' THEN SubcategoriasCalendario.Codigo END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'IdMarca' THEN SubcategoriasCalendario.IdMarca END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'IdMarca' THEN SubcategoriasCalendario.IdMarca END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'IdCategoria' THEN SubcategoriasCalendario.IdCategoria END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'IdCategoria' THEN SubcategoriasCalendario.IdCategoria END DESC
			) AS NumeroRegistro,
			SubcategoriasCalendario.Id AS Id, SubcategoriasCalendario.Nombre AS Nombre, SubcategoriasCalendario.Codigo AS Codigo, SubcategoriasCalendario.IdMarca AS IdMarca, Marcas_Marca.Nombre AS Marca, SubcategoriasCalendario.IdCategoria AS IdCategoria, CategoriasCalendario_Categoria.Nombre AS Categoria
		FROM SubcategoriasCalendario
			INNER JOIN Marcas AS Marcas_Marca ON Marcas_Marca.Id = SubcategoriasCalendario.IdMarca
			INNER JOIN CategoriasCalendario AS CategoriasCalendario_Categoria ON CategoriasCalendario_Categoria.Id = SubcategoriasCalendario.IdCategoria
		WHERE (@IdDesde IS NULL OR @IdHasta IS NULL OR (SubcategoriasCalendario.Id >= @IdDesde AND SubcategoriasCalendario.Id < DateAdd(d, 1, @IdHasta)))
		AND (@IdCategoria IS NULL OR SubcategoriasCalendario.IdCategoria = @IdCategoria)
		AND (@Nombre IS NULL OR SubcategoriasCalendario.Nombre LIKE '%' + @Nombre + '%')
		AND (@Codigo IS NULL OR SubcategoriasCalendario.Codigo LIKE '%' + @Codigo + '%')
		AND (@IdMarca IS NULL OR SubcategoriasCalendario.IdMarca = @IdMarca)

	)
	SELECT Id, Nombre, Codigo, IdMarca, Marca, IdCategoria, Categoria
	FROM DATOS
	WHERE (@RegistroInicial IS NULL AND @RegistroFinal IS NULL OR (NumeroRegistro >= @RegistroInicial AND NumeroRegistro <= @RegistroFinal)) 
END
GO

ALTER PROCEDURE [dbo].[SubcategoriaCalendario_ObtenerCantidadPorFiltros](@IdDesde as smallint, @IdHasta as smallint, @IdCategoria as smallint, @Nombre as nvarchar(50), @Codigo as varchar(50), @Cultura as varchar(5), @IdMarca as char(3)) AS
BEGIN
	--declare @IdDesde as smallint, @IdHasta as smallint = null
	--declare @IdCategoria as smallint = null
	--declare @Nombre as nvarchar(50) = null
	--declare @Codigo as varchar(50) = null
	--declare @Cultura as varchar(5) = null
	--declare @IdMarca as char(3) = null

	SELECT COUNT(*)
	FROM SubcategoriasCalendario
	WHERE (@IdDesde IS NULL OR @IdHasta IS NULL OR (SubcategoriasCalendario.Id >= @IdDesde AND SubcategoriasCalendario.Id < DateAdd(d, 1, @IdHasta)))
		AND (@IdCategoria IS NULL OR SubcategoriasCalendario.IdCategoria = @IdCategoria)
		AND (@Nombre IS NULL OR SubcategoriasCalendario.Nombre LIKE '%' + @Nombre + '%')
		AND (@Codigo IS NULL OR SubcategoriasCalendario.Codigo LIKE '%' + @Codigo + '%')
		AND (@IdMarca IS NULL OR SubcategoriasCalendario.IdMarca = @IdMarca)

END
GO

ALTER PROCEDURE [dbo].[SubcategoriaCalendario_ObtenerComboPorIdMarca](@IdMarca as char(3), @Cultura as varchar(5)) AS
BEGIN
	--declare @IdMarca as char(3) = 'CCB'
		--declare @Cultura as varchar(5) = 'es-ES'
	
	SELECT SubcategoriasCalendario.Id AS Id, COALESCE(SubcategoriasCalendario_idiomas.Nombre, SubcategoriasCalendario.Nombre) AS Nombre
	FROM SubcategoriasCalendario
		LEFT OUTER JOIN SubcategoriasCalendario_Idiomas ON SubcategoriasCalendario_Idiomas.IdRegistro = SubcategoriasCalendario.Id AND SubcategoriasCalendario_Idiomas.Cultura = @Cultura
	WHERE SubcategoriasCalendario.IdMarca = @IdMarca
	ORDER BY Nombre
END
GO


ALTER PROCEDURE [dbo].[SubcategoriaCalendario_ObtenerLista](@Lista as varchar(500)) AS
BEGIN
	--declare @Lista as varchar(500) = '1,2'

	SELECT SubcategoriasCalendario.Id AS Id, SubcategoriasCalendario.Nombre AS Nombre, SubcategoriasCalendario.Codigo AS Codigo, SubcategoriasCalendario.IdMarca AS IdMarca, Marcas_Marca.Nombre AS Marca, SubcategoriasCalendario.IdCategoria AS IdCategoria, CategoriasCalendario_Categoria.Nombre AS Categoria
	FROM SubcategoriasCalendario
		INNER JOIN dbo.fnArrayATabla(@Lista, ',') l ON l.number = SubcategoriasCalendario.Id
			INNER JOIN Marcas AS Marcas_Marca ON Marcas_Marca.Id = SubcategoriasCalendario.IdMarca
			INNER JOIN CategoriasCalendario AS CategoriasCalendario_Categoria ON CategoriasCalendario_Categoria.Id = SubcategoriasCalendario.IdCategoria
END
GO

ALTER PROCEDURE [dbo].[SubcategoriaCalendario_Idioma_ObtenerPorFiltros](@RegistroInicial int = NULL, @RegistroFinal int = NULL, @ColumnaOrden nvarchar(50) = 'Id', @TipoOrden smallint = 1, @IdDesde as int, @IdHasta as int, @IdRegistro as smallint, @Cultura as varchar(5), @Nombre as nvarchar(50)) AS
BEGIN
	--declare @RegistroInicial int = 1
	--declare @RegistroFinal int = 50
	--declare @ColumnaOrden nvarchar(50) = 'Id'
	--declare @TipoOrden smallint = 0
	--declare @IdDesde as int, @IdHasta as int = null
	--declare @IdRegistro as smallint = null
	--declare @Cultura as varchar(5) = null
	--declare @Nombre as nvarchar(50) = null

	;WITH DATOS AS (
		SELECT ROW_NUMBER() OVER ( 
			ORDER BY
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Id' THEN SubcategoriasCalendario_Idiomas.Id END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Id' THEN SubcategoriasCalendario_Idiomas.Id END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'IdRegistro' THEN SubcategoriasCalendario_Idiomas.IdRegistro END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'IdRegistro' THEN SubcategoriasCalendario_Idiomas.IdRegistro END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Cultura' THEN SubcategoriasCalendario_Idiomas.Cultura END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Cultura' THEN SubcategoriasCalendario_Idiomas.Cultura END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Nombre' THEN SubcategoriasCalendario_Idiomas.Nombre END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Nombre' THEN SubcategoriasCalendario_Idiomas.Nombre END DESC
			) AS NumeroRegistro,
			SubcategoriasCalendario_Idiomas.Id AS Id, SubcategoriasCalendario_Idiomas.IdRegistro AS IdRegistro, SubcategoriasCalendario_Registro.Nombre AS Registro, SubcategoriasCalendario_Idiomas.Cultura AS Cultura, SubcategoriasCalendario_Idiomas.Nombre AS Nombre
		FROM SubcategoriasCalendario_Idiomas
			INNER JOIN SubcategoriasCalendario AS SubcategoriasCalendario_Registro ON SubcategoriasCalendario_Registro.Id = SubcategoriasCalendario_Idiomas.IdRegistro
		WHERE (@IdDesde IS NULL OR @IdHasta IS NULL OR (SubcategoriasCalendario_Idiomas.Id >= @IdDesde AND SubcategoriasCalendario_Idiomas.Id < DateAdd(d, 1, @IdHasta)))
		AND (@IdRegistro IS NULL OR SubcategoriasCalendario_Idiomas.IdRegistro = @IdRegistro)
		AND (@Cultura IS NULL OR SubcategoriasCalendario_Idiomas.Cultura = @Cultura)
		AND (@Nombre IS NULL OR SubcategoriasCalendario_Idiomas.Nombre LIKE '%' + @Nombre + '%')

	)
	SELECT Id, IdRegistro, Registro, Cultura, Nombre
	FROM DATOS
	WHERE (@RegistroInicial IS NULL AND @RegistroFinal IS NULL OR (NumeroRegistro >= @RegistroInicial AND NumeroRegistro <= @RegistroFinal)) 
END
GO

ALTER PROCEDURE [dbo].[SubcategoriaCalendario_Idioma_ObtenerCantidadPorFiltros](@IdDesde as int, @IdHasta as int, @IdRegistro as smallint, @Cultura as varchar(5), @Nombre as nvarchar(50)) AS
BEGIN
	--declare @IdDesde as int, @IdHasta as int = null
	--declare @IdRegistro as smallint = null
	--declare @Cultura as varchar(5) = null
	--declare @Nombre as nvarchar(50) = null

	SELECT COUNT(*)
	FROM SubcategoriasCalendario_Idiomas
	WHERE (@IdDesde IS NULL OR @IdHasta IS NULL OR (SubcategoriasCalendario_Idiomas.Id >= @IdDesde AND SubcategoriasCalendario_Idiomas.Id < DateAdd(d, 1, @IdHasta)))
		AND (@IdRegistro IS NULL OR SubcategoriasCalendario_Idiomas.IdRegistro = @IdRegistro)
		AND (@Cultura IS NULL OR SubcategoriasCalendario_Idiomas.Cultura = @Cultura)
		AND (@Nombre IS NULL OR SubcategoriasCalendario_Idiomas.Nombre LIKE '%' + @Nombre + '%')

END
GO

ALTER PROCEDURE [dbo].[SubcategoriaCalendario_Idioma_ObtenerCombo] AS
BEGIN
	SELECT SubcategoriasCalendario_Idiomas.Id AS Id, SubcategoriasCalendario_Idiomas.Nombre AS Nombre
	FROM SubcategoriasCalendario_Idiomas
	ORDER BY Nombre
END
GO


ALTER PROCEDURE [dbo].[SubcategoriaCalendario_Idioma_ObtenerLista](@Lista as varchar(500)) AS
BEGIN
	--declare @Lista as varchar(500) = '1,2'

	SELECT SubcategoriasCalendario_Idiomas.Id AS Id, SubcategoriasCalendario_Idiomas.IdRegistro AS IdRegistro, SubcategoriasCalendario_Registro.Nombre AS Registro, SubcategoriasCalendario_Idiomas.Cultura AS Cultura, SubcategoriasCalendario_Idiomas.Nombre AS Nombre
	FROM SubcategoriasCalendario_Idiomas
		INNER JOIN dbo.fnArrayATabla(@Lista, ',') l ON l.number = SubcategoriasCalendario_Idiomas.Id
			INNER JOIN SubcategoriasCalendario AS SubcategoriasCalendario_Registro ON SubcategoriasCalendario_Registro.Id = SubcategoriasCalendario_Idiomas.IdRegistro
END
GO

ALTER PROCEDURE [dbo].[TipoColeccionCalendario_ObtenerPorFiltros](@RegistroInicial int = NULL, @RegistroFinal int = NULL, @ColumnaOrden nvarchar(50) = 'Id', @TipoOrden smallint = 1, @IdDesde as smallint, @IdHasta as smallint, @Nombre as nvarchar(50), @Codigo as varchar(50), @Cultura as varchar(5), @IdMarca as char(3)) AS
BEGIN
	--declare @RegistroInicial int = 1
	--declare @RegistroFinal int = 50
	--declare @ColumnaOrden nvarchar(50) = 'Id'
	--declare @TipoOrden smallint = 0
	--declare @IdDesde as smallint, @IdHasta as smallint = null
	--declare @Nombre as nvarchar(50) = null
	--declare @Codigo as varchar(50) = null
	--declare @Cultura as varchar(5) = null
	--declare @IdMarca as char(3) = null

	;WITH DATOS AS (
		SELECT ROW_NUMBER() OVER ( 
			ORDER BY
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Id' THEN TiposColeccionCalendario.Id END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Id' THEN TiposColeccionCalendario.Id END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Nombre' THEN TiposColeccionCalendario.Nombre END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Nombre' THEN TiposColeccionCalendario.Nombre END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Codigo' THEN TiposColeccionCalendario.Codigo END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Codigo' THEN TiposColeccionCalendario.Codigo END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'IdMarca' THEN TiposColeccionCalendario.IdMarca END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'IdMarca' THEN TiposColeccionCalendario.IdMarca END DESC
			) AS NumeroRegistro,
			TiposColeccionCalendario.Id AS Id, TiposColeccionCalendario.Nombre AS Nombre, TiposColeccionCalendario.Codigo AS Codigo, TiposColeccionCalendario.IdMarca AS IdMarca, Marcas_Marca.Nombre AS Marca
		FROM TiposColeccionCalendario
			INNER JOIN Marcas AS Marcas_Marca ON Marcas_Marca.Id = TiposColeccionCalendario.IdMarca
		WHERE (@IdDesde IS NULL OR @IdHasta IS NULL OR (TiposColeccionCalendario.Id >= @IdDesde AND TiposColeccionCalendario.Id < DateAdd(d, 1, @IdHasta)))
		AND (@Nombre IS NULL OR TiposColeccionCalendario.Nombre LIKE '%' + @Nombre + '%')
		AND (@Codigo IS NULL OR TiposColeccionCalendario.Codigo LIKE '%' + @Codigo + '%')
		AND (@IdMarca IS NULL OR TiposColeccionCalendario.IdMarca = @IdMarca)

	)
	SELECT Id, Nombre, Codigo, IdMarca, Marca
	FROM DATOS
	WHERE (@RegistroInicial IS NULL AND @RegistroFinal IS NULL OR (NumeroRegistro >= @RegistroInicial AND NumeroRegistro <= @RegistroFinal)) 
END
GO

ALTER PROCEDURE [dbo].[TipoColeccionCalendario_ObtenerCantidadPorFiltros](@IdDesde as smallint, @IdHasta as smallint, @Nombre as nvarchar(50), @Codigo as varchar(50), @Cultura as varchar(5), @IdMarca as char(3)) AS
BEGIN
	--declare @IdDesde as smallint, @IdHasta as smallint = null
	--declare @Nombre as nvarchar(50) = null
	--declare @Codigo as varchar(50) = null
	--declare @Cultura as varchar(5) = null
	--declare @IdMarca as char(3) = null

	SELECT COUNT(*)
	FROM TiposColeccionCalendario
	WHERE (@IdDesde IS NULL OR @IdHasta IS NULL OR (TiposColeccionCalendario.Id >= @IdDesde AND TiposColeccionCalendario.Id < DateAdd(d, 1, @IdHasta)))
		AND (@Nombre IS NULL OR TiposColeccionCalendario.Nombre LIKE '%' + @Nombre + '%')
		AND (@Codigo IS NULL OR TiposColeccionCalendario.Codigo LIKE '%' + @Codigo + '%')
		AND (@IdMarca IS NULL OR TiposColeccionCalendario.IdMarca = @IdMarca)

END
GO

ALTER PROCEDURE [dbo].[TipoColeccionCalendario_ObtenerComboPorIdMarca](@IdMarca as char(3), @Cultura as varchar(5)) AS
BEGIN
	--declare @IdMarca as char(3) = 'CCB'
		--declare @Cultura as varchar(5) = 'es-ES'
	
	SELECT TiposColeccionCalendario.Id AS Id, COALESCE(TiposColeccionCalendario_idiomas.Nombre, TiposColeccionCalendario.Nombre) AS Nombre
	FROM TiposColeccionCalendario
		LEFT OUTER JOIN TiposColeccionCalendario_Idiomas ON TiposColeccionCalendario_Idiomas.IdRegistro = TiposColeccionCalendario.Id AND TiposColeccionCalendario_Idiomas.Cultura = @Cultura
	WHERE TiposColeccionCalendario.IdMarca = @IdMarca
	ORDER BY Nombre
END
GO


ALTER PROCEDURE [dbo].[TipoColeccionCalendario_ObtenerLista](@Lista as varchar(500)) AS
BEGIN
	--declare @Lista as varchar(500) = '1,2'

	SELECT TiposColeccionCalendario.Id AS Id, TiposColeccionCalendario.Nombre AS Nombre, TiposColeccionCalendario.Codigo AS Codigo, TiposColeccionCalendario.IdMarca AS IdMarca, Marcas_Marca.Nombre AS Marca
	FROM TiposColeccionCalendario
		INNER JOIN dbo.fnArrayATabla(@Lista, ',') l ON l.number = TiposColeccionCalendario.Id
			INNER JOIN Marcas AS Marcas_Marca ON Marcas_Marca.Id = TiposColeccionCalendario.IdMarca
END
GO

ALTER PROCEDURE [dbo].[TipoColeccionCalendario_Idioma_ObtenerPorFiltros](@RegistroInicial int = NULL, @RegistroFinal int = NULL, @ColumnaOrden nvarchar(50) = 'Id', @TipoOrden smallint = 1, @IdDesde as int, @IdHasta as int, @IdRegistro as smallint, @Cultura as varchar(5), @Nombre as nvarchar(50)) AS
BEGIN
	--declare @RegistroInicial int = 1
	--declare @RegistroFinal int = 50
	--declare @ColumnaOrden nvarchar(50) = 'Id'
	--declare @TipoOrden smallint = 0
	--declare @IdDesde as int, @IdHasta as int = null
	--declare @IdRegistro as smallint = null
	--declare @Cultura as varchar(5) = null
	--declare @Nombre as nvarchar(50) = null

	;WITH DATOS AS (
		SELECT ROW_NUMBER() OVER ( 
			ORDER BY
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Id' THEN TiposColeccionCalendario_Idiomas.Id END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Id' THEN TiposColeccionCalendario_Idiomas.Id END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'IdRegistro' THEN TiposColeccionCalendario_Idiomas.IdRegistro END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'IdRegistro' THEN TiposColeccionCalendario_Idiomas.IdRegistro END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Cultura' THEN TiposColeccionCalendario_Idiomas.Cultura END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Cultura' THEN TiposColeccionCalendario_Idiomas.Cultura END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Nombre' THEN TiposColeccionCalendario_Idiomas.Nombre END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Nombre' THEN TiposColeccionCalendario_Idiomas.Nombre END DESC
			) AS NumeroRegistro,
			TiposColeccionCalendario_Idiomas.Id AS Id, TiposColeccionCalendario_Idiomas.IdRegistro AS IdRegistro, TiposColeccionCalendario_Registro.Nombre AS Registro, TiposColeccionCalendario_Idiomas.Cultura AS Cultura, TiposColeccionCalendario_Idiomas.Nombre AS Nombre
		FROM TiposColeccionCalendario_Idiomas
			INNER JOIN TiposColeccionCalendario AS TiposColeccionCalendario_Registro ON TiposColeccionCalendario_Registro.Id = TiposColeccionCalendario_Idiomas.IdRegistro
		WHERE (@IdDesde IS NULL OR @IdHasta IS NULL OR (TiposColeccionCalendario_Idiomas.Id >= @IdDesde AND TiposColeccionCalendario_Idiomas.Id < DateAdd(d, 1, @IdHasta)))
		AND (@IdRegistro IS NULL OR TiposColeccionCalendario_Idiomas.IdRegistro = @IdRegistro)
		AND (@Cultura IS NULL OR TiposColeccionCalendario_Idiomas.Cultura = @Cultura)
		AND (@Nombre IS NULL OR TiposColeccionCalendario_Idiomas.Nombre LIKE '%' + @Nombre + '%')

	)
	SELECT Id, IdRegistro, Registro, Cultura, Nombre
	FROM DATOS
	WHERE (@RegistroInicial IS NULL AND @RegistroFinal IS NULL OR (NumeroRegistro >= @RegistroInicial AND NumeroRegistro <= @RegistroFinal)) 
END
GO

ALTER PROCEDURE [dbo].[TipoColeccionCalendario_Idioma_ObtenerCantidadPorFiltros](@IdDesde as int, @IdHasta as int, @IdRegistro as smallint, @Cultura as varchar(5), @Nombre as nvarchar(50)) AS
BEGIN
	--declare @IdDesde as int, @IdHasta as int = null
	--declare @IdRegistro as smallint = null
	--declare @Cultura as varchar(5) = null
	--declare @Nombre as nvarchar(50) = null

	SELECT COUNT(*)
	FROM TiposColeccionCalendario_Idiomas
	WHERE (@IdDesde IS NULL OR @IdHasta IS NULL OR (TiposColeccionCalendario_Idiomas.Id >= @IdDesde AND TiposColeccionCalendario_Idiomas.Id < DateAdd(d, 1, @IdHasta)))
		AND (@IdRegistro IS NULL OR TiposColeccionCalendario_Idiomas.IdRegistro = @IdRegistro)
		AND (@Cultura IS NULL OR TiposColeccionCalendario_Idiomas.Cultura = @Cultura)
		AND (@Nombre IS NULL OR TiposColeccionCalendario_Idiomas.Nombre LIKE '%' + @Nombre + '%')

END
GO

ALTER PROCEDURE [dbo].[TipoColeccionCalendario_Idioma_ObtenerCombo] AS
BEGIN
	SELECT TiposColeccionCalendario_Idiomas.Id AS Id, TiposColeccionCalendario_Idiomas.Nombre AS Nombre
	FROM TiposColeccionCalendario_Idiomas
	ORDER BY Nombre
END
GO


ALTER PROCEDURE [dbo].[TipoColeccionCalendario_Idioma_ObtenerLista](@Lista as varchar(500)) AS
BEGIN
	--declare @Lista as varchar(500) = '1,2'

	SELECT TiposColeccionCalendario_Idiomas.Id AS Id, TiposColeccionCalendario_Idiomas.IdRegistro AS IdRegistro, TiposColeccionCalendario_Registro.Nombre AS Registro, TiposColeccionCalendario_Idiomas.Cultura AS Cultura, TiposColeccionCalendario_Idiomas.Nombre AS Nombre
	FROM TiposColeccionCalendario_Idiomas
		INNER JOIN dbo.fnArrayATabla(@Lista, ',') l ON l.number = TiposColeccionCalendario_Idiomas.Id
			INNER JOIN TiposColeccionCalendario AS TiposColeccionCalendario_Registro ON TiposColeccionCalendario_Registro.Id = TiposColeccionCalendario_Idiomas.IdRegistro
END
GO

ALTER PROCEDURE [dbo].[TipoEvento_ObtenerPorFiltros](@RegistroInicial int = NULL, @RegistroFinal int = NULL, @ColumnaOrden nvarchar(50) = 'Id', @TipoOrden smallint = 1, @IdDesde as smallint, @IdHasta as smallint, @Codigo as varchar(50), @OrdenDesde as smallint, @OrdenHasta as smallint, @Cultura as varchar(5), @IdMarca as char(3), @Nombre as nvarchar(50)) AS
BEGIN
	--declare @RegistroInicial int = 1
	--declare @RegistroFinal int = 50
	--declare @ColumnaOrden nvarchar(50) = 'Id'
	--declare @TipoOrden smallint = 0
	--declare @IdDesde as smallint, @IdHasta as smallint = null
	--declare @Codigo as varchar(50) = null
	--declare @OrdenDesde as smallint, @OrdenHasta as smallint = null
	--declare @Cultura as varchar(5) = null
	--declare @IdMarca as char(3) = null
	--declare @Nombre as nvarchar(50) = null

	;WITH DATOS AS (
		SELECT ROW_NUMBER() OVER ( 
			ORDER BY
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Id' THEN TiposEvento.Id END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Id' THEN TiposEvento.Id END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Nombre' THEN TiposEvento.Nombre END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Nombre' THEN TiposEvento.Nombre END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Codigo' THEN TiposEvento.Codigo END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Codigo' THEN TiposEvento.Codigo END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Orden' THEN TiposEvento.Orden END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Orden' THEN TiposEvento.Orden END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'IdMarca' THEN TiposEvento.IdMarca END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'IdMarca' THEN TiposEvento.IdMarca END DESC
			) AS NumeroRegistro,
			TiposEvento.Id AS Id, TiposEvento.Nombre AS Nombre, TiposEvento.Codigo AS Codigo, TiposEvento.Orden AS Orden, TiposEvento.IdMarca AS IdMarca, Marcas_Marca.Nombre AS Marca
		FROM TiposEvento
			INNER JOIN Marcas AS Marcas_Marca ON Marcas_Marca.Id = TiposEvento.IdMarca
		WHERE (@IdDesde IS NULL OR @IdHasta IS NULL OR (TiposEvento.Id >= @IdDesde AND TiposEvento.Id < DateAdd(d, 1, @IdHasta)))
		AND (@Codigo IS NULL OR TiposEvento.Codigo LIKE '%' + @Codigo + '%')
		AND (@OrdenDesde IS NULL OR @OrdenHasta IS NULL OR (TiposEvento.Orden >= @OrdenDesde AND TiposEvento.Orden < DateAdd(d, 1, @OrdenHasta)))
		AND (@IdMarca IS NULL OR TiposEvento.IdMarca = @IdMarca)
		AND (@Nombre IS NULL OR TiposEvento.Nombre LIKE '%' + @Nombre + '%')

	)
	SELECT Id, Nombre, Codigo, Orden, IdMarca, Marca
	FROM DATOS
	WHERE (@RegistroInicial IS NULL AND @RegistroFinal IS NULL OR (NumeroRegistro >= @RegistroInicial AND NumeroRegistro <= @RegistroFinal)) 
END
GO

ALTER PROCEDURE [dbo].[TipoEvento_ObtenerCantidadPorFiltros](@IdDesde as smallint, @IdHasta as smallint, @Codigo as varchar(50), @OrdenDesde as smallint, @OrdenHasta as smallint, @Cultura as varchar(5), @IdMarca as char(3), @Nombre as nvarchar(50)) AS
BEGIN
	--declare @IdDesde as smallint, @IdHasta as smallint = null
	--declare @Codigo as varchar(50) = null
	--declare @OrdenDesde as smallint, @OrdenHasta as smallint = null
	--declare @Cultura as varchar(5) = null
	--declare @IdMarca as char(3) = null
	--declare @Nombre as nvarchar(50) = null

	SELECT COUNT(*)
	FROM TiposEvento
	WHERE (@IdDesde IS NULL OR @IdHasta IS NULL OR (TiposEvento.Id >= @IdDesde AND TiposEvento.Id < DateAdd(d, 1, @IdHasta)))
		AND (@Codigo IS NULL OR TiposEvento.Codigo LIKE '%' + @Codigo + '%')
		AND (@OrdenDesde IS NULL OR @OrdenHasta IS NULL OR (TiposEvento.Orden >= @OrdenDesde AND TiposEvento.Orden < DateAdd(d, 1, @OrdenHasta)))
		AND (@IdMarca IS NULL OR TiposEvento.IdMarca = @IdMarca)
		AND (@Nombre IS NULL OR TiposEvento.Nombre LIKE '%' + @Nombre + '%')

END
GO

ALTER PROCEDURE [dbo].[TipoEvento_ObtenerComboPorIdMarca](@IdMarca as char(3), @Cultura as varchar(5)) AS
BEGIN
	--declare @IdMarca as char(3) = 'CCB'
		--declare @Cultura as varchar(5) = 'es-ES'
	
	SELECT TiposEvento.Id AS Id, COALESCE(TiposEvento_idiomas.Nombre, TiposEvento.Nombre) AS Nombre
	FROM TiposEvento
		LEFT OUTER JOIN TiposEvento_Idiomas ON TiposEvento_Idiomas.IdRegistro = TiposEvento.Id AND TiposEvento_Idiomas.Cultura = @Cultura
	WHERE TiposEvento.IdMarca = @IdMarca
	ORDER BY Nombre
END
GO


ALTER PROCEDURE [dbo].[TipoEvento_ObtenerLista](@Lista as varchar(500)) AS
BEGIN
	--declare @Lista as varchar(500) = '1,2'

	SELECT TiposEvento.Id AS Id, TiposEvento.Nombre AS Nombre, TiposEvento.Codigo AS Codigo, TiposEvento.Orden AS Orden, TiposEvento.IdMarca AS IdMarca, Marcas_Marca.Nombre AS Marca
	FROM TiposEvento
		INNER JOIN dbo.fnArrayATabla(@Lista, ',') l ON l.number = TiposEvento.Id
			INNER JOIN Marcas AS Marcas_Marca ON Marcas_Marca.Id = TiposEvento.IdMarca
END
GO

ALTER PROCEDURE [dbo].[TipoEvento_Idioma_ObtenerPorFiltros](@RegistroInicial int = NULL, @RegistroFinal int = NULL, @ColumnaOrden nvarchar(50) = 'Id', @TipoOrden smallint = 1, @IdDesde as smallint, @IdHasta as smallint, @IdRegistro as smallint, @Cultura as varchar(5), @Nombre as nvarchar(250)) AS
BEGIN
	--declare @RegistroInicial int = 1
	--declare @RegistroFinal int = 50
	--declare @ColumnaOrden nvarchar(50) = 'Id'
	--declare @TipoOrden smallint = 0
	--declare @IdDesde as smallint, @IdHasta as smallint = null
	--declare @IdRegistro as smallint = null
	--declare @Cultura as varchar(5) = null
	--declare @Nombre as nvarchar(250) = null

	;WITH DATOS AS (
		SELECT ROW_NUMBER() OVER ( 
			ORDER BY
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Id' THEN TiposEvento_Idiomas.Id END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Id' THEN TiposEvento_Idiomas.Id END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'IdRegistro' THEN TiposEvento_Idiomas.IdRegistro END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'IdRegistro' THEN TiposEvento_Idiomas.IdRegistro END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Cultura' THEN TiposEvento_Idiomas.Cultura END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Cultura' THEN TiposEvento_Idiomas.Cultura END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Nombre' THEN TiposEvento_Idiomas.Nombre END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Nombre' THEN TiposEvento_Idiomas.Nombre END DESC
			) AS NumeroRegistro,
			TiposEvento_Idiomas.Id AS Id, TiposEvento_Idiomas.IdRegistro AS IdRegistro, TiposEvento_Registro.Nombre AS Registro, TiposEvento_Idiomas.Cultura AS Cultura, TiposEvento_Idiomas.Nombre AS Nombre
		FROM TiposEvento_Idiomas
			INNER JOIN TiposEvento AS TiposEvento_Registro ON TiposEvento_Registro.Id = TiposEvento_Idiomas.IdRegistro
		WHERE (@IdDesde IS NULL OR @IdHasta IS NULL OR (TiposEvento_Idiomas.Id >= @IdDesde AND TiposEvento_Idiomas.Id < DateAdd(d, 1, @IdHasta)))
		AND (@IdRegistro IS NULL OR TiposEvento_Idiomas.IdRegistro = @IdRegistro)
		AND (@Cultura IS NULL OR TiposEvento_Idiomas.Cultura = @Cultura)
		AND (@Nombre IS NULL OR TiposEvento_Idiomas.Nombre LIKE '%' + @Nombre + '%')

	)
	SELECT Id, IdRegistro, Registro, Cultura, Nombre
	FROM DATOS
	WHERE (@RegistroInicial IS NULL AND @RegistroFinal IS NULL OR (NumeroRegistro >= @RegistroInicial AND NumeroRegistro <= @RegistroFinal)) 
END
GO

ALTER PROCEDURE [dbo].[TipoEvento_Idioma_ObtenerCantidadPorFiltros](@IdDesde as smallint, @IdHasta as smallint, @IdRegistro as smallint, @Cultura as varchar(5), @Nombre as nvarchar(250)) AS
BEGIN
	--declare @IdDesde as smallint, @IdHasta as smallint = null
	--declare @IdRegistro as smallint = null
	--declare @Cultura as varchar(5) = null
	--declare @Nombre as nvarchar(250) = null

	SELECT COUNT(*)
	FROM TiposEvento_Idiomas
	WHERE (@IdDesde IS NULL OR @IdHasta IS NULL OR (TiposEvento_Idiomas.Id >= @IdDesde AND TiposEvento_Idiomas.Id < DateAdd(d, 1, @IdHasta)))
		AND (@IdRegistro IS NULL OR TiposEvento_Idiomas.IdRegistro = @IdRegistro)
		AND (@Cultura IS NULL OR TiposEvento_Idiomas.Cultura = @Cultura)
		AND (@Nombre IS NULL OR TiposEvento_Idiomas.Nombre LIKE '%' + @Nombre + '%')

END
GO

ALTER PROCEDURE [dbo].[TipoEvento_Idioma_ObtenerCombo] AS
BEGIN
	SELECT TiposEvento_Idiomas.Id AS Id, TiposEvento_Idiomas.Nombre AS Nombre
	FROM TiposEvento_Idiomas
	ORDER BY Nombre
END
GO


ALTER PROCEDURE [dbo].[TipoEvento_Idioma_ObtenerLista](@Lista as varchar(500)) AS
BEGIN
	--declare @Lista as varchar(500) = '1,2'

	SELECT TiposEvento_Idiomas.Id AS Id, TiposEvento_Idiomas.IdRegistro AS IdRegistro, TiposEvento_Registro.Nombre AS Registro, TiposEvento_Idiomas.Cultura AS Cultura, TiposEvento_Idiomas.Nombre AS Nombre
	FROM TiposEvento_Idiomas
		INNER JOIN dbo.fnArrayATabla(@Lista, ',') l ON l.number = TiposEvento_Idiomas.Id
			INNER JOIN TiposEvento AS TiposEvento_Registro ON TiposEvento_Registro.Id = TiposEvento_Idiomas.IdRegistro
END
GO

ALTER PROCEDURE [dbo].[Usuario_ObtenerPorFiltros](@RegistroInicial int = NULL, @RegistroFinal int = NULL, @ColumnaOrden nvarchar(50) = 'Id', @TipoOrden smallint = 1, @IdDesde as int, @IdHasta as int, @Nombre as nvarchar(50), @PrimerApellido as nvarchar(50), @SegundoApellido as nvarchar(50), @NombreDeUsuario as nvarchar(150), @CorreoElectronico as nvarchar(150), @IdMarca as char(3)) AS
BEGIN
	--declare @RegistroInicial int = 1
	--declare @RegistroFinal int = 50
	--declare @ColumnaOrden nvarchar(50) = 'Id'
	--declare @TipoOrden smallint = 0
	--declare @IdDesde as int, @IdHasta as int = null
	--declare @Nombre as nvarchar(50) = null
	--declare @PrimerApellido as nvarchar(50) = null
	--declare @SegundoApellido as nvarchar(50) = null
	--declare @NombreDeUsuario as nvarchar(150) = null
	--declare @CorreoElectronico as nvarchar(150) = null
	--declare @IdMarca as char(3) = null

	;WITH DATOS AS (
		SELECT ROW_NUMBER() OVER ( 
			ORDER BY
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Id' THEN Usuarios.Id END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Id' THEN Usuarios.Id END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Nombre' THEN Usuarios.Nombre END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Nombre' THEN Usuarios.Nombre END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'PrimerApellido' THEN Usuarios.PrimerApellido END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'PrimerApellido' THEN Usuarios.PrimerApellido END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'SegundoApellido' THEN Usuarios.SegundoApellido END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'SegundoApellido' THEN Usuarios.SegundoApellido END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'NombreDeUsuario' THEN Usuarios.NombreDeUsuario END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'NombreDeUsuario' THEN Usuarios.NombreDeUsuario END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'CorreoElectronico' THEN Usuarios.CorreoElectronico END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'CorreoElectronico' THEN Usuarios.CorreoElectronico END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'IdMarca' THEN Usuarios.IdMarca END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'IdMarca' THEN Usuarios.IdMarca END DESC
			) AS NumeroRegistro,
			Usuarios.Id AS Id, Usuarios.Nombre AS Nombre, Usuarios.PrimerApellido AS PrimerApellido, Usuarios.SegundoApellido AS SegundoApellido, Usuarios.NombreDeUsuario AS NombreDeUsuario, Usuarios.CorreoElectronico AS CorreoElectronico, Usuarios.IdMarca AS IdMarca, Marcas_Marca.Nombre AS Marca
		FROM Usuarios
			INNER JOIN Marcas AS Marcas_Marca ON Marcas_Marca.Id = Usuarios.IdMarca
		WHERE (@IdDesde IS NULL OR @IdHasta IS NULL OR (Usuarios.Id >= @IdDesde AND Usuarios.Id < DateAdd(d, 1, @IdHasta)))
		AND (@Nombre IS NULL OR Usuarios.Nombre LIKE '%' + @Nombre + '%')
		AND (@PrimerApellido IS NULL OR Usuarios.PrimerApellido LIKE '%' + @PrimerApellido + '%')
		AND (@SegundoApellido IS NULL OR Usuarios.SegundoApellido LIKE '%' + @SegundoApellido + '%')
		AND (@NombreDeUsuario IS NULL OR Usuarios.NombreDeUsuario LIKE '%' + @NombreDeUsuario + '%')
		AND (@CorreoElectronico IS NULL OR Usuarios.CorreoElectronico LIKE '%' + @CorreoElectronico + '%')
		AND (@IdMarca IS NULL OR Usuarios.IdMarca = @IdMarca)

	)
	SELECT Id, Nombre, PrimerApellido, SegundoApellido, NombreDeUsuario, CorreoElectronico, IdMarca, Marca
	FROM DATOS
	WHERE (@RegistroInicial IS NULL AND @RegistroFinal IS NULL OR (NumeroRegistro >= @RegistroInicial AND NumeroRegistro <= @RegistroFinal)) 
END
GO

ALTER PROCEDURE [dbo].[Usuario_ObtenerCantidadPorFiltros](@IdDesde as int, @IdHasta as int, @Nombre as nvarchar(50), @PrimerApellido as nvarchar(50), @SegundoApellido as nvarchar(50), @NombreDeUsuario as nvarchar(150), @CorreoElectronico as nvarchar(150), @IdMarca as char(3)) AS
BEGIN
	--declare @IdDesde as int, @IdHasta as int = null
	--declare @Nombre as nvarchar(50) = null
	--declare @PrimerApellido as nvarchar(50) = null
	--declare @SegundoApellido as nvarchar(50) = null
	--declare @NombreDeUsuario as nvarchar(150) = null
	--declare @CorreoElectronico as nvarchar(150) = null
	--declare @IdMarca as char(3) = null

	SELECT COUNT(*)
	FROM Usuarios
	WHERE (@IdDesde IS NULL OR @IdHasta IS NULL OR (Usuarios.Id >= @IdDesde AND Usuarios.Id < DateAdd(d, 1, @IdHasta)))
		AND (@Nombre IS NULL OR Usuarios.Nombre LIKE '%' + @Nombre + '%')
		AND (@PrimerApellido IS NULL OR Usuarios.PrimerApellido LIKE '%' + @PrimerApellido + '%')
		AND (@SegundoApellido IS NULL OR Usuarios.SegundoApellido LIKE '%' + @SegundoApellido + '%')
		AND (@NombreDeUsuario IS NULL OR Usuarios.NombreDeUsuario LIKE '%' + @NombreDeUsuario + '%')
		AND (@CorreoElectronico IS NULL OR Usuarios.CorreoElectronico LIKE '%' + @CorreoElectronico + '%')
		AND (@IdMarca IS NULL OR Usuarios.IdMarca = @IdMarca)

END
GO

ALTER PROCEDURE [dbo].[Usuario_ObtenerComboPorIdMarca](@IdMarca as char(3)) AS
BEGIN
	--declare @IdMarca as char(3) = 'CCB'
	
	SELECT Usuarios.Id AS Id, Usuarios.Nombre AS Nombre
	FROM Usuarios
	WHERE Usuarios.IdMarca = @IdMarca
	ORDER BY Nombre
END
GO


ALTER PROCEDURE [dbo].[Usuario_ObtenerLista](@Lista as varchar(500)) AS
BEGIN
	--declare @Lista as varchar(500) = '1,2'

	SELECT Usuarios.Id AS Id, Usuarios.Nombre AS Nombre, Usuarios.PrimerApellido AS PrimerApellido, Usuarios.SegundoApellido AS SegundoApellido, Usuarios.NombreDeUsuario AS NombreDeUsuario, Usuarios.CorreoElectronico AS CorreoElectronico, Usuarios.IdMarca AS IdMarca, Marcas_Marca.Nombre AS Marca
	FROM Usuarios
		INNER JOIN dbo.fnArrayATabla(@Lista, ',') l ON l.number = Usuarios.Id
			INNER JOIN Marcas AS Marcas_Marca ON Marcas_Marca.Id = Usuarios.IdMarca
END
GO

ALTER PROCEDURE [dbo].[Video_ObtenerPorFiltros](@RegistroInicial int = NULL, @RegistroFinal int = NULL, @ColumnaOrden nvarchar(50) = 'Id', @TipoOrden smallint = 1, @IdDesde as int, @IdHasta as int, @Nombre as nvarchar(250), @Descripcion as nvarchar(1000), @Url as varchar(250), @FechaAltaDesde as datetime, @FechaAltaHasta as datetime, @FechaUltimaModificacionDesde as datetime, @FechaUltimaModificacionHasta as datetime, @Cultura as varchar(5), @IdMarca as char(3)) AS
BEGIN
	--declare @RegistroInicial int = 1
	--declare @RegistroFinal int = 50
	--declare @ColumnaOrden nvarchar(50) = 'Id'
	--declare @TipoOrden smallint = 0
	--declare @IdDesde as int, @IdHasta as int = null
	--declare @Nombre as nvarchar(250) = null
	--declare @Descripcion as nvarchar(1000) = null
	--declare @Url as varchar(250) = null
	--declare @FechaAltaDesde as datetime, @FechaAltaHasta as datetime = null
	--declare @FechaUltimaModificacionDesde as datetime, @FechaUltimaModificacionHasta as datetime = null
	--declare @Cultura as varchar(5) = null
	--declare @IdMarca as char(3) = null

	;WITH DATOS AS (
		SELECT ROW_NUMBER() OVER ( 
			ORDER BY
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Id' THEN Videos.Id END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Id' THEN Videos.Id END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'FechaAlta' THEN Videos.FechaAlta END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'FechaAlta' THEN Videos.FechaAlta END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'FechaUltimaModificacion' THEN Videos.FechaUltimaModificacion END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'FechaUltimaModificacion' THEN Videos.FechaUltimaModificacion END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Nombre' THEN Videos.Nombre END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Nombre' THEN Videos.Nombre END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Descripcion' THEN Videos.Descripcion END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Descripcion' THEN Videos.Descripcion END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Url' THEN Videos.Url END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Url' THEN Videos.Url END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'IdMarca' THEN Videos.IdMarca END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'IdMarca' THEN Videos.IdMarca END DESC
			) AS NumeroRegistro,
			Videos.Id AS Id, Videos.FechaAlta AS FechaAlta, Videos.FechaUltimaModificacion AS FechaUltimaModificacion, Videos.Nombre AS Nombre, Videos.Descripcion AS Descripcion, Videos.Url AS Url, Videos.IdMarca AS IdMarca, Marcas_Marca.Nombre AS Marca
		FROM Videos
			INNER JOIN Marcas AS Marcas_Marca ON Marcas_Marca.Id = Videos.IdMarca
		WHERE (@IdDesde IS NULL OR @IdHasta IS NULL OR (Videos.Id >= @IdDesde AND Videos.Id < DateAdd(d, 1, @IdHasta)))
		AND (@Nombre IS NULL OR Videos.Nombre LIKE '%' + @Nombre + '%')
		AND (@Descripcion IS NULL OR Videos.Descripcion LIKE '%' + @Descripcion + '%')
		AND (@Url IS NULL OR Videos.Url LIKE '%' + @Url + '%')
		AND (@FechaAltaDesde IS NULL OR @FechaAltaHasta IS NULL OR (Videos.FechaAlta >= @FechaAltaDesde AND Videos.FechaAlta < DateAdd(d, 1, @FechaAltaHasta)))
		AND (@FechaUltimaModificacionDesde IS NULL OR @FechaUltimaModificacionHasta IS NULL OR (Videos.FechaUltimaModificacion >= @FechaUltimaModificacionDesde AND Videos.FechaUltimaModificacion < DateAdd(d, 1, @FechaUltimaModificacionHasta)))
		AND (@IdMarca IS NULL OR Videos.IdMarca = @IdMarca)

	)
	SELECT Id, FechaAlta, FechaUltimaModificacion, Nombre, Descripcion, Url, IdMarca, Marca
	FROM DATOS
	WHERE (@RegistroInicial IS NULL AND @RegistroFinal IS NULL OR (NumeroRegistro >= @RegistroInicial AND NumeroRegistro <= @RegistroFinal)) 
END
GO

ALTER PROCEDURE [dbo].[Video_ObtenerCantidadPorFiltros](@IdDesde as int, @IdHasta as int, @Nombre as nvarchar(250), @Descripcion as nvarchar(1000), @Url as varchar(250), @FechaAltaDesde as datetime, @FechaAltaHasta as datetime, @FechaUltimaModificacionDesde as datetime, @FechaUltimaModificacionHasta as datetime, @Cultura as varchar(5), @IdMarca as char(3)) AS
BEGIN
	--declare @IdDesde as int, @IdHasta as int = null
	--declare @Nombre as nvarchar(250) = null
	--declare @Descripcion as nvarchar(1000) = null
	--declare @Url as varchar(250) = null
	--declare @FechaAltaDesde as datetime, @FechaAltaHasta as datetime = null
	--declare @FechaUltimaModificacionDesde as datetime, @FechaUltimaModificacionHasta as datetime = null
	--declare @Cultura as varchar(5) = null
	--declare @IdMarca as char(3) = null

	SELECT COUNT(*)
	FROM Videos
	WHERE (@IdDesde IS NULL OR @IdHasta IS NULL OR (Videos.Id >= @IdDesde AND Videos.Id < DateAdd(d, 1, @IdHasta)))
		AND (@Nombre IS NULL OR Videos.Nombre LIKE '%' + @Nombre + '%')
		AND (@Descripcion IS NULL OR Videos.Descripcion LIKE '%' + @Descripcion + '%')
		AND (@Url IS NULL OR Videos.Url LIKE '%' + @Url + '%')
		AND (@FechaAltaDesde IS NULL OR @FechaAltaHasta IS NULL OR (Videos.FechaAlta >= @FechaAltaDesde AND Videos.FechaAlta < DateAdd(d, 1, @FechaAltaHasta)))
		AND (@FechaUltimaModificacionDesde IS NULL OR @FechaUltimaModificacionHasta IS NULL OR (Videos.FechaUltimaModificacion >= @FechaUltimaModificacionDesde AND Videos.FechaUltimaModificacion < DateAdd(d, 1, @FechaUltimaModificacionHasta)))
		AND (@IdMarca IS NULL OR Videos.IdMarca = @IdMarca)

END
GO

ALTER PROCEDURE [dbo].[Video_ObtenerComboPorIdMarca](@IdMarca as char(3), @Cultura as varchar(5)) AS
BEGIN
	--declare @IdMarca as char(3) = 'CCB'
		--declare @Cultura as varchar(5) = 'es-ES'
	
	SELECT Videos.Id AS Id, COALESCE(Videos_idiomas.Nombre, Videos.Nombre) AS Nombre
	FROM Videos
		LEFT OUTER JOIN Videos_Idiomas ON Videos_Idiomas.IdRegistro = Videos.Id AND Videos_Idiomas.Cultura = @Cultura
	WHERE Videos.IdMarca = @IdMarca
	ORDER BY Nombre
END
GO


ALTER PROCEDURE [dbo].[Video_ObtenerLista](@Lista as varchar(500)) AS
BEGIN
	--declare @Lista as varchar(500) = '1,2'

	SELECT Videos.Id AS Id, Videos.FechaAlta AS FechaAlta, Videos.FechaUltimaModificacion AS FechaUltimaModificacion, Videos.Nombre AS Nombre, Videos.Descripcion AS Descripcion, Videos.Url AS Url, Videos.IdMarca AS IdMarca, Marcas_Marca.Nombre AS Marca
	FROM Videos
		INNER JOIN dbo.fnArrayATabla(@Lista, ',') l ON l.number = Videos.Id
			INNER JOIN Marcas AS Marcas_Marca ON Marcas_Marca.Id = Videos.IdMarca
END
GO

ALTER PROCEDURE [dbo].[Video_Idioma_ObtenerPorFiltros](@RegistroInicial int = NULL, @RegistroFinal int = NULL, @ColumnaOrden nvarchar(50) = 'Id', @TipoOrden smallint = 1, @IdDesde as int, @IdHasta as int, @IdRegistro as int, @Nombre as nvarchar(250), @Descripcion as nvarchar(1000), @Url as varchar(250), @Cultura as varchar(5)) AS
BEGIN
	--declare @RegistroInicial int = 1
	--declare @RegistroFinal int = 50
	--declare @ColumnaOrden nvarchar(50) = 'Id'
	--declare @TipoOrden smallint = 0
	--declare @IdDesde as int, @IdHasta as int = null
	--declare @IdRegistro as int = null
	--declare @Nombre as nvarchar(250) = null
	--declare @Descripcion as nvarchar(1000) = null
	--declare @Url as varchar(250) = null
	--declare @Cultura as varchar(5) = null

	;WITH DATOS AS (
		SELECT ROW_NUMBER() OVER ( 
			ORDER BY
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Id' THEN Videos_Idiomas.Id END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Id' THEN Videos_Idiomas.Id END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'IdRegistro' THEN Videos_Idiomas.IdRegistro END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'IdRegistro' THEN Videos_Idiomas.IdRegistro END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Cultura' THEN Videos_Idiomas.Cultura END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Cultura' THEN Videos_Idiomas.Cultura END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Nombre' THEN Videos_Idiomas.Nombre END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Nombre' THEN Videos_Idiomas.Nombre END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Descripcion' THEN Videos_Idiomas.Descripcion END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Descripcion' THEN Videos_Idiomas.Descripcion END DESC,
				CASE WHEN @TipoOrden = 1 AND @ColumnaOrden = 'Url' THEN Videos_Idiomas.Url END ASC,
				CASE WHEN @TipoOrden <> 1 AND @ColumnaOrden = 'Url' THEN Videos_Idiomas.Url END DESC
			) AS NumeroRegistro,
			Videos_Idiomas.Id AS Id, Videos_Idiomas.IdRegistro AS IdRegistro, Videos_Registro.Nombre AS Registro, Videos_Idiomas.Cultura AS Cultura, Videos_Idiomas.Nombre AS Nombre, Videos_Idiomas.Descripcion AS Descripcion, Videos_Idiomas.Url AS Url
		FROM Videos_Idiomas
			INNER JOIN Videos AS Videos_Registro ON Videos_Registro.Id = Videos_Idiomas.IdRegistro
		WHERE (@IdDesde IS NULL OR @IdHasta IS NULL OR (Videos_Idiomas.Id >= @IdDesde AND Videos_Idiomas.Id < DateAdd(d, 1, @IdHasta)))
		AND (@IdRegistro IS NULL OR Videos_Idiomas.IdRegistro = @IdRegistro)
		AND (@Nombre IS NULL OR Videos_Idiomas.Nombre LIKE '%' + @Nombre + '%')
		AND (@Descripcion IS NULL OR Videos_Idiomas.Descripcion LIKE '%' + @Descripcion + '%')
		AND (@Url IS NULL OR Videos_Idiomas.Url LIKE '%' + @Url + '%')
		AND (@Cultura IS NULL OR Videos_Idiomas.Cultura = @Cultura)

	)
	SELECT Id, IdRegistro, Registro, Cultura, Nombre, Descripcion, Url
	FROM DATOS
	WHERE (@RegistroInicial IS NULL AND @RegistroFinal IS NULL OR (NumeroRegistro >= @RegistroInicial AND NumeroRegistro <= @RegistroFinal)) 
END
GO

ALTER PROCEDURE [dbo].[Video_Idioma_ObtenerCantidadPorFiltros](@IdDesde as int, @IdHasta as int, @IdRegistro as int, @Nombre as nvarchar(250), @Descripcion as nvarchar(1000), @Url as varchar(250), @Cultura as varchar(5)) AS
BEGIN
	--declare @IdDesde as int, @IdHasta as int = null
	--declare @IdRegistro as int = null
	--declare @Nombre as nvarchar(250) = null
	--declare @Descripcion as nvarchar(1000) = null
	--declare @Url as varchar(250) = null
	--declare @Cultura as varchar(5) = null

	SELECT COUNT(*)
	FROM Videos_Idiomas
	WHERE (@IdDesde IS NULL OR @IdHasta IS NULL OR (Videos_Idiomas.Id >= @IdDesde AND Videos_Idiomas.Id < DateAdd(d, 1, @IdHasta)))
		AND (@IdRegistro IS NULL OR Videos_Idiomas.IdRegistro = @IdRegistro)
		AND (@Nombre IS NULL OR Videos_Idiomas.Nombre LIKE '%' + @Nombre + '%')
		AND (@Descripcion IS NULL OR Videos_Idiomas.Descripcion LIKE '%' + @Descripcion + '%')
		AND (@Url IS NULL OR Videos_Idiomas.Url LIKE '%' + @Url + '%')
		AND (@Cultura IS NULL OR Videos_Idiomas.Cultura = @Cultura)

END
GO

ALTER PROCEDURE [dbo].[Video_Idioma_ObtenerCombo] AS
BEGIN
	SELECT Videos_Idiomas.Id AS Id, Videos_Idiomas.Nombre AS Nombre
	FROM Videos_Idiomas
	ORDER BY Nombre
END
GO


ALTER PROCEDURE [dbo].[Video_Idioma_ObtenerLista](@Lista as varchar(500)) AS
BEGIN
	--declare @Lista as varchar(500) = '1,2'

	SELECT Videos_Idiomas.Id AS Id, Videos_Idiomas.IdRegistro AS IdRegistro, Videos_Registro.Nombre AS Registro, Videos_Idiomas.Cultura AS Cultura, Videos_Idiomas.Nombre AS Nombre, Videos_Idiomas.Descripcion AS Descripcion, Videos_Idiomas.Url AS Url
	FROM Videos_Idiomas
		INNER JOIN dbo.fnArrayATabla(@Lista, ',') l ON l.number = Videos_Idiomas.Id
			INNER JOIN Videos AS Videos_Registro ON Videos_Registro.Id = Videos_Idiomas.IdRegistro
END
GO

