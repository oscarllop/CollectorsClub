

------------------------------- Inicio script del módulo Calendarios  ------------------------------
USE CollectorsClubDNN;
GO

declare @NombrePaginaPadre as nvarchar(50) = 'Mantenimiento'
declare @TabIdMantenimientos as int = (SELECT TabId FROM dnn_tabs WHERE TabName = @NombrePaginaPadre AND [Level] = 0)
declare @PortalId as int = 0
declare @UserIdHost as int = 1
declare @RoleIdHost as int = -2
declare @RoleIdAdministrador as int = 0 -- OLL en GA no quiero que lo vean los Administradores, solo Host, Sino pondría el 5
declare @NivelEditores as int = 1
declare @Fecha as datetime = GetDate()
declare @SkinSrc as nvarchar(100) = '[G]Skins/Porto/CollectorsClub-Inner.ascx'

declare @TabContentItemId as int
declare @TabId as int
declare @PackageId as int
declare @DesktopModuleContentItemId as int
declare @DesktopModuleId as int
declare @ModuleDefinitionId as int
declare @PortalDesktopModuleId as int
declare @ModuleContentItemId as int
declare @ModuleId as int
declare @TabModuleId as int


if not exists(SELECT ContentItemId FROM dnn_ContentItems WHERE Content = 'Calendarios')
begin 
	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Calendarios', 1, -1, -1, null, 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @TabContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_Tabs (ContainerSrc, ContentItemID, CreatedByUserID, CreatedOnDate, CultureCode, DefaultLanguageGuid, Description, DisableLink, EndDate, IconFile, IconFileLarge, IsDeleted, IsSecure, IsVisible, KeyWords, LastModifiedByUserID, LastModifiedOnDate, Level, LocalizedVersionGuid, PageHeadText, ParentId, PermanentRedirect, PortalID, RefreshInterval, SiteMapPriority, SkinSrc, StartDate, TabName, TabOrder, TabPath, Title, UniqueId, Url, VersionGuid, HasBeenPublished, IsSystem)
	VALUES (null, @TabContentItemId, @UserIdHost, @Fecha, null, null, '', 0, null, '', '', 0, 0, 1, '', @UserIdHost, @Fecha, @NivelEditores, NewId(), null, @TabIdMantenimientos, 0, @PortalId, null, 0.5, @SkinSrc, null, 'Calendarios', 3, '//' + @NombrePaginaPadre + '//Calendarios', '', NewId(), '', NewId(), 1, 0)

	set @TabId = SCOPE_IDENTITY()

	UPDATE dnn_ContentItems SET TabId = @TabId WHERE ContentItemID = @TabContentItemId

	INSERT INTO dnn_TabSettings (TabID, SettingName, SettingValue, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 'AllowIndex', 'True', @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabSettings (TabID, SettingName, SettingValue, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 'LinkNewWindow', 'False', @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 3, 1, @RoleIdHost, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 4, 1, @RoleIdHost, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 3, 1, @RoleIdAdministrador, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	INSERT INTO dnn_Packages (
		CreatedByUserID, 
		CreatedOnDate, 
		Description, 
		Email, 
		FriendlyName, 
		IsSystemPackage, 
		LastModifiedByUserID, 
		LastModifiedOnDate, 
		License, 
		Manifest, 
		Name, 
		Organization, 
		Owner,
		PackageType, 
		PortalID, 
		ReleaseNotes, 
		Url, 
		Version
	) VALUES (
		@UserIdHost, 
		@Fecha, 
		'Mantenimiento Calendarios', 
		'', 
		'Mantenimiento Calendarios', 
		0, 
		@UserIdHost, 
		@Fecha, 
		'El archivo de instalación no contiene información de la licencia. Verifique con el vendedor los detalles de la licencia.', 
		'<package name="CollectorsClub.EditorCalendarios" type="Module" version="1.0.0">
		<friendlyName>CollectorsClub - Mantenimiento Calendarios</friendlyName>
		<description>CollectorsClub - Mantenimiento Calendarios</description>
		<iconFile />
		<owner>
			<name>CollectorsClub</name>
			<organization />
			<url />
			<email />
		</owner>
		<license>El archivo de instalación no contiene información de la licencia. Verifique con el vendedor los detalles de la licencia.</license>
		<releaseNotes />
		<components>
			<component type="Module">
				<desktopModule>
					<moduleName>CollectorsClub.EditorCalendarios</moduleName>
					<foldername>CollectorsClub.EditorCalendarios</foldername>
					<businessControllerClass />
					<supportedFeatures />
					<moduleDefinitions>
						<moduleDefinition>
							<friendlyName>CollectorsClub - Mantenimiento Calendarios</friendlyName>
							<definitionName>CollectorsClub - Mantenimiento Calendarios</definitionName>
							<defaultCacheTime>0</defaultCacheTime>
							<moduleControls>
								<moduleControl>
									<controlKey />
									<controlSrc>DesktopModules/CollectorsClub/Editores/CalendarioEditorView.ascx</controlSrc>
									<supportsPartialRendering>False</supportsPartialRendering>
									<controlTitle />
									<controlType>View</controlType>
									<iconFile />
									<helpUrl />
									<supportsPopUps>False</supportsPopUps>
									<viewOrder>0</viewOrder>
								</moduleControl>
							</moduleControls>
						</moduleDefinition>
					</moduleDefinitions>
				</desktopModule>
			</component>
			<component type="File">
				<files>
					<basePath>DesktopModules\CollectorsClub\Editores</basePath>
					<file>
						<name>CalendarioEditorView.ascx</name>
						<sourceFileName>CalendarioEditorView.ascx</sourceFileName>
					</file>
				</files>
			</component>
		</components>
	</package>', 
		'CollectorsClub.EditorCalendarios', 
		'', 
		'CollectorsClub',
		'Module', 
		@PortalId, 
		'Este paquete no tiene notas de la versión', 
		'', 
		'1.0.0'
	)
	set @PackageId = SCOPE_IDENTITY()

	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Mantenimiento Calendarios', 3, -1, -1, '', 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @DesktopModuleContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_DesktopModules (BusinessControllerClass, CompatibleVersions, ContentItemId, CreatedByUserID, CreatedOnDate, Dependencies, Description, FolderName, FriendlyName, IsAdmin, IsPremium, LastModifiedByUserID, LastModifiedOnDate, ModuleName, PackageID, Permissions, Shareable, SupportedFeatures, Version)
	VALUES ('', null, @DesktopModuleContentItemId, @UserIdHost, @Fecha, null, 'Mantenimiento Calendarios', 'CollectorsClub.EditorCalendarios', 'Mantenimiento Calendarios', 0, 0, @UserIdHost, @Fecha, 'CollectorsClub.EditorCalendarios', @PackageId, null, 0, 0, '01.00.00')

	set @DesktopModuleId = SCOPE_IDENTITY()

	INSERT INTO dnn_ModuleDefinitions (CreatedByUserID, CreatedOnDate, DefaultCacheTime, DefinitionName, DesktopModuleID, FriendlyName, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@UserIdHost, @Fecha, 0, 'Mantenimiento Calendarios', @DesktopModuleId, 'Mantenimiento Calendarios', @UserIdHost, @Fecha)

	set @ModuleDefinitionId = SCOPE_IDENTITY()

	INSERT INTO dnn_PortalDesktopModules (CreatedByUserID, CreatedOnDate, DesktopModuleID, LastModifiedByUserID, LastModifiedOnDate, PortalID)
	VALUES (@UserIdHost, @Fecha, @DesktopModuleId, @UserIdHost, @Fecha, @PortalId)

	set @PortalDesktopModuleId = SCOPE_IDENTITY()

	INSERT INTO dnn_DesktopModulePermission (AllowAccess, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, PermissionID, PortalDesktopModuleID, RoleID, UserID)
	VALUES (1, @UserIdHost, @Fecha, @UserIdHost, @Fecha, 7, @PortalDesktopModuleId, @RoleIdHost, null)

	INSERT INTO dnn_ModuleControls (ControlKey, ControlSrc, ControlTitle, ControlType, CreatedByUserID, CreatedOnDate, HelpUrl, IconFile, LastModifiedByUserID, LastModifiedOnDate, ModuleDefID, SupportsPartialRendering, SupportsPopUps, ViewOrder)
	VALUES (null, 'DesktopModules/CollectorsClub/Editores/CalendarioEditorView.ascx', null, 0, @UserIdHost, @Fecha, null, null, @UserIdHost, @Fecha, @ModuleDefinitionId, 0, 0, 0)

	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Mantenimiento Calendarios', 2, @TabId, -1, null, 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @ModuleContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_Modules (AllTabs, ContentItemID, CreatedByUserID, CreatedOnDate, EndDate, InheritViewPermissions, IsDeleted, IsShareable, IsShareableViewOnly, LastContentModifiedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleDefID, PortalID, StartDate)
	VALUES (0, @ModuleContentItemId, @UserIdHost, @Fecha, null, 1, 0, 1, 1, null, @UserIdHost, @Fecha, @ModuleDefinitionId, @PortalId, null)

	set @ModuleId = SCOPE_IDENTITY()

	UPDATE dnn_ContentItems SET ModuleId = @ModuleId WHERE ContentItemID = @ModuleContentItemId

	INSERT INTO dnn_TabModules (Alignment, Border, CacheMethod, CacheTime, Color, ContainerSrc, CreatedByUserID, CreatedOnDate, CultureCode, DefaultLanguageGuid, DisplayPrint, DisplaySyndicate, DisplayTitle, Footer, Header, IconFile, IsDeleted, IsWebSlice,LastModifiedByUserID, LastModifiedOnDate, LocalizedVersionGuid, ModuleID, ModuleOrder, ModuleTitle, PaneName, TabID, UniqueId, VersionGuid, Visibility, WebSliceExpiryDate, WebSliceTitle, WebSliceTTL)
	VALUES (null, null, null, 0, null, null, @UserIdHost, @Fecha, '', null, 0, 0, 0, null, null, null, 0, 0, @UserIdHost, @Fecha, NewId(), @ModuleId, 3, 'Mantenimiento Calendarios', 'ContentPane', @TabId, NewId(), NewId(), 2, null, '', 0)

	set @TabModuleId = SCOPE_IDENTITY()

	-- DNN No le crea ningún permiso
	--INSERT INTO dnn_TabModuleSettings (CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, SettingName, SettingValue, TabModuleID)
	--VALUES (@UserIdHost, @Fecha, @UserIdHost, @Fecha, '', '', @TabModuleId)

	INSERT INTO dnn_ModulePermission (AllowAccess, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleID, PermissionID, PortalID, RoleID, UserID)
	VALUES (1, @UserIdHost, @Fecha, @UserIdHost, @Fecha, @ModuleId, 2, @PortalId, @RoleIdHost, null)

	-- DNN No le crea ningún permiso
	--INSERT INTO dnn_ModuleSettings (CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleID, SettingName, SettingValue) 
	--VALUES (@UserIdHost, @Fecha, @UserIdHost, @Fecha, @ModuleId, '', '') 
end
------------------------------- Fin script del módulo Calendarios  ------------------------------

------------------------------- Inicio script del módulo Calendarios_Idiomas  ------------------------------
USE CollectorsClubDNN;
GO

declare @NombrePaginaPadre as nvarchar(50) = 'Mantenimiento'
declare @TabIdMantenimientos as int = (SELECT TabId FROM dnn_tabs WHERE TabName = @NombrePaginaPadre AND [Level] = 0)
declare @PortalId as int = 0
declare @UserIdHost as int = 1
declare @RoleIdHost as int = -2
declare @RoleIdAdministrador as int = 0 -- OLL en GA no quiero que lo vean los Administradores, solo Host, Sino pondría el 5
declare @NivelEditores as int = 1
declare @Fecha as datetime = GetDate()
declare @SkinSrc as nvarchar(100) = '[G]Skins/Porto/CollectorsClub-Inner.ascx'

declare @TabContentItemId as int
declare @TabId as int
declare @PackageId as int
declare @DesktopModuleContentItemId as int
declare @DesktopModuleId as int
declare @ModuleDefinitionId as int
declare @PortalDesktopModuleId as int
declare @ModuleContentItemId as int
declare @ModuleId as int
declare @TabModuleId as int


if not exists(SELECT ContentItemId FROM dnn_ContentItems WHERE Content = 'Calendarios_Idiomas')
begin 
	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Calendarios_Idiomas', 1, -1, -1, null, 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @TabContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_Tabs (ContainerSrc, ContentItemID, CreatedByUserID, CreatedOnDate, CultureCode, DefaultLanguageGuid, Description, DisableLink, EndDate, IconFile, IconFileLarge, IsDeleted, IsSecure, IsVisible, KeyWords, LastModifiedByUserID, LastModifiedOnDate, Level, LocalizedVersionGuid, PageHeadText, ParentId, PermanentRedirect, PortalID, RefreshInterval, SiteMapPriority, SkinSrc, StartDate, TabName, TabOrder, TabPath, Title, UniqueId, Url, VersionGuid, HasBeenPublished, IsSystem)
	VALUES (null, @TabContentItemId, @UserIdHost, @Fecha, null, null, '', 0, null, '', '', 0, 0, 1, '', @UserIdHost, @Fecha, @NivelEditores, NewId(), null, @TabIdMantenimientos, 0, @PortalId, null, 0.5, @SkinSrc, null, 'Calendarios_Idiomas', 3, '//' + @NombrePaginaPadre + '//Calendarios_Idiomas', '', NewId(), '', NewId(), 1, 0)

	set @TabId = SCOPE_IDENTITY()

	UPDATE dnn_ContentItems SET TabId = @TabId WHERE ContentItemID = @TabContentItemId

	INSERT INTO dnn_TabSettings (TabID, SettingName, SettingValue, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 'AllowIndex', 'True', @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabSettings (TabID, SettingName, SettingValue, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 'LinkNewWindow', 'False', @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 3, 1, @RoleIdHost, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 4, 1, @RoleIdHost, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 3, 1, @RoleIdAdministrador, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	INSERT INTO dnn_Packages (
		CreatedByUserID, 
		CreatedOnDate, 
		Description, 
		Email, 
		FriendlyName, 
		IsSystemPackage, 
		LastModifiedByUserID, 
		LastModifiedOnDate, 
		License, 
		Manifest, 
		Name, 
		Organization, 
		Owner,
		PackageType, 
		PortalID, 
		ReleaseNotes, 
		Url, 
		Version
	) VALUES (
		@UserIdHost, 
		@Fecha, 
		'Mantenimiento Calendarios_Idiomas', 
		'', 
		'Mantenimiento Calendarios_Idiomas', 
		0, 
		@UserIdHost, 
		@Fecha, 
		'El archivo de instalación no contiene información de la licencia. Verifique con el vendedor los detalles de la licencia.', 
		'<package name="CollectorsClub.EditorCalendarios_Idiomas" type="Module" version="1.0.0">
		<friendlyName>CollectorsClub - Mantenimiento Calendarios_Idiomas</friendlyName>
		<description>CollectorsClub - Mantenimiento Calendarios_Idiomas</description>
		<iconFile />
		<owner>
			<name>CollectorsClub</name>
			<organization />
			<url />
			<email />
		</owner>
		<license>El archivo de instalación no contiene información de la licencia. Verifique con el vendedor los detalles de la licencia.</license>
		<releaseNotes />
		<components>
			<component type="Module">
				<desktopModule>
					<moduleName>CollectorsClub.EditorCalendarios_Idiomas</moduleName>
					<foldername>CollectorsClub.EditorCalendarios_Idiomas</foldername>
					<businessControllerClass />
					<supportedFeatures />
					<moduleDefinitions>
						<moduleDefinition>
							<friendlyName>CollectorsClub - Mantenimiento Calendarios_Idiomas</friendlyName>
							<definitionName>CollectorsClub - Mantenimiento Calendarios_Idiomas</definitionName>
							<defaultCacheTime>0</defaultCacheTime>
							<moduleControls>
								<moduleControl>
									<controlKey />
									<controlSrc>DesktopModules/CollectorsClub/Editores/Calendario_IdiomaEditorView.ascx</controlSrc>
									<supportsPartialRendering>False</supportsPartialRendering>
									<controlTitle />
									<controlType>View</controlType>
									<iconFile />
									<helpUrl />
									<supportsPopUps>False</supportsPopUps>
									<viewOrder>0</viewOrder>
								</moduleControl>
							</moduleControls>
						</moduleDefinition>
					</moduleDefinitions>
				</desktopModule>
			</component>
			<component type="File">
				<files>
					<basePath>DesktopModules\CollectorsClub\Editores</basePath>
					<file>
						<name>Calendario_IdiomaEditorView.ascx</name>
						<sourceFileName>Calendario_IdiomaEditorView.ascx</sourceFileName>
					</file>
				</files>
			</component>
		</components>
	</package>', 
		'CollectorsClub.EditorCalendarios_Idiomas', 
		'', 
		'CollectorsClub',
		'Module', 
		@PortalId, 
		'Este paquete no tiene notas de la versión', 
		'', 
		'1.0.0'
	)
	set @PackageId = SCOPE_IDENTITY()

	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Mantenimiento Calendarios_Idiomas', 3, -1, -1, '', 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @DesktopModuleContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_DesktopModules (BusinessControllerClass, CompatibleVersions, ContentItemId, CreatedByUserID, CreatedOnDate, Dependencies, Description, FolderName, FriendlyName, IsAdmin, IsPremium, LastModifiedByUserID, LastModifiedOnDate, ModuleName, PackageID, Permissions, Shareable, SupportedFeatures, Version)
	VALUES ('', null, @DesktopModuleContentItemId, @UserIdHost, @Fecha, null, 'Mantenimiento Calendarios_Idiomas', 'CollectorsClub.EditorCalendarios_Idiomas', 'Mantenimiento Calendarios_Idiomas', 0, 0, @UserIdHost, @Fecha, 'CollectorsClub.EditorCalendarios_Idiomas', @PackageId, null, 0, 0, '01.00.00')

	set @DesktopModuleId = SCOPE_IDENTITY()

	INSERT INTO dnn_ModuleDefinitions (CreatedByUserID, CreatedOnDate, DefaultCacheTime, DefinitionName, DesktopModuleID, FriendlyName, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@UserIdHost, @Fecha, 0, 'Mantenimiento Calendarios_Idiomas', @DesktopModuleId, 'Mantenimiento Calendarios_Idiomas', @UserIdHost, @Fecha)

	set @ModuleDefinitionId = SCOPE_IDENTITY()

	INSERT INTO dnn_PortalDesktopModules (CreatedByUserID, CreatedOnDate, DesktopModuleID, LastModifiedByUserID, LastModifiedOnDate, PortalID)
	VALUES (@UserIdHost, @Fecha, @DesktopModuleId, @UserIdHost, @Fecha, @PortalId)

	set @PortalDesktopModuleId = SCOPE_IDENTITY()

	INSERT INTO dnn_DesktopModulePermission (AllowAccess, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, PermissionID, PortalDesktopModuleID, RoleID, UserID)
	VALUES (1, @UserIdHost, @Fecha, @UserIdHost, @Fecha, 7, @PortalDesktopModuleId, @RoleIdHost, null)

	INSERT INTO dnn_ModuleControls (ControlKey, ControlSrc, ControlTitle, ControlType, CreatedByUserID, CreatedOnDate, HelpUrl, IconFile, LastModifiedByUserID, LastModifiedOnDate, ModuleDefID, SupportsPartialRendering, SupportsPopUps, ViewOrder)
	VALUES (null, 'DesktopModules/CollectorsClub/Editores/Calendario_IdiomaEditorView.ascx', null, 0, @UserIdHost, @Fecha, null, null, @UserIdHost, @Fecha, @ModuleDefinitionId, 0, 0, 0)

	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Mantenimiento Calendarios_Idiomas', 2, @TabId, -1, null, 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @ModuleContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_Modules (AllTabs, ContentItemID, CreatedByUserID, CreatedOnDate, EndDate, InheritViewPermissions, IsDeleted, IsShareable, IsShareableViewOnly, LastContentModifiedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleDefID, PortalID, StartDate)
	VALUES (0, @ModuleContentItemId, @UserIdHost, @Fecha, null, 1, 0, 1, 1, null, @UserIdHost, @Fecha, @ModuleDefinitionId, @PortalId, null)

	set @ModuleId = SCOPE_IDENTITY()

	UPDATE dnn_ContentItems SET ModuleId = @ModuleId WHERE ContentItemID = @ModuleContentItemId

	INSERT INTO dnn_TabModules (Alignment, Border, CacheMethod, CacheTime, Color, ContainerSrc, CreatedByUserID, CreatedOnDate, CultureCode, DefaultLanguageGuid, DisplayPrint, DisplaySyndicate, DisplayTitle, Footer, Header, IconFile, IsDeleted, IsWebSlice,LastModifiedByUserID, LastModifiedOnDate, LocalizedVersionGuid, ModuleID, ModuleOrder, ModuleTitle, PaneName, TabID, UniqueId, VersionGuid, Visibility, WebSliceExpiryDate, WebSliceTitle, WebSliceTTL)
	VALUES (null, null, null, 0, null, null, @UserIdHost, @Fecha, '', null, 0, 0, 0, null, null, null, 0, 0, @UserIdHost, @Fecha, NewId(), @ModuleId, 3, 'Mantenimiento Calendarios_Idiomas', 'ContentPane', @TabId, NewId(), NewId(), 2, null, '', 0)

	set @TabModuleId = SCOPE_IDENTITY()

	-- DNN No le crea ningún permiso
	--INSERT INTO dnn_TabModuleSettings (CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, SettingName, SettingValue, TabModuleID)
	--VALUES (@UserIdHost, @Fecha, @UserIdHost, @Fecha, '', '', @TabModuleId)

	INSERT INTO dnn_ModulePermission (AllowAccess, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleID, PermissionID, PortalID, RoleID, UserID)
	VALUES (1, @UserIdHost, @Fecha, @UserIdHost, @Fecha, @ModuleId, 2, @PortalId, @RoleIdHost, null)

	-- DNN No le crea ningún permiso
	--INSERT INTO dnn_ModuleSettings (CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleID, SettingName, SettingValue) 
	--VALUES (@UserIdHost, @Fecha, @UserIdHost, @Fecha, @ModuleId, '', '') 
end
------------------------------- Fin script del módulo Calendarios_Idiomas  ------------------------------

------------------------------- Inicio script del módulo CategoriasCalendario  ------------------------------
USE CollectorsClubDNN;
GO

declare @NombrePaginaPadre as nvarchar(50) = 'Mantenimiento'
declare @TabIdMantenimientos as int = (SELECT TabId FROM dnn_tabs WHERE TabName = @NombrePaginaPadre AND [Level] = 0)
declare @PortalId as int = 0
declare @UserIdHost as int = 1
declare @RoleIdHost as int = -2
declare @RoleIdAdministrador as int = 0 -- OLL en GA no quiero que lo vean los Administradores, solo Host, Sino pondría el 5
declare @NivelEditores as int = 1
declare @Fecha as datetime = GetDate()
declare @SkinSrc as nvarchar(100) = '[G]Skins/Porto/CollectorsClub-Inner.ascx'

declare @TabContentItemId as int
declare @TabId as int
declare @PackageId as int
declare @DesktopModuleContentItemId as int
declare @DesktopModuleId as int
declare @ModuleDefinitionId as int
declare @PortalDesktopModuleId as int
declare @ModuleContentItemId as int
declare @ModuleId as int
declare @TabModuleId as int


if not exists(SELECT ContentItemId FROM dnn_ContentItems WHERE Content = 'CategoriasCalendario')
begin 
	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('CategoriasCalendario', 1, -1, -1, null, 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @TabContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_Tabs (ContainerSrc, ContentItemID, CreatedByUserID, CreatedOnDate, CultureCode, DefaultLanguageGuid, Description, DisableLink, EndDate, IconFile, IconFileLarge, IsDeleted, IsSecure, IsVisible, KeyWords, LastModifiedByUserID, LastModifiedOnDate, Level, LocalizedVersionGuid, PageHeadText, ParentId, PermanentRedirect, PortalID, RefreshInterval, SiteMapPriority, SkinSrc, StartDate, TabName, TabOrder, TabPath, Title, UniqueId, Url, VersionGuid, HasBeenPublished, IsSystem)
	VALUES (null, @TabContentItemId, @UserIdHost, @Fecha, null, null, '', 0, null, '', '', 0, 0, 1, '', @UserIdHost, @Fecha, @NivelEditores, NewId(), null, @TabIdMantenimientos, 0, @PortalId, null, 0.5, @SkinSrc, null, 'CategoriasCalendario', 3, '//' + @NombrePaginaPadre + '//CategoriasCalendario', '', NewId(), '', NewId(), 1, 0)

	set @TabId = SCOPE_IDENTITY()

	UPDATE dnn_ContentItems SET TabId = @TabId WHERE ContentItemID = @TabContentItemId

	INSERT INTO dnn_TabSettings (TabID, SettingName, SettingValue, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 'AllowIndex', 'True', @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabSettings (TabID, SettingName, SettingValue, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 'LinkNewWindow', 'False', @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 3, 1, @RoleIdHost, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 4, 1, @RoleIdHost, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 3, 1, @RoleIdAdministrador, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	INSERT INTO dnn_Packages (
		CreatedByUserID, 
		CreatedOnDate, 
		Description, 
		Email, 
		FriendlyName, 
		IsSystemPackage, 
		LastModifiedByUserID, 
		LastModifiedOnDate, 
		License, 
		Manifest, 
		Name, 
		Organization, 
		Owner,
		PackageType, 
		PortalID, 
		ReleaseNotes, 
		Url, 
		Version
	) VALUES (
		@UserIdHost, 
		@Fecha, 
		'Mantenimiento CategoriasCalendario', 
		'', 
		'Mantenimiento CategoriasCalendario', 
		0, 
		@UserIdHost, 
		@Fecha, 
		'El archivo de instalación no contiene información de la licencia. Verifique con el vendedor los detalles de la licencia.', 
		'<package name="CollectorsClub.EditorCategoriasCalendario" type="Module" version="1.0.0">
		<friendlyName>CollectorsClub - Mantenimiento CategoriasCalendario</friendlyName>
		<description>CollectorsClub - Mantenimiento CategoriasCalendario</description>
		<iconFile />
		<owner>
			<name>CollectorsClub</name>
			<organization />
			<url />
			<email />
		</owner>
		<license>El archivo de instalación no contiene información de la licencia. Verifique con el vendedor los detalles de la licencia.</license>
		<releaseNotes />
		<components>
			<component type="Module">
				<desktopModule>
					<moduleName>CollectorsClub.EditorCategoriasCalendario</moduleName>
					<foldername>CollectorsClub.EditorCategoriasCalendario</foldername>
					<businessControllerClass />
					<supportedFeatures />
					<moduleDefinitions>
						<moduleDefinition>
							<friendlyName>CollectorsClub - Mantenimiento CategoriasCalendario</friendlyName>
							<definitionName>CollectorsClub - Mantenimiento CategoriasCalendario</definitionName>
							<defaultCacheTime>0</defaultCacheTime>
							<moduleControls>
								<moduleControl>
									<controlKey />
									<controlSrc>DesktopModules/CollectorsClub/Editores/CategoriaCalendarioEditorView.ascx</controlSrc>
									<supportsPartialRendering>False</supportsPartialRendering>
									<controlTitle />
									<controlType>View</controlType>
									<iconFile />
									<helpUrl />
									<supportsPopUps>False</supportsPopUps>
									<viewOrder>0</viewOrder>
								</moduleControl>
							</moduleControls>
						</moduleDefinition>
					</moduleDefinitions>
				</desktopModule>
			</component>
			<component type="File">
				<files>
					<basePath>DesktopModules\CollectorsClub\Editores</basePath>
					<file>
						<name>CategoriaCalendarioEditorView.ascx</name>
						<sourceFileName>CategoriaCalendarioEditorView.ascx</sourceFileName>
					</file>
				</files>
			</component>
		</components>
	</package>', 
		'CollectorsClub.EditorCategoriasCalendario', 
		'', 
		'CollectorsClub',
		'Module', 
		@PortalId, 
		'Este paquete no tiene notas de la versión', 
		'', 
		'1.0.0'
	)
	set @PackageId = SCOPE_IDENTITY()

	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Mantenimiento CategoriasCalendario', 3, -1, -1, '', 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @DesktopModuleContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_DesktopModules (BusinessControllerClass, CompatibleVersions, ContentItemId, CreatedByUserID, CreatedOnDate, Dependencies, Description, FolderName, FriendlyName, IsAdmin, IsPremium, LastModifiedByUserID, LastModifiedOnDate, ModuleName, PackageID, Permissions, Shareable, SupportedFeatures, Version)
	VALUES ('', null, @DesktopModuleContentItemId, @UserIdHost, @Fecha, null, 'Mantenimiento CategoriasCalendario', 'CollectorsClub.EditorCategoriasCalendario', 'Mantenimiento CategoriasCalendario', 0, 0, @UserIdHost, @Fecha, 'CollectorsClub.EditorCategoriasCalendario', @PackageId, null, 0, 0, '01.00.00')

	set @DesktopModuleId = SCOPE_IDENTITY()

	INSERT INTO dnn_ModuleDefinitions (CreatedByUserID, CreatedOnDate, DefaultCacheTime, DefinitionName, DesktopModuleID, FriendlyName, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@UserIdHost, @Fecha, 0, 'Mantenimiento CategoriasCalendario', @DesktopModuleId, 'Mantenimiento CategoriasCalendario', @UserIdHost, @Fecha)

	set @ModuleDefinitionId = SCOPE_IDENTITY()

	INSERT INTO dnn_PortalDesktopModules (CreatedByUserID, CreatedOnDate, DesktopModuleID, LastModifiedByUserID, LastModifiedOnDate, PortalID)
	VALUES (@UserIdHost, @Fecha, @DesktopModuleId, @UserIdHost, @Fecha, @PortalId)

	set @PortalDesktopModuleId = SCOPE_IDENTITY()

	INSERT INTO dnn_DesktopModulePermission (AllowAccess, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, PermissionID, PortalDesktopModuleID, RoleID, UserID)
	VALUES (1, @UserIdHost, @Fecha, @UserIdHost, @Fecha, 7, @PortalDesktopModuleId, @RoleIdHost, null)

	INSERT INTO dnn_ModuleControls (ControlKey, ControlSrc, ControlTitle, ControlType, CreatedByUserID, CreatedOnDate, HelpUrl, IconFile, LastModifiedByUserID, LastModifiedOnDate, ModuleDefID, SupportsPartialRendering, SupportsPopUps, ViewOrder)
	VALUES (null, 'DesktopModules/CollectorsClub/Editores/CategoriaCalendarioEditorView.ascx', null, 0, @UserIdHost, @Fecha, null, null, @UserIdHost, @Fecha, @ModuleDefinitionId, 0, 0, 0)

	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Mantenimiento CategoriasCalendario', 2, @TabId, -1, null, 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @ModuleContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_Modules (AllTabs, ContentItemID, CreatedByUserID, CreatedOnDate, EndDate, InheritViewPermissions, IsDeleted, IsShareable, IsShareableViewOnly, LastContentModifiedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleDefID, PortalID, StartDate)
	VALUES (0, @ModuleContentItemId, @UserIdHost, @Fecha, null, 1, 0, 1, 1, null, @UserIdHost, @Fecha, @ModuleDefinitionId, @PortalId, null)

	set @ModuleId = SCOPE_IDENTITY()

	UPDATE dnn_ContentItems SET ModuleId = @ModuleId WHERE ContentItemID = @ModuleContentItemId

	INSERT INTO dnn_TabModules (Alignment, Border, CacheMethod, CacheTime, Color, ContainerSrc, CreatedByUserID, CreatedOnDate, CultureCode, DefaultLanguageGuid, DisplayPrint, DisplaySyndicate, DisplayTitle, Footer, Header, IconFile, IsDeleted, IsWebSlice,LastModifiedByUserID, LastModifiedOnDate, LocalizedVersionGuid, ModuleID, ModuleOrder, ModuleTitle, PaneName, TabID, UniqueId, VersionGuid, Visibility, WebSliceExpiryDate, WebSliceTitle, WebSliceTTL)
	VALUES (null, null, null, 0, null, null, @UserIdHost, @Fecha, '', null, 0, 0, 0, null, null, null, 0, 0, @UserIdHost, @Fecha, NewId(), @ModuleId, 3, 'Mantenimiento CategoriasCalendario', 'ContentPane', @TabId, NewId(), NewId(), 2, null, '', 0)

	set @TabModuleId = SCOPE_IDENTITY()

	-- DNN No le crea ningún permiso
	--INSERT INTO dnn_TabModuleSettings (CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, SettingName, SettingValue, TabModuleID)
	--VALUES (@UserIdHost, @Fecha, @UserIdHost, @Fecha, '', '', @TabModuleId)

	INSERT INTO dnn_ModulePermission (AllowAccess, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleID, PermissionID, PortalID, RoleID, UserID)
	VALUES (1, @UserIdHost, @Fecha, @UserIdHost, @Fecha, @ModuleId, 2, @PortalId, @RoleIdHost, null)

	-- DNN No le crea ningún permiso
	--INSERT INTO dnn_ModuleSettings (CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleID, SettingName, SettingValue) 
	--VALUES (@UserIdHost, @Fecha, @UserIdHost, @Fecha, @ModuleId, '', '') 
end
------------------------------- Fin script del módulo CategoriasCalendario  ------------------------------

------------------------------- Inicio script del módulo CategoriasCalendario_Idiomas  ------------------------------
USE CollectorsClubDNN;
GO

declare @NombrePaginaPadre as nvarchar(50) = 'Mantenimiento'
declare @TabIdMantenimientos as int = (SELECT TabId FROM dnn_tabs WHERE TabName = @NombrePaginaPadre AND [Level] = 0)
declare @PortalId as int = 0
declare @UserIdHost as int = 1
declare @RoleIdHost as int = -2
declare @RoleIdAdministrador as int = 0 -- OLL en GA no quiero que lo vean los Administradores, solo Host, Sino pondría el 5
declare @NivelEditores as int = 1
declare @Fecha as datetime = GetDate()
declare @SkinSrc as nvarchar(100) = '[G]Skins/Porto/CollectorsClub-Inner.ascx'

declare @TabContentItemId as int
declare @TabId as int
declare @PackageId as int
declare @DesktopModuleContentItemId as int
declare @DesktopModuleId as int
declare @ModuleDefinitionId as int
declare @PortalDesktopModuleId as int
declare @ModuleContentItemId as int
declare @ModuleId as int
declare @TabModuleId as int


if not exists(SELECT ContentItemId FROM dnn_ContentItems WHERE Content = 'CategoriasCalendario_Idiomas')
begin 
	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('CategoriasCalendario_Idiomas', 1, -1, -1, null, 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @TabContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_Tabs (ContainerSrc, ContentItemID, CreatedByUserID, CreatedOnDate, CultureCode, DefaultLanguageGuid, Description, DisableLink, EndDate, IconFile, IconFileLarge, IsDeleted, IsSecure, IsVisible, KeyWords, LastModifiedByUserID, LastModifiedOnDate, Level, LocalizedVersionGuid, PageHeadText, ParentId, PermanentRedirect, PortalID, RefreshInterval, SiteMapPriority, SkinSrc, StartDate, TabName, TabOrder, TabPath, Title, UniqueId, Url, VersionGuid, HasBeenPublished, IsSystem)
	VALUES (null, @TabContentItemId, @UserIdHost, @Fecha, null, null, '', 0, null, '', '', 0, 0, 1, '', @UserIdHost, @Fecha, @NivelEditores, NewId(), null, @TabIdMantenimientos, 0, @PortalId, null, 0.5, @SkinSrc, null, 'CategoriasCalendario_Idiomas', 3, '//' + @NombrePaginaPadre + '//CategoriasCalendario_Idiomas', '', NewId(), '', NewId(), 1, 0)

	set @TabId = SCOPE_IDENTITY()

	UPDATE dnn_ContentItems SET TabId = @TabId WHERE ContentItemID = @TabContentItemId

	INSERT INTO dnn_TabSettings (TabID, SettingName, SettingValue, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 'AllowIndex', 'True', @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabSettings (TabID, SettingName, SettingValue, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 'LinkNewWindow', 'False', @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 3, 1, @RoleIdHost, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 4, 1, @RoleIdHost, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 3, 1, @RoleIdAdministrador, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	INSERT INTO dnn_Packages (
		CreatedByUserID, 
		CreatedOnDate, 
		Description, 
		Email, 
		FriendlyName, 
		IsSystemPackage, 
		LastModifiedByUserID, 
		LastModifiedOnDate, 
		License, 
		Manifest, 
		Name, 
		Organization, 
		Owner,
		PackageType, 
		PortalID, 
		ReleaseNotes, 
		Url, 
		Version
	) VALUES (
		@UserIdHost, 
		@Fecha, 
		'Mantenimiento CategoriasCalendario_Idiomas', 
		'', 
		'Mantenimiento CategoriasCalendario_Idiomas', 
		0, 
		@UserIdHost, 
		@Fecha, 
		'El archivo de instalación no contiene información de la licencia. Verifique con el vendedor los detalles de la licencia.', 
		'<package name="CollectorsClub.EditorCategoriasCalendario_Idiomas" type="Module" version="1.0.0">
		<friendlyName>CollectorsClub - Mantenimiento CategoriasCalendario_Idiomas</friendlyName>
		<description>CollectorsClub - Mantenimiento CategoriasCalendario_Idiomas</description>
		<iconFile />
		<owner>
			<name>CollectorsClub</name>
			<organization />
			<url />
			<email />
		</owner>
		<license>El archivo de instalación no contiene información de la licencia. Verifique con el vendedor los detalles de la licencia.</license>
		<releaseNotes />
		<components>
			<component type="Module">
				<desktopModule>
					<moduleName>CollectorsClub.EditorCategoriasCalendario_Idiomas</moduleName>
					<foldername>CollectorsClub.EditorCategoriasCalendario_Idiomas</foldername>
					<businessControllerClass />
					<supportedFeatures />
					<moduleDefinitions>
						<moduleDefinition>
							<friendlyName>CollectorsClub - Mantenimiento CategoriasCalendario_Idiomas</friendlyName>
							<definitionName>CollectorsClub - Mantenimiento CategoriasCalendario_Idiomas</definitionName>
							<defaultCacheTime>0</defaultCacheTime>
							<moduleControls>
								<moduleControl>
									<controlKey />
									<controlSrc>DesktopModules/CollectorsClub/Editores/CategoriaCalendario_IdiomaEditorView.ascx</controlSrc>
									<supportsPartialRendering>False</supportsPartialRendering>
									<controlTitle />
									<controlType>View</controlType>
									<iconFile />
									<helpUrl />
									<supportsPopUps>False</supportsPopUps>
									<viewOrder>0</viewOrder>
								</moduleControl>
							</moduleControls>
						</moduleDefinition>
					</moduleDefinitions>
				</desktopModule>
			</component>
			<component type="File">
				<files>
					<basePath>DesktopModules\CollectorsClub\Editores</basePath>
					<file>
						<name>CategoriaCalendario_IdiomaEditorView.ascx</name>
						<sourceFileName>CategoriaCalendario_IdiomaEditorView.ascx</sourceFileName>
					</file>
				</files>
			</component>
		</components>
	</package>', 
		'CollectorsClub.EditorCategoriasCalendario_Idiomas', 
		'', 
		'CollectorsClub',
		'Module', 
		@PortalId, 
		'Este paquete no tiene notas de la versión', 
		'', 
		'1.0.0'
	)
	set @PackageId = SCOPE_IDENTITY()

	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Mantenimiento CategoriasCalendario_Idiomas', 3, -1, -1, '', 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @DesktopModuleContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_DesktopModules (BusinessControllerClass, CompatibleVersions, ContentItemId, CreatedByUserID, CreatedOnDate, Dependencies, Description, FolderName, FriendlyName, IsAdmin, IsPremium, LastModifiedByUserID, LastModifiedOnDate, ModuleName, PackageID, Permissions, Shareable, SupportedFeatures, Version)
	VALUES ('', null, @DesktopModuleContentItemId, @UserIdHost, @Fecha, null, 'Mantenimiento CategoriasCalendario_Idiomas', 'CollectorsClub.EditorCategoriasCalendario_Idiomas', 'Mantenimiento CategoriasCalendario_Idiomas', 0, 0, @UserIdHost, @Fecha, 'CollectorsClub.EditorCategoriasCalendario_Idiomas', @PackageId, null, 0, 0, '01.00.00')

	set @DesktopModuleId = SCOPE_IDENTITY()

	INSERT INTO dnn_ModuleDefinitions (CreatedByUserID, CreatedOnDate, DefaultCacheTime, DefinitionName, DesktopModuleID, FriendlyName, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@UserIdHost, @Fecha, 0, 'Mantenimiento CategoriasCalendario_Idiomas', @DesktopModuleId, 'Mantenimiento CategoriasCalendario_Idiomas', @UserIdHost, @Fecha)

	set @ModuleDefinitionId = SCOPE_IDENTITY()

	INSERT INTO dnn_PortalDesktopModules (CreatedByUserID, CreatedOnDate, DesktopModuleID, LastModifiedByUserID, LastModifiedOnDate, PortalID)
	VALUES (@UserIdHost, @Fecha, @DesktopModuleId, @UserIdHost, @Fecha, @PortalId)

	set @PortalDesktopModuleId = SCOPE_IDENTITY()

	INSERT INTO dnn_DesktopModulePermission (AllowAccess, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, PermissionID, PortalDesktopModuleID, RoleID, UserID)
	VALUES (1, @UserIdHost, @Fecha, @UserIdHost, @Fecha, 7, @PortalDesktopModuleId, @RoleIdHost, null)

	INSERT INTO dnn_ModuleControls (ControlKey, ControlSrc, ControlTitle, ControlType, CreatedByUserID, CreatedOnDate, HelpUrl, IconFile, LastModifiedByUserID, LastModifiedOnDate, ModuleDefID, SupportsPartialRendering, SupportsPopUps, ViewOrder)
	VALUES (null, 'DesktopModules/CollectorsClub/Editores/CategoriaCalendario_IdiomaEditorView.ascx', null, 0, @UserIdHost, @Fecha, null, null, @UserIdHost, @Fecha, @ModuleDefinitionId, 0, 0, 0)

	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Mantenimiento CategoriasCalendario_Idiomas', 2, @TabId, -1, null, 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @ModuleContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_Modules (AllTabs, ContentItemID, CreatedByUserID, CreatedOnDate, EndDate, InheritViewPermissions, IsDeleted, IsShareable, IsShareableViewOnly, LastContentModifiedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleDefID, PortalID, StartDate)
	VALUES (0, @ModuleContentItemId, @UserIdHost, @Fecha, null, 1, 0, 1, 1, null, @UserIdHost, @Fecha, @ModuleDefinitionId, @PortalId, null)

	set @ModuleId = SCOPE_IDENTITY()

	UPDATE dnn_ContentItems SET ModuleId = @ModuleId WHERE ContentItemID = @ModuleContentItemId

	INSERT INTO dnn_TabModules (Alignment, Border, CacheMethod, CacheTime, Color, ContainerSrc, CreatedByUserID, CreatedOnDate, CultureCode, DefaultLanguageGuid, DisplayPrint, DisplaySyndicate, DisplayTitle, Footer, Header, IconFile, IsDeleted, IsWebSlice,LastModifiedByUserID, LastModifiedOnDate, LocalizedVersionGuid, ModuleID, ModuleOrder, ModuleTitle, PaneName, TabID, UniqueId, VersionGuid, Visibility, WebSliceExpiryDate, WebSliceTitle, WebSliceTTL)
	VALUES (null, null, null, 0, null, null, @UserIdHost, @Fecha, '', null, 0, 0, 0, null, null, null, 0, 0, @UserIdHost, @Fecha, NewId(), @ModuleId, 3, 'Mantenimiento CategoriasCalendario_Idiomas', 'ContentPane', @TabId, NewId(), NewId(), 2, null, '', 0)

	set @TabModuleId = SCOPE_IDENTITY()

	-- DNN No le crea ningún permiso
	--INSERT INTO dnn_TabModuleSettings (CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, SettingName, SettingValue, TabModuleID)
	--VALUES (@UserIdHost, @Fecha, @UserIdHost, @Fecha, '', '', @TabModuleId)

	INSERT INTO dnn_ModulePermission (AllowAccess, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleID, PermissionID, PortalID, RoleID, UserID)
	VALUES (1, @UserIdHost, @Fecha, @UserIdHost, @Fecha, @ModuleId, 2, @PortalId, @RoleIdHost, null)

	-- DNN No le crea ningún permiso
	--INSERT INTO dnn_ModuleSettings (CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleID, SettingName, SettingValue) 
	--VALUES (@UserIdHost, @Fecha, @UserIdHost, @Fecha, @ModuleId, '', '') 
end
------------------------------- Fin script del módulo CategoriasCalendario_Idiomas  ------------------------------

------------------------------- Inicio script del módulo CategoriasFotos  ------------------------------
USE CollectorsClubDNN;
GO

declare @NombrePaginaPadre as nvarchar(50) = 'Mantenimiento'
declare @TabIdMantenimientos as int = (SELECT TabId FROM dnn_tabs WHERE TabName = @NombrePaginaPadre AND [Level] = 0)
declare @PortalId as int = 0
declare @UserIdHost as int = 1
declare @RoleIdHost as int = -2
declare @RoleIdAdministrador as int = 0 -- OLL en GA no quiero que lo vean los Administradores, solo Host, Sino pondría el 5
declare @NivelEditores as int = 1
declare @Fecha as datetime = GetDate()
declare @SkinSrc as nvarchar(100) = '[G]Skins/Porto/CollectorsClub-Inner.ascx'

declare @TabContentItemId as int
declare @TabId as int
declare @PackageId as int
declare @DesktopModuleContentItemId as int
declare @DesktopModuleId as int
declare @ModuleDefinitionId as int
declare @PortalDesktopModuleId as int
declare @ModuleContentItemId as int
declare @ModuleId as int
declare @TabModuleId as int


if not exists(SELECT ContentItemId FROM dnn_ContentItems WHERE Content = 'CategoriasFotos')
begin 
	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('CategoriasFotos', 1, -1, -1, null, 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @TabContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_Tabs (ContainerSrc, ContentItemID, CreatedByUserID, CreatedOnDate, CultureCode, DefaultLanguageGuid, Description, DisableLink, EndDate, IconFile, IconFileLarge, IsDeleted, IsSecure, IsVisible, KeyWords, LastModifiedByUserID, LastModifiedOnDate, Level, LocalizedVersionGuid, PageHeadText, ParentId, PermanentRedirect, PortalID, RefreshInterval, SiteMapPriority, SkinSrc, StartDate, TabName, TabOrder, TabPath, Title, UniqueId, Url, VersionGuid, HasBeenPublished, IsSystem)
	VALUES (null, @TabContentItemId, @UserIdHost, @Fecha, null, null, '', 0, null, '', '', 0, 0, 1, '', @UserIdHost, @Fecha, @NivelEditores, NewId(), null, @TabIdMantenimientos, 0, @PortalId, null, 0.5, @SkinSrc, null, 'CategoriasFotos', 3, '//' + @NombrePaginaPadre + '//CategoriasFotos', '', NewId(), '', NewId(), 1, 0)

	set @TabId = SCOPE_IDENTITY()

	UPDATE dnn_ContentItems SET TabId = @TabId WHERE ContentItemID = @TabContentItemId

	INSERT INTO dnn_TabSettings (TabID, SettingName, SettingValue, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 'AllowIndex', 'True', @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabSettings (TabID, SettingName, SettingValue, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 'LinkNewWindow', 'False', @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 3, 1, @RoleIdHost, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 4, 1, @RoleIdHost, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 3, 1, @RoleIdAdministrador, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	INSERT INTO dnn_Packages (
		CreatedByUserID, 
		CreatedOnDate, 
		Description, 
		Email, 
		FriendlyName, 
		IsSystemPackage, 
		LastModifiedByUserID, 
		LastModifiedOnDate, 
		License, 
		Manifest, 
		Name, 
		Organization, 
		Owner,
		PackageType, 
		PortalID, 
		ReleaseNotes, 
		Url, 
		Version
	) VALUES (
		@UserIdHost, 
		@Fecha, 
		'Mantenimiento CategoriasFotos', 
		'', 
		'Mantenimiento CategoriasFotos', 
		0, 
		@UserIdHost, 
		@Fecha, 
		'El archivo de instalación no contiene información de la licencia. Verifique con el vendedor los detalles de la licencia.', 
		'<package name="CollectorsClub.EditorCategoriasFotos" type="Module" version="1.0.0">
		<friendlyName>CollectorsClub - Mantenimiento CategoriasFotos</friendlyName>
		<description>CollectorsClub - Mantenimiento CategoriasFotos</description>
		<iconFile />
		<owner>
			<name>CollectorsClub</name>
			<organization />
			<url />
			<email />
		</owner>
		<license>El archivo de instalación no contiene información de la licencia. Verifique con el vendedor los detalles de la licencia.</license>
		<releaseNotes />
		<components>
			<component type="Module">
				<desktopModule>
					<moduleName>CollectorsClub.EditorCategoriasFotos</moduleName>
					<foldername>CollectorsClub.EditorCategoriasFotos</foldername>
					<businessControllerClass />
					<supportedFeatures />
					<moduleDefinitions>
						<moduleDefinition>
							<friendlyName>CollectorsClub - Mantenimiento CategoriasFotos</friendlyName>
							<definitionName>CollectorsClub - Mantenimiento CategoriasFotos</definitionName>
							<defaultCacheTime>0</defaultCacheTime>
							<moduleControls>
								<moduleControl>
									<controlKey />
									<controlSrc>DesktopModules/CollectorsClub/Editores/CategoriaFotoEditorView.ascx</controlSrc>
									<supportsPartialRendering>False</supportsPartialRendering>
									<controlTitle />
									<controlType>View</controlType>
									<iconFile />
									<helpUrl />
									<supportsPopUps>False</supportsPopUps>
									<viewOrder>0</viewOrder>
								</moduleControl>
							</moduleControls>
						</moduleDefinition>
					</moduleDefinitions>
				</desktopModule>
			</component>
			<component type="File">
				<files>
					<basePath>DesktopModules\CollectorsClub\Editores</basePath>
					<file>
						<name>CategoriaFotoEditorView.ascx</name>
						<sourceFileName>CategoriaFotoEditorView.ascx</sourceFileName>
					</file>
				</files>
			</component>
		</components>
	</package>', 
		'CollectorsClub.EditorCategoriasFotos', 
		'', 
		'CollectorsClub',
		'Module', 
		@PortalId, 
		'Este paquete no tiene notas de la versión', 
		'', 
		'1.0.0'
	)
	set @PackageId = SCOPE_IDENTITY()

	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Mantenimiento CategoriasFotos', 3, -1, -1, '', 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @DesktopModuleContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_DesktopModules (BusinessControllerClass, CompatibleVersions, ContentItemId, CreatedByUserID, CreatedOnDate, Dependencies, Description, FolderName, FriendlyName, IsAdmin, IsPremium, LastModifiedByUserID, LastModifiedOnDate, ModuleName, PackageID, Permissions, Shareable, SupportedFeatures, Version)
	VALUES ('', null, @DesktopModuleContentItemId, @UserIdHost, @Fecha, null, 'Mantenimiento CategoriasFotos', 'CollectorsClub.EditorCategoriasFotos', 'Mantenimiento CategoriasFotos', 0, 0, @UserIdHost, @Fecha, 'CollectorsClub.EditorCategoriasFotos', @PackageId, null, 0, 0, '01.00.00')

	set @DesktopModuleId = SCOPE_IDENTITY()

	INSERT INTO dnn_ModuleDefinitions (CreatedByUserID, CreatedOnDate, DefaultCacheTime, DefinitionName, DesktopModuleID, FriendlyName, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@UserIdHost, @Fecha, 0, 'Mantenimiento CategoriasFotos', @DesktopModuleId, 'Mantenimiento CategoriasFotos', @UserIdHost, @Fecha)

	set @ModuleDefinitionId = SCOPE_IDENTITY()

	INSERT INTO dnn_PortalDesktopModules (CreatedByUserID, CreatedOnDate, DesktopModuleID, LastModifiedByUserID, LastModifiedOnDate, PortalID)
	VALUES (@UserIdHost, @Fecha, @DesktopModuleId, @UserIdHost, @Fecha, @PortalId)

	set @PortalDesktopModuleId = SCOPE_IDENTITY()

	INSERT INTO dnn_DesktopModulePermission (AllowAccess, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, PermissionID, PortalDesktopModuleID, RoleID, UserID)
	VALUES (1, @UserIdHost, @Fecha, @UserIdHost, @Fecha, 7, @PortalDesktopModuleId, @RoleIdHost, null)

	INSERT INTO dnn_ModuleControls (ControlKey, ControlSrc, ControlTitle, ControlType, CreatedByUserID, CreatedOnDate, HelpUrl, IconFile, LastModifiedByUserID, LastModifiedOnDate, ModuleDefID, SupportsPartialRendering, SupportsPopUps, ViewOrder)
	VALUES (null, 'DesktopModules/CollectorsClub/Editores/CategoriaFotoEditorView.ascx', null, 0, @UserIdHost, @Fecha, null, null, @UserIdHost, @Fecha, @ModuleDefinitionId, 0, 0, 0)

	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Mantenimiento CategoriasFotos', 2, @TabId, -1, null, 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @ModuleContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_Modules (AllTabs, ContentItemID, CreatedByUserID, CreatedOnDate, EndDate, InheritViewPermissions, IsDeleted, IsShareable, IsShareableViewOnly, LastContentModifiedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleDefID, PortalID, StartDate)
	VALUES (0, @ModuleContentItemId, @UserIdHost, @Fecha, null, 1, 0, 1, 1, null, @UserIdHost, @Fecha, @ModuleDefinitionId, @PortalId, null)

	set @ModuleId = SCOPE_IDENTITY()

	UPDATE dnn_ContentItems SET ModuleId = @ModuleId WHERE ContentItemID = @ModuleContentItemId

	INSERT INTO dnn_TabModules (Alignment, Border, CacheMethod, CacheTime, Color, ContainerSrc, CreatedByUserID, CreatedOnDate, CultureCode, DefaultLanguageGuid, DisplayPrint, DisplaySyndicate, DisplayTitle, Footer, Header, IconFile, IsDeleted, IsWebSlice,LastModifiedByUserID, LastModifiedOnDate, LocalizedVersionGuid, ModuleID, ModuleOrder, ModuleTitle, PaneName, TabID, UniqueId, VersionGuid, Visibility, WebSliceExpiryDate, WebSliceTitle, WebSliceTTL)
	VALUES (null, null, null, 0, null, null, @UserIdHost, @Fecha, '', null, 0, 0, 0, null, null, null, 0, 0, @UserIdHost, @Fecha, NewId(), @ModuleId, 3, 'Mantenimiento CategoriasFotos', 'ContentPane', @TabId, NewId(), NewId(), 2, null, '', 0)

	set @TabModuleId = SCOPE_IDENTITY()

	-- DNN No le crea ningún permiso
	--INSERT INTO dnn_TabModuleSettings (CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, SettingName, SettingValue, TabModuleID)
	--VALUES (@UserIdHost, @Fecha, @UserIdHost, @Fecha, '', '', @TabModuleId)

	INSERT INTO dnn_ModulePermission (AllowAccess, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleID, PermissionID, PortalID, RoleID, UserID)
	VALUES (1, @UserIdHost, @Fecha, @UserIdHost, @Fecha, @ModuleId, 2, @PortalId, @RoleIdHost, null)

	-- DNN No le crea ningún permiso
	--INSERT INTO dnn_ModuleSettings (CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleID, SettingName, SettingValue) 
	--VALUES (@UserIdHost, @Fecha, @UserIdHost, @Fecha, @ModuleId, '', '') 
end
------------------------------- Fin script del módulo CategoriasFotos  ------------------------------

------------------------------- Inicio script del módulo CategoriasFotos_Idiomas  ------------------------------
USE CollectorsClubDNN;
GO

declare @NombrePaginaPadre as nvarchar(50) = 'Mantenimiento'
declare @TabIdMantenimientos as int = (SELECT TabId FROM dnn_tabs WHERE TabName = @NombrePaginaPadre AND [Level] = 0)
declare @PortalId as int = 0
declare @UserIdHost as int = 1
declare @RoleIdHost as int = -2
declare @RoleIdAdministrador as int = 0 -- OLL en GA no quiero que lo vean los Administradores, solo Host, Sino pondría el 5
declare @NivelEditores as int = 1
declare @Fecha as datetime = GetDate()
declare @SkinSrc as nvarchar(100) = '[G]Skins/Porto/CollectorsClub-Inner.ascx'

declare @TabContentItemId as int
declare @TabId as int
declare @PackageId as int
declare @DesktopModuleContentItemId as int
declare @DesktopModuleId as int
declare @ModuleDefinitionId as int
declare @PortalDesktopModuleId as int
declare @ModuleContentItemId as int
declare @ModuleId as int
declare @TabModuleId as int


if not exists(SELECT ContentItemId FROM dnn_ContentItems WHERE Content = 'CategoriasFotos_Idiomas')
begin 
	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('CategoriasFotos_Idiomas', 1, -1, -1, null, 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @TabContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_Tabs (ContainerSrc, ContentItemID, CreatedByUserID, CreatedOnDate, CultureCode, DefaultLanguageGuid, Description, DisableLink, EndDate, IconFile, IconFileLarge, IsDeleted, IsSecure, IsVisible, KeyWords, LastModifiedByUserID, LastModifiedOnDate, Level, LocalizedVersionGuid, PageHeadText, ParentId, PermanentRedirect, PortalID, RefreshInterval, SiteMapPriority, SkinSrc, StartDate, TabName, TabOrder, TabPath, Title, UniqueId, Url, VersionGuid, HasBeenPublished, IsSystem)
	VALUES (null, @TabContentItemId, @UserIdHost, @Fecha, null, null, '', 0, null, '', '', 0, 0, 1, '', @UserIdHost, @Fecha, @NivelEditores, NewId(), null, @TabIdMantenimientos, 0, @PortalId, null, 0.5, @SkinSrc, null, 'CategoriasFotos_Idiomas', 3, '//' + @NombrePaginaPadre + '//CategoriasFotos_Idiomas', '', NewId(), '', NewId(), 1, 0)

	set @TabId = SCOPE_IDENTITY()

	UPDATE dnn_ContentItems SET TabId = @TabId WHERE ContentItemID = @TabContentItemId

	INSERT INTO dnn_TabSettings (TabID, SettingName, SettingValue, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 'AllowIndex', 'True', @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabSettings (TabID, SettingName, SettingValue, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 'LinkNewWindow', 'False', @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 3, 1, @RoleIdHost, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 4, 1, @RoleIdHost, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 3, 1, @RoleIdAdministrador, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	INSERT INTO dnn_Packages (
		CreatedByUserID, 
		CreatedOnDate, 
		Description, 
		Email, 
		FriendlyName, 
		IsSystemPackage, 
		LastModifiedByUserID, 
		LastModifiedOnDate, 
		License, 
		Manifest, 
		Name, 
		Organization, 
		Owner,
		PackageType, 
		PortalID, 
		ReleaseNotes, 
		Url, 
		Version
	) VALUES (
		@UserIdHost, 
		@Fecha, 
		'Mantenimiento CategoriasFotos_Idiomas', 
		'', 
		'Mantenimiento CategoriasFotos_Idiomas', 
		0, 
		@UserIdHost, 
		@Fecha, 
		'El archivo de instalación no contiene información de la licencia. Verifique con el vendedor los detalles de la licencia.', 
		'<package name="CollectorsClub.EditorCategoriasFotos_Idiomas" type="Module" version="1.0.0">
		<friendlyName>CollectorsClub - Mantenimiento CategoriasFotos_Idiomas</friendlyName>
		<description>CollectorsClub - Mantenimiento CategoriasFotos_Idiomas</description>
		<iconFile />
		<owner>
			<name>CollectorsClub</name>
			<organization />
			<url />
			<email />
		</owner>
		<license>El archivo de instalación no contiene información de la licencia. Verifique con el vendedor los detalles de la licencia.</license>
		<releaseNotes />
		<components>
			<component type="Module">
				<desktopModule>
					<moduleName>CollectorsClub.EditorCategoriasFotos_Idiomas</moduleName>
					<foldername>CollectorsClub.EditorCategoriasFotos_Idiomas</foldername>
					<businessControllerClass />
					<supportedFeatures />
					<moduleDefinitions>
						<moduleDefinition>
							<friendlyName>CollectorsClub - Mantenimiento CategoriasFotos_Idiomas</friendlyName>
							<definitionName>CollectorsClub - Mantenimiento CategoriasFotos_Idiomas</definitionName>
							<defaultCacheTime>0</defaultCacheTime>
							<moduleControls>
								<moduleControl>
									<controlKey />
									<controlSrc>DesktopModules/CollectorsClub/Editores/CategoriaFoto_IdiomaEditorView.ascx</controlSrc>
									<supportsPartialRendering>False</supportsPartialRendering>
									<controlTitle />
									<controlType>View</controlType>
									<iconFile />
									<helpUrl />
									<supportsPopUps>False</supportsPopUps>
									<viewOrder>0</viewOrder>
								</moduleControl>
							</moduleControls>
						</moduleDefinition>
					</moduleDefinitions>
				</desktopModule>
			</component>
			<component type="File">
				<files>
					<basePath>DesktopModules\CollectorsClub\Editores</basePath>
					<file>
						<name>CategoriaFoto_IdiomaEditorView.ascx</name>
						<sourceFileName>CategoriaFoto_IdiomaEditorView.ascx</sourceFileName>
					</file>
				</files>
			</component>
		</components>
	</package>', 
		'CollectorsClub.EditorCategoriasFotos_Idiomas', 
		'', 
		'CollectorsClub',
		'Module', 
		@PortalId, 
		'Este paquete no tiene notas de la versión', 
		'', 
		'1.0.0'
	)
	set @PackageId = SCOPE_IDENTITY()

	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Mantenimiento CategoriasFotos_Idiomas', 3, -1, -1, '', 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @DesktopModuleContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_DesktopModules (BusinessControllerClass, CompatibleVersions, ContentItemId, CreatedByUserID, CreatedOnDate, Dependencies, Description, FolderName, FriendlyName, IsAdmin, IsPremium, LastModifiedByUserID, LastModifiedOnDate, ModuleName, PackageID, Permissions, Shareable, SupportedFeatures, Version)
	VALUES ('', null, @DesktopModuleContentItemId, @UserIdHost, @Fecha, null, 'Mantenimiento CategoriasFotos_Idiomas', 'CollectorsClub.EditorCategoriasFotos_Idiomas', 'Mantenimiento CategoriasFotos_Idiomas', 0, 0, @UserIdHost, @Fecha, 'CollectorsClub.EditorCategoriasFotos_Idiomas', @PackageId, null, 0, 0, '01.00.00')

	set @DesktopModuleId = SCOPE_IDENTITY()

	INSERT INTO dnn_ModuleDefinitions (CreatedByUserID, CreatedOnDate, DefaultCacheTime, DefinitionName, DesktopModuleID, FriendlyName, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@UserIdHost, @Fecha, 0, 'Mantenimiento CategoriasFotos_Idiomas', @DesktopModuleId, 'Mantenimiento CategoriasFotos_Idiomas', @UserIdHost, @Fecha)

	set @ModuleDefinitionId = SCOPE_IDENTITY()

	INSERT INTO dnn_PortalDesktopModules (CreatedByUserID, CreatedOnDate, DesktopModuleID, LastModifiedByUserID, LastModifiedOnDate, PortalID)
	VALUES (@UserIdHost, @Fecha, @DesktopModuleId, @UserIdHost, @Fecha, @PortalId)

	set @PortalDesktopModuleId = SCOPE_IDENTITY()

	INSERT INTO dnn_DesktopModulePermission (AllowAccess, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, PermissionID, PortalDesktopModuleID, RoleID, UserID)
	VALUES (1, @UserIdHost, @Fecha, @UserIdHost, @Fecha, 7, @PortalDesktopModuleId, @RoleIdHost, null)

	INSERT INTO dnn_ModuleControls (ControlKey, ControlSrc, ControlTitle, ControlType, CreatedByUserID, CreatedOnDate, HelpUrl, IconFile, LastModifiedByUserID, LastModifiedOnDate, ModuleDefID, SupportsPartialRendering, SupportsPopUps, ViewOrder)
	VALUES (null, 'DesktopModules/CollectorsClub/Editores/CategoriaFoto_IdiomaEditorView.ascx', null, 0, @UserIdHost, @Fecha, null, null, @UserIdHost, @Fecha, @ModuleDefinitionId, 0, 0, 0)

	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Mantenimiento CategoriasFotos_Idiomas', 2, @TabId, -1, null, 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @ModuleContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_Modules (AllTabs, ContentItemID, CreatedByUserID, CreatedOnDate, EndDate, InheritViewPermissions, IsDeleted, IsShareable, IsShareableViewOnly, LastContentModifiedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleDefID, PortalID, StartDate)
	VALUES (0, @ModuleContentItemId, @UserIdHost, @Fecha, null, 1, 0, 1, 1, null, @UserIdHost, @Fecha, @ModuleDefinitionId, @PortalId, null)

	set @ModuleId = SCOPE_IDENTITY()

	UPDATE dnn_ContentItems SET ModuleId = @ModuleId WHERE ContentItemID = @ModuleContentItemId

	INSERT INTO dnn_TabModules (Alignment, Border, CacheMethod, CacheTime, Color, ContainerSrc, CreatedByUserID, CreatedOnDate, CultureCode, DefaultLanguageGuid, DisplayPrint, DisplaySyndicate, DisplayTitle, Footer, Header, IconFile, IsDeleted, IsWebSlice,LastModifiedByUserID, LastModifiedOnDate, LocalizedVersionGuid, ModuleID, ModuleOrder, ModuleTitle, PaneName, TabID, UniqueId, VersionGuid, Visibility, WebSliceExpiryDate, WebSliceTitle, WebSliceTTL)
	VALUES (null, null, null, 0, null, null, @UserIdHost, @Fecha, '', null, 0, 0, 0, null, null, null, 0, 0, @UserIdHost, @Fecha, NewId(), @ModuleId, 3, 'Mantenimiento CategoriasFotos_Idiomas', 'ContentPane', @TabId, NewId(), NewId(), 2, null, '', 0)

	set @TabModuleId = SCOPE_IDENTITY()

	-- DNN No le crea ningún permiso
	--INSERT INTO dnn_TabModuleSettings (CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, SettingName, SettingValue, TabModuleID)
	--VALUES (@UserIdHost, @Fecha, @UserIdHost, @Fecha, '', '', @TabModuleId)

	INSERT INTO dnn_ModulePermission (AllowAccess, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleID, PermissionID, PortalID, RoleID, UserID)
	VALUES (1, @UserIdHost, @Fecha, @UserIdHost, @Fecha, @ModuleId, 2, @PortalId, @RoleIdHost, null)

	-- DNN No le crea ningún permiso
	--INSERT INTO dnn_ModuleSettings (CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleID, SettingName, SettingValue) 
	--VALUES (@UserIdHost, @Fecha, @UserIdHost, @Fecha, @ModuleId, '', '') 
end
------------------------------- Fin script del módulo CategoriasFotos_Idiomas  ------------------------------

------------------------------- Inicio script del módulo Entidades  ------------------------------
USE CollectorsClubDNN;
GO

declare @NombrePaginaPadre as nvarchar(50) = 'Mantenimiento'
declare @TabIdMantenimientos as int = (SELECT TabId FROM dnn_tabs WHERE TabName = @NombrePaginaPadre AND [Level] = 0)
declare @PortalId as int = 0
declare @UserIdHost as int = 1
declare @RoleIdHost as int = -2
declare @RoleIdAdministrador as int = 0 -- OLL en GA no quiero que lo vean los Administradores, solo Host, Sino pondría el 5
declare @NivelEditores as int = 1
declare @Fecha as datetime = GetDate()
declare @SkinSrc as nvarchar(100) = '[G]Skins/Porto/CollectorsClub-Inner.ascx'

declare @TabContentItemId as int
declare @TabId as int
declare @PackageId as int
declare @DesktopModuleContentItemId as int
declare @DesktopModuleId as int
declare @ModuleDefinitionId as int
declare @PortalDesktopModuleId as int
declare @ModuleContentItemId as int
declare @ModuleId as int
declare @TabModuleId as int


if not exists(SELECT ContentItemId FROM dnn_ContentItems WHERE Content = 'Entidades')
begin 
	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Entidades', 1, -1, -1, null, 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @TabContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_Tabs (ContainerSrc, ContentItemID, CreatedByUserID, CreatedOnDate, CultureCode, DefaultLanguageGuid, Description, DisableLink, EndDate, IconFile, IconFileLarge, IsDeleted, IsSecure, IsVisible, KeyWords, LastModifiedByUserID, LastModifiedOnDate, Level, LocalizedVersionGuid, PageHeadText, ParentId, PermanentRedirect, PortalID, RefreshInterval, SiteMapPriority, SkinSrc, StartDate, TabName, TabOrder, TabPath, Title, UniqueId, Url, VersionGuid, HasBeenPublished, IsSystem)
	VALUES (null, @TabContentItemId, @UserIdHost, @Fecha, null, null, '', 0, null, '', '', 0, 0, 1, '', @UserIdHost, @Fecha, @NivelEditores, NewId(), null, @TabIdMantenimientos, 0, @PortalId, null, 0.5, @SkinSrc, null, 'Entidades', 3, '//' + @NombrePaginaPadre + '//Entidades', '', NewId(), '', NewId(), 1, 0)

	set @TabId = SCOPE_IDENTITY()

	UPDATE dnn_ContentItems SET TabId = @TabId WHERE ContentItemID = @TabContentItemId

	INSERT INTO dnn_TabSettings (TabID, SettingName, SettingValue, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 'AllowIndex', 'True', @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabSettings (TabID, SettingName, SettingValue, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 'LinkNewWindow', 'False', @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 3, 1, @RoleIdHost, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 4, 1, @RoleIdHost, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 3, 1, @RoleIdAdministrador, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	INSERT INTO dnn_Packages (
		CreatedByUserID, 
		CreatedOnDate, 
		Description, 
		Email, 
		FriendlyName, 
		IsSystemPackage, 
		LastModifiedByUserID, 
		LastModifiedOnDate, 
		License, 
		Manifest, 
		Name, 
		Organization, 
		Owner,
		PackageType, 
		PortalID, 
		ReleaseNotes, 
		Url, 
		Version
	) VALUES (
		@UserIdHost, 
		@Fecha, 
		'Mantenimiento Entidades', 
		'', 
		'Mantenimiento Entidades', 
		0, 
		@UserIdHost, 
		@Fecha, 
		'El archivo de instalación no contiene información de la licencia. Verifique con el vendedor los detalles de la licencia.', 
		'<package name="CollectorsClub.EditorEntidades" type="Module" version="1.0.0">
		<friendlyName>CollectorsClub - Mantenimiento Entidades</friendlyName>
		<description>CollectorsClub - Mantenimiento Entidades</description>
		<iconFile />
		<owner>
			<name>CollectorsClub</name>
			<organization />
			<url />
			<email />
		</owner>
		<license>El archivo de instalación no contiene información de la licencia. Verifique con el vendedor los detalles de la licencia.</license>
		<releaseNotes />
		<components>
			<component type="Module">
				<desktopModule>
					<moduleName>CollectorsClub.EditorEntidades</moduleName>
					<foldername>CollectorsClub.EditorEntidades</foldername>
					<businessControllerClass />
					<supportedFeatures />
					<moduleDefinitions>
						<moduleDefinition>
							<friendlyName>CollectorsClub - Mantenimiento Entidades</friendlyName>
							<definitionName>CollectorsClub - Mantenimiento Entidades</definitionName>
							<defaultCacheTime>0</defaultCacheTime>
							<moduleControls>
								<moduleControl>
									<controlKey />
									<controlSrc>DesktopModules/CollectorsClub/Editores/EntidadEditorView.ascx</controlSrc>
									<supportsPartialRendering>False</supportsPartialRendering>
									<controlTitle />
									<controlType>View</controlType>
									<iconFile />
									<helpUrl />
									<supportsPopUps>False</supportsPopUps>
									<viewOrder>0</viewOrder>
								</moduleControl>
							</moduleControls>
						</moduleDefinition>
					</moduleDefinitions>
				</desktopModule>
			</component>
			<component type="File">
				<files>
					<basePath>DesktopModules\CollectorsClub\Editores</basePath>
					<file>
						<name>EntidadEditorView.ascx</name>
						<sourceFileName>EntidadEditorView.ascx</sourceFileName>
					</file>
				</files>
			</component>
		</components>
	</package>', 
		'CollectorsClub.EditorEntidades', 
		'', 
		'CollectorsClub',
		'Module', 
		@PortalId, 
		'Este paquete no tiene notas de la versión', 
		'', 
		'1.0.0'
	)
	set @PackageId = SCOPE_IDENTITY()

	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Mantenimiento Entidades', 3, -1, -1, '', 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @DesktopModuleContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_DesktopModules (BusinessControllerClass, CompatibleVersions, ContentItemId, CreatedByUserID, CreatedOnDate, Dependencies, Description, FolderName, FriendlyName, IsAdmin, IsPremium, LastModifiedByUserID, LastModifiedOnDate, ModuleName, PackageID, Permissions, Shareable, SupportedFeatures, Version)
	VALUES ('', null, @DesktopModuleContentItemId, @UserIdHost, @Fecha, null, 'Mantenimiento Entidades', 'CollectorsClub.EditorEntidades', 'Mantenimiento Entidades', 0, 0, @UserIdHost, @Fecha, 'CollectorsClub.EditorEntidades', @PackageId, null, 0, 0, '01.00.00')

	set @DesktopModuleId = SCOPE_IDENTITY()

	INSERT INTO dnn_ModuleDefinitions (CreatedByUserID, CreatedOnDate, DefaultCacheTime, DefinitionName, DesktopModuleID, FriendlyName, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@UserIdHost, @Fecha, 0, 'Mantenimiento Entidades', @DesktopModuleId, 'Mantenimiento Entidades', @UserIdHost, @Fecha)

	set @ModuleDefinitionId = SCOPE_IDENTITY()

	INSERT INTO dnn_PortalDesktopModules (CreatedByUserID, CreatedOnDate, DesktopModuleID, LastModifiedByUserID, LastModifiedOnDate, PortalID)
	VALUES (@UserIdHost, @Fecha, @DesktopModuleId, @UserIdHost, @Fecha, @PortalId)

	set @PortalDesktopModuleId = SCOPE_IDENTITY()

	INSERT INTO dnn_DesktopModulePermission (AllowAccess, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, PermissionID, PortalDesktopModuleID, RoleID, UserID)
	VALUES (1, @UserIdHost, @Fecha, @UserIdHost, @Fecha, 7, @PortalDesktopModuleId, @RoleIdHost, null)

	INSERT INTO dnn_ModuleControls (ControlKey, ControlSrc, ControlTitle, ControlType, CreatedByUserID, CreatedOnDate, HelpUrl, IconFile, LastModifiedByUserID, LastModifiedOnDate, ModuleDefID, SupportsPartialRendering, SupportsPopUps, ViewOrder)
	VALUES (null, 'DesktopModules/CollectorsClub/Editores/EntidadEditorView.ascx', null, 0, @UserIdHost, @Fecha, null, null, @UserIdHost, @Fecha, @ModuleDefinitionId, 0, 0, 0)

	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Mantenimiento Entidades', 2, @TabId, -1, null, 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @ModuleContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_Modules (AllTabs, ContentItemID, CreatedByUserID, CreatedOnDate, EndDate, InheritViewPermissions, IsDeleted, IsShareable, IsShareableViewOnly, LastContentModifiedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleDefID, PortalID, StartDate)
	VALUES (0, @ModuleContentItemId, @UserIdHost, @Fecha, null, 1, 0, 1, 1, null, @UserIdHost, @Fecha, @ModuleDefinitionId, @PortalId, null)

	set @ModuleId = SCOPE_IDENTITY()

	UPDATE dnn_ContentItems SET ModuleId = @ModuleId WHERE ContentItemID = @ModuleContentItemId

	INSERT INTO dnn_TabModules (Alignment, Border, CacheMethod, CacheTime, Color, ContainerSrc, CreatedByUserID, CreatedOnDate, CultureCode, DefaultLanguageGuid, DisplayPrint, DisplaySyndicate, DisplayTitle, Footer, Header, IconFile, IsDeleted, IsWebSlice,LastModifiedByUserID, LastModifiedOnDate, LocalizedVersionGuid, ModuleID, ModuleOrder, ModuleTitle, PaneName, TabID, UniqueId, VersionGuid, Visibility, WebSliceExpiryDate, WebSliceTitle, WebSliceTTL)
	VALUES (null, null, null, 0, null, null, @UserIdHost, @Fecha, '', null, 0, 0, 0, null, null, null, 0, 0, @UserIdHost, @Fecha, NewId(), @ModuleId, 3, 'Mantenimiento Entidades', 'ContentPane', @TabId, NewId(), NewId(), 2, null, '', 0)

	set @TabModuleId = SCOPE_IDENTITY()

	-- DNN No le crea ningún permiso
	--INSERT INTO dnn_TabModuleSettings (CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, SettingName, SettingValue, TabModuleID)
	--VALUES (@UserIdHost, @Fecha, @UserIdHost, @Fecha, '', '', @TabModuleId)

	INSERT INTO dnn_ModulePermission (AllowAccess, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleID, PermissionID, PortalID, RoleID, UserID)
	VALUES (1, @UserIdHost, @Fecha, @UserIdHost, @Fecha, @ModuleId, 2, @PortalId, @RoleIdHost, null)

	-- DNN No le crea ningún permiso
	--INSERT INTO dnn_ModuleSettings (CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleID, SettingName, SettingValue) 
	--VALUES (@UserIdHost, @Fecha, @UserIdHost, @Fecha, @ModuleId, '', '') 
end
------------------------------- Fin script del módulo Entidades  ------------------------------

------------------------------- Inicio script del módulo Entidades_Idiomas  ------------------------------
USE CollectorsClubDNN;
GO

declare @NombrePaginaPadre as nvarchar(50) = 'Mantenimiento'
declare @TabIdMantenimientos as int = (SELECT TabId FROM dnn_tabs WHERE TabName = @NombrePaginaPadre AND [Level] = 0)
declare @PortalId as int = 0
declare @UserIdHost as int = 1
declare @RoleIdHost as int = -2
declare @RoleIdAdministrador as int = 0 -- OLL en GA no quiero que lo vean los Administradores, solo Host, Sino pondría el 5
declare @NivelEditores as int = 1
declare @Fecha as datetime = GetDate()
declare @SkinSrc as nvarchar(100) = '[G]Skins/Porto/CollectorsClub-Inner.ascx'

declare @TabContentItemId as int
declare @TabId as int
declare @PackageId as int
declare @DesktopModuleContentItemId as int
declare @DesktopModuleId as int
declare @ModuleDefinitionId as int
declare @PortalDesktopModuleId as int
declare @ModuleContentItemId as int
declare @ModuleId as int
declare @TabModuleId as int


if not exists(SELECT ContentItemId FROM dnn_ContentItems WHERE Content = 'Entidades_Idiomas')
begin 
	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Entidades_Idiomas', 1, -1, -1, null, 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @TabContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_Tabs (ContainerSrc, ContentItemID, CreatedByUserID, CreatedOnDate, CultureCode, DefaultLanguageGuid, Description, DisableLink, EndDate, IconFile, IconFileLarge, IsDeleted, IsSecure, IsVisible, KeyWords, LastModifiedByUserID, LastModifiedOnDate, Level, LocalizedVersionGuid, PageHeadText, ParentId, PermanentRedirect, PortalID, RefreshInterval, SiteMapPriority, SkinSrc, StartDate, TabName, TabOrder, TabPath, Title, UniqueId, Url, VersionGuid, HasBeenPublished, IsSystem)
	VALUES (null, @TabContentItemId, @UserIdHost, @Fecha, null, null, '', 0, null, '', '', 0, 0, 1, '', @UserIdHost, @Fecha, @NivelEditores, NewId(), null, @TabIdMantenimientos, 0, @PortalId, null, 0.5, @SkinSrc, null, 'Entidades_Idiomas', 3, '//' + @NombrePaginaPadre + '//Entidades_Idiomas', '', NewId(), '', NewId(), 1, 0)

	set @TabId = SCOPE_IDENTITY()

	UPDATE dnn_ContentItems SET TabId = @TabId WHERE ContentItemID = @TabContentItemId

	INSERT INTO dnn_TabSettings (TabID, SettingName, SettingValue, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 'AllowIndex', 'True', @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabSettings (TabID, SettingName, SettingValue, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 'LinkNewWindow', 'False', @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 3, 1, @RoleIdHost, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 4, 1, @RoleIdHost, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 3, 1, @RoleIdAdministrador, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	INSERT INTO dnn_Packages (
		CreatedByUserID, 
		CreatedOnDate, 
		Description, 
		Email, 
		FriendlyName, 
		IsSystemPackage, 
		LastModifiedByUserID, 
		LastModifiedOnDate, 
		License, 
		Manifest, 
		Name, 
		Organization, 
		Owner,
		PackageType, 
		PortalID, 
		ReleaseNotes, 
		Url, 
		Version
	) VALUES (
		@UserIdHost, 
		@Fecha, 
		'Mantenimiento Entidades_Idiomas', 
		'', 
		'Mantenimiento Entidades_Idiomas', 
		0, 
		@UserIdHost, 
		@Fecha, 
		'El archivo de instalación no contiene información de la licencia. Verifique con el vendedor los detalles de la licencia.', 
		'<package name="CollectorsClub.EditorEntidades_Idiomas" type="Module" version="1.0.0">
		<friendlyName>CollectorsClub - Mantenimiento Entidades_Idiomas</friendlyName>
		<description>CollectorsClub - Mantenimiento Entidades_Idiomas</description>
		<iconFile />
		<owner>
			<name>CollectorsClub</name>
			<organization />
			<url />
			<email />
		</owner>
		<license>El archivo de instalación no contiene información de la licencia. Verifique con el vendedor los detalles de la licencia.</license>
		<releaseNotes />
		<components>
			<component type="Module">
				<desktopModule>
					<moduleName>CollectorsClub.EditorEntidades_Idiomas</moduleName>
					<foldername>CollectorsClub.EditorEntidades_Idiomas</foldername>
					<businessControllerClass />
					<supportedFeatures />
					<moduleDefinitions>
						<moduleDefinition>
							<friendlyName>CollectorsClub - Mantenimiento Entidades_Idiomas</friendlyName>
							<definitionName>CollectorsClub - Mantenimiento Entidades_Idiomas</definitionName>
							<defaultCacheTime>0</defaultCacheTime>
							<moduleControls>
								<moduleControl>
									<controlKey />
									<controlSrc>DesktopModules/CollectorsClub/Editores/Entidad_IdiomaEditorView.ascx</controlSrc>
									<supportsPartialRendering>False</supportsPartialRendering>
									<controlTitle />
									<controlType>View</controlType>
									<iconFile />
									<helpUrl />
									<supportsPopUps>False</supportsPopUps>
									<viewOrder>0</viewOrder>
								</moduleControl>
							</moduleControls>
						</moduleDefinition>
					</moduleDefinitions>
				</desktopModule>
			</component>
			<component type="File">
				<files>
					<basePath>DesktopModules\CollectorsClub\Editores</basePath>
					<file>
						<name>Entidad_IdiomaEditorView.ascx</name>
						<sourceFileName>Entidad_IdiomaEditorView.ascx</sourceFileName>
					</file>
				</files>
			</component>
		</components>
	</package>', 
		'CollectorsClub.EditorEntidades_Idiomas', 
		'', 
		'CollectorsClub',
		'Module', 
		@PortalId, 
		'Este paquete no tiene notas de la versión', 
		'', 
		'1.0.0'
	)
	set @PackageId = SCOPE_IDENTITY()

	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Mantenimiento Entidades_Idiomas', 3, -1, -1, '', 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @DesktopModuleContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_DesktopModules (BusinessControllerClass, CompatibleVersions, ContentItemId, CreatedByUserID, CreatedOnDate, Dependencies, Description, FolderName, FriendlyName, IsAdmin, IsPremium, LastModifiedByUserID, LastModifiedOnDate, ModuleName, PackageID, Permissions, Shareable, SupportedFeatures, Version)
	VALUES ('', null, @DesktopModuleContentItemId, @UserIdHost, @Fecha, null, 'Mantenimiento Entidades_Idiomas', 'CollectorsClub.EditorEntidades_Idiomas', 'Mantenimiento Entidades_Idiomas', 0, 0, @UserIdHost, @Fecha, 'CollectorsClub.EditorEntidades_Idiomas', @PackageId, null, 0, 0, '01.00.00')

	set @DesktopModuleId = SCOPE_IDENTITY()

	INSERT INTO dnn_ModuleDefinitions (CreatedByUserID, CreatedOnDate, DefaultCacheTime, DefinitionName, DesktopModuleID, FriendlyName, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@UserIdHost, @Fecha, 0, 'Mantenimiento Entidades_Idiomas', @DesktopModuleId, 'Mantenimiento Entidades_Idiomas', @UserIdHost, @Fecha)

	set @ModuleDefinitionId = SCOPE_IDENTITY()

	INSERT INTO dnn_PortalDesktopModules (CreatedByUserID, CreatedOnDate, DesktopModuleID, LastModifiedByUserID, LastModifiedOnDate, PortalID)
	VALUES (@UserIdHost, @Fecha, @DesktopModuleId, @UserIdHost, @Fecha, @PortalId)

	set @PortalDesktopModuleId = SCOPE_IDENTITY()

	INSERT INTO dnn_DesktopModulePermission (AllowAccess, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, PermissionID, PortalDesktopModuleID, RoleID, UserID)
	VALUES (1, @UserIdHost, @Fecha, @UserIdHost, @Fecha, 7, @PortalDesktopModuleId, @RoleIdHost, null)

	INSERT INTO dnn_ModuleControls (ControlKey, ControlSrc, ControlTitle, ControlType, CreatedByUserID, CreatedOnDate, HelpUrl, IconFile, LastModifiedByUserID, LastModifiedOnDate, ModuleDefID, SupportsPartialRendering, SupportsPopUps, ViewOrder)
	VALUES (null, 'DesktopModules/CollectorsClub/Editores/Entidad_IdiomaEditorView.ascx', null, 0, @UserIdHost, @Fecha, null, null, @UserIdHost, @Fecha, @ModuleDefinitionId, 0, 0, 0)

	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Mantenimiento Entidades_Idiomas', 2, @TabId, -1, null, 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @ModuleContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_Modules (AllTabs, ContentItemID, CreatedByUserID, CreatedOnDate, EndDate, InheritViewPermissions, IsDeleted, IsShareable, IsShareableViewOnly, LastContentModifiedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleDefID, PortalID, StartDate)
	VALUES (0, @ModuleContentItemId, @UserIdHost, @Fecha, null, 1, 0, 1, 1, null, @UserIdHost, @Fecha, @ModuleDefinitionId, @PortalId, null)

	set @ModuleId = SCOPE_IDENTITY()

	UPDATE dnn_ContentItems SET ModuleId = @ModuleId WHERE ContentItemID = @ModuleContentItemId

	INSERT INTO dnn_TabModules (Alignment, Border, CacheMethod, CacheTime, Color, ContainerSrc, CreatedByUserID, CreatedOnDate, CultureCode, DefaultLanguageGuid, DisplayPrint, DisplaySyndicate, DisplayTitle, Footer, Header, IconFile, IsDeleted, IsWebSlice,LastModifiedByUserID, LastModifiedOnDate, LocalizedVersionGuid, ModuleID, ModuleOrder, ModuleTitle, PaneName, TabID, UniqueId, VersionGuid, Visibility, WebSliceExpiryDate, WebSliceTitle, WebSliceTTL)
	VALUES (null, null, null, 0, null, null, @UserIdHost, @Fecha, '', null, 0, 0, 0, null, null, null, 0, 0, @UserIdHost, @Fecha, NewId(), @ModuleId, 3, 'Mantenimiento Entidades_Idiomas', 'ContentPane', @TabId, NewId(), NewId(), 2, null, '', 0)

	set @TabModuleId = SCOPE_IDENTITY()

	-- DNN No le crea ningún permiso
	--INSERT INTO dnn_TabModuleSettings (CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, SettingName, SettingValue, TabModuleID)
	--VALUES (@UserIdHost, @Fecha, @UserIdHost, @Fecha, '', '', @TabModuleId)

	INSERT INTO dnn_ModulePermission (AllowAccess, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleID, PermissionID, PortalID, RoleID, UserID)
	VALUES (1, @UserIdHost, @Fecha, @UserIdHost, @Fecha, @ModuleId, 2, @PortalId, @RoleIdHost, null)

	-- DNN No le crea ningún permiso
	--INSERT INTO dnn_ModuleSettings (CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleID, SettingName, SettingValue) 
	--VALUES (@UserIdHost, @Fecha, @UserIdHost, @Fecha, @ModuleId, '', '') 
end
------------------------------- Fin script del módulo Entidades_Idiomas  ------------------------------

------------------------------- Inicio script del módulo EstadosCalendario  ------------------------------
USE CollectorsClubDNN;
GO

declare @NombrePaginaPadre as nvarchar(50) = 'Mantenimiento'
declare @TabIdMantenimientos as int = (SELECT TabId FROM dnn_tabs WHERE TabName = @NombrePaginaPadre AND [Level] = 0)
declare @PortalId as int = 0
declare @UserIdHost as int = 1
declare @RoleIdHost as int = -2
declare @RoleIdAdministrador as int = 0 -- OLL en GA no quiero que lo vean los Administradores, solo Host, Sino pondría el 5
declare @NivelEditores as int = 1
declare @Fecha as datetime = GetDate()
declare @SkinSrc as nvarchar(100) = '[G]Skins/Porto/CollectorsClub-Inner.ascx'

declare @TabContentItemId as int
declare @TabId as int
declare @PackageId as int
declare @DesktopModuleContentItemId as int
declare @DesktopModuleId as int
declare @ModuleDefinitionId as int
declare @PortalDesktopModuleId as int
declare @ModuleContentItemId as int
declare @ModuleId as int
declare @TabModuleId as int


if not exists(SELECT ContentItemId FROM dnn_ContentItems WHERE Content = 'EstadosCalendario')
begin 
	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('EstadosCalendario', 1, -1, -1, null, 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @TabContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_Tabs (ContainerSrc, ContentItemID, CreatedByUserID, CreatedOnDate, CultureCode, DefaultLanguageGuid, Description, DisableLink, EndDate, IconFile, IconFileLarge, IsDeleted, IsSecure, IsVisible, KeyWords, LastModifiedByUserID, LastModifiedOnDate, Level, LocalizedVersionGuid, PageHeadText, ParentId, PermanentRedirect, PortalID, RefreshInterval, SiteMapPriority, SkinSrc, StartDate, TabName, TabOrder, TabPath, Title, UniqueId, Url, VersionGuid, HasBeenPublished, IsSystem)
	VALUES (null, @TabContentItemId, @UserIdHost, @Fecha, null, null, '', 0, null, '', '', 0, 0, 1, '', @UserIdHost, @Fecha, @NivelEditores, NewId(), null, @TabIdMantenimientos, 0, @PortalId, null, 0.5, @SkinSrc, null, 'EstadosCalendario', 3, '//' + @NombrePaginaPadre + '//EstadosCalendario', '', NewId(), '', NewId(), 1, 0)

	set @TabId = SCOPE_IDENTITY()

	UPDATE dnn_ContentItems SET TabId = @TabId WHERE ContentItemID = @TabContentItemId

	INSERT INTO dnn_TabSettings (TabID, SettingName, SettingValue, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 'AllowIndex', 'True', @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabSettings (TabID, SettingName, SettingValue, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 'LinkNewWindow', 'False', @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 3, 1, @RoleIdHost, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 4, 1, @RoleIdHost, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 3, 1, @RoleIdAdministrador, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	INSERT INTO dnn_Packages (
		CreatedByUserID, 
		CreatedOnDate, 
		Description, 
		Email, 
		FriendlyName, 
		IsSystemPackage, 
		LastModifiedByUserID, 
		LastModifiedOnDate, 
		License, 
		Manifest, 
		Name, 
		Organization, 
		Owner,
		PackageType, 
		PortalID, 
		ReleaseNotes, 
		Url, 
		Version
	) VALUES (
		@UserIdHost, 
		@Fecha, 
		'Mantenimiento EstadosCalendario', 
		'', 
		'Mantenimiento EstadosCalendario', 
		0, 
		@UserIdHost, 
		@Fecha, 
		'El archivo de instalación no contiene información de la licencia. Verifique con el vendedor los detalles de la licencia.', 
		'<package name="CollectorsClub.EditorEstadosCalendario" type="Module" version="1.0.0">
		<friendlyName>CollectorsClub - Mantenimiento EstadosCalendario</friendlyName>
		<description>CollectorsClub - Mantenimiento EstadosCalendario</description>
		<iconFile />
		<owner>
			<name>CollectorsClub</name>
			<organization />
			<url />
			<email />
		</owner>
		<license>El archivo de instalación no contiene información de la licencia. Verifique con el vendedor los detalles de la licencia.</license>
		<releaseNotes />
		<components>
			<component type="Module">
				<desktopModule>
					<moduleName>CollectorsClub.EditorEstadosCalendario</moduleName>
					<foldername>CollectorsClub.EditorEstadosCalendario</foldername>
					<businessControllerClass />
					<supportedFeatures />
					<moduleDefinitions>
						<moduleDefinition>
							<friendlyName>CollectorsClub - Mantenimiento EstadosCalendario</friendlyName>
							<definitionName>CollectorsClub - Mantenimiento EstadosCalendario</definitionName>
							<defaultCacheTime>0</defaultCacheTime>
							<moduleControls>
								<moduleControl>
									<controlKey />
									<controlSrc>DesktopModules/CollectorsClub/Editores/EstadoCalendarioEditorView.ascx</controlSrc>
									<supportsPartialRendering>False</supportsPartialRendering>
									<controlTitle />
									<controlType>View</controlType>
									<iconFile />
									<helpUrl />
									<supportsPopUps>False</supportsPopUps>
									<viewOrder>0</viewOrder>
								</moduleControl>
							</moduleControls>
						</moduleDefinition>
					</moduleDefinitions>
				</desktopModule>
			</component>
			<component type="File">
				<files>
					<basePath>DesktopModules\CollectorsClub\Editores</basePath>
					<file>
						<name>EstadoCalendarioEditorView.ascx</name>
						<sourceFileName>EstadoCalendarioEditorView.ascx</sourceFileName>
					</file>
				</files>
			</component>
		</components>
	</package>', 
		'CollectorsClub.EditorEstadosCalendario', 
		'', 
		'CollectorsClub',
		'Module', 
		@PortalId, 
		'Este paquete no tiene notas de la versión', 
		'', 
		'1.0.0'
	)
	set @PackageId = SCOPE_IDENTITY()

	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Mantenimiento EstadosCalendario', 3, -1, -1, '', 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @DesktopModuleContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_DesktopModules (BusinessControllerClass, CompatibleVersions, ContentItemId, CreatedByUserID, CreatedOnDate, Dependencies, Description, FolderName, FriendlyName, IsAdmin, IsPremium, LastModifiedByUserID, LastModifiedOnDate, ModuleName, PackageID, Permissions, Shareable, SupportedFeatures, Version)
	VALUES ('', null, @DesktopModuleContentItemId, @UserIdHost, @Fecha, null, 'Mantenimiento EstadosCalendario', 'CollectorsClub.EditorEstadosCalendario', 'Mantenimiento EstadosCalendario', 0, 0, @UserIdHost, @Fecha, 'CollectorsClub.EditorEstadosCalendario', @PackageId, null, 0, 0, '01.00.00')

	set @DesktopModuleId = SCOPE_IDENTITY()

	INSERT INTO dnn_ModuleDefinitions (CreatedByUserID, CreatedOnDate, DefaultCacheTime, DefinitionName, DesktopModuleID, FriendlyName, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@UserIdHost, @Fecha, 0, 'Mantenimiento EstadosCalendario', @DesktopModuleId, 'Mantenimiento EstadosCalendario', @UserIdHost, @Fecha)

	set @ModuleDefinitionId = SCOPE_IDENTITY()

	INSERT INTO dnn_PortalDesktopModules (CreatedByUserID, CreatedOnDate, DesktopModuleID, LastModifiedByUserID, LastModifiedOnDate, PortalID)
	VALUES (@UserIdHost, @Fecha, @DesktopModuleId, @UserIdHost, @Fecha, @PortalId)

	set @PortalDesktopModuleId = SCOPE_IDENTITY()

	INSERT INTO dnn_DesktopModulePermission (AllowAccess, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, PermissionID, PortalDesktopModuleID, RoleID, UserID)
	VALUES (1, @UserIdHost, @Fecha, @UserIdHost, @Fecha, 7, @PortalDesktopModuleId, @RoleIdHost, null)

	INSERT INTO dnn_ModuleControls (ControlKey, ControlSrc, ControlTitle, ControlType, CreatedByUserID, CreatedOnDate, HelpUrl, IconFile, LastModifiedByUserID, LastModifiedOnDate, ModuleDefID, SupportsPartialRendering, SupportsPopUps, ViewOrder)
	VALUES (null, 'DesktopModules/CollectorsClub/Editores/EstadoCalendarioEditorView.ascx', null, 0, @UserIdHost, @Fecha, null, null, @UserIdHost, @Fecha, @ModuleDefinitionId, 0, 0, 0)

	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Mantenimiento EstadosCalendario', 2, @TabId, -1, null, 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @ModuleContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_Modules (AllTabs, ContentItemID, CreatedByUserID, CreatedOnDate, EndDate, InheritViewPermissions, IsDeleted, IsShareable, IsShareableViewOnly, LastContentModifiedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleDefID, PortalID, StartDate)
	VALUES (0, @ModuleContentItemId, @UserIdHost, @Fecha, null, 1, 0, 1, 1, null, @UserIdHost, @Fecha, @ModuleDefinitionId, @PortalId, null)

	set @ModuleId = SCOPE_IDENTITY()

	UPDATE dnn_ContentItems SET ModuleId = @ModuleId WHERE ContentItemID = @ModuleContentItemId

	INSERT INTO dnn_TabModules (Alignment, Border, CacheMethod, CacheTime, Color, ContainerSrc, CreatedByUserID, CreatedOnDate, CultureCode, DefaultLanguageGuid, DisplayPrint, DisplaySyndicate, DisplayTitle, Footer, Header, IconFile, IsDeleted, IsWebSlice,LastModifiedByUserID, LastModifiedOnDate, LocalizedVersionGuid, ModuleID, ModuleOrder, ModuleTitle, PaneName, TabID, UniqueId, VersionGuid, Visibility, WebSliceExpiryDate, WebSliceTitle, WebSliceTTL)
	VALUES (null, null, null, 0, null, null, @UserIdHost, @Fecha, '', null, 0, 0, 0, null, null, null, 0, 0, @UserIdHost, @Fecha, NewId(), @ModuleId, 3, 'Mantenimiento EstadosCalendario', 'ContentPane', @TabId, NewId(), NewId(), 2, null, '', 0)

	set @TabModuleId = SCOPE_IDENTITY()

	-- DNN No le crea ningún permiso
	--INSERT INTO dnn_TabModuleSettings (CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, SettingName, SettingValue, TabModuleID)
	--VALUES (@UserIdHost, @Fecha, @UserIdHost, @Fecha, '', '', @TabModuleId)

	INSERT INTO dnn_ModulePermission (AllowAccess, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleID, PermissionID, PortalID, RoleID, UserID)
	VALUES (1, @UserIdHost, @Fecha, @UserIdHost, @Fecha, @ModuleId, 2, @PortalId, @RoleIdHost, null)

	-- DNN No le crea ningún permiso
	--INSERT INTO dnn_ModuleSettings (CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleID, SettingName, SettingValue) 
	--VALUES (@UserIdHost, @Fecha, @UserIdHost, @Fecha, @ModuleId, '', '') 
end
------------------------------- Fin script del módulo EstadosCalendario  ------------------------------

------------------------------- Inicio script del módulo EstadosCalendario_Idiomas  ------------------------------
USE CollectorsClubDNN;
GO

declare @NombrePaginaPadre as nvarchar(50) = 'Mantenimiento'
declare @TabIdMantenimientos as int = (SELECT TabId FROM dnn_tabs WHERE TabName = @NombrePaginaPadre AND [Level] = 0)
declare @PortalId as int = 0
declare @UserIdHost as int = 1
declare @RoleIdHost as int = -2
declare @RoleIdAdministrador as int = 0 -- OLL en GA no quiero que lo vean los Administradores, solo Host, Sino pondría el 5
declare @NivelEditores as int = 1
declare @Fecha as datetime = GetDate()
declare @SkinSrc as nvarchar(100) = '[G]Skins/Porto/CollectorsClub-Inner.ascx'

declare @TabContentItemId as int
declare @TabId as int
declare @PackageId as int
declare @DesktopModuleContentItemId as int
declare @DesktopModuleId as int
declare @ModuleDefinitionId as int
declare @PortalDesktopModuleId as int
declare @ModuleContentItemId as int
declare @ModuleId as int
declare @TabModuleId as int


if not exists(SELECT ContentItemId FROM dnn_ContentItems WHERE Content = 'EstadosCalendario_Idiomas')
begin 
	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('EstadosCalendario_Idiomas', 1, -1, -1, null, 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @TabContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_Tabs (ContainerSrc, ContentItemID, CreatedByUserID, CreatedOnDate, CultureCode, DefaultLanguageGuid, Description, DisableLink, EndDate, IconFile, IconFileLarge, IsDeleted, IsSecure, IsVisible, KeyWords, LastModifiedByUserID, LastModifiedOnDate, Level, LocalizedVersionGuid, PageHeadText, ParentId, PermanentRedirect, PortalID, RefreshInterval, SiteMapPriority, SkinSrc, StartDate, TabName, TabOrder, TabPath, Title, UniqueId, Url, VersionGuid, HasBeenPublished, IsSystem)
	VALUES (null, @TabContentItemId, @UserIdHost, @Fecha, null, null, '', 0, null, '', '', 0, 0, 1, '', @UserIdHost, @Fecha, @NivelEditores, NewId(), null, @TabIdMantenimientos, 0, @PortalId, null, 0.5, @SkinSrc, null, 'EstadosCalendario_Idiomas', 3, '//' + @NombrePaginaPadre + '//EstadosCalendario_Idiomas', '', NewId(), '', NewId(), 1, 0)

	set @TabId = SCOPE_IDENTITY()

	UPDATE dnn_ContentItems SET TabId = @TabId WHERE ContentItemID = @TabContentItemId

	INSERT INTO dnn_TabSettings (TabID, SettingName, SettingValue, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 'AllowIndex', 'True', @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabSettings (TabID, SettingName, SettingValue, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 'LinkNewWindow', 'False', @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 3, 1, @RoleIdHost, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 4, 1, @RoleIdHost, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 3, 1, @RoleIdAdministrador, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	INSERT INTO dnn_Packages (
		CreatedByUserID, 
		CreatedOnDate, 
		Description, 
		Email, 
		FriendlyName, 
		IsSystemPackage, 
		LastModifiedByUserID, 
		LastModifiedOnDate, 
		License, 
		Manifest, 
		Name, 
		Organization, 
		Owner,
		PackageType, 
		PortalID, 
		ReleaseNotes, 
		Url, 
		Version
	) VALUES (
		@UserIdHost, 
		@Fecha, 
		'Mantenimiento EstadosCalendario_Idiomas', 
		'', 
		'Mantenimiento EstadosCalendario_Idiomas', 
		0, 
		@UserIdHost, 
		@Fecha, 
		'El archivo de instalación no contiene información de la licencia. Verifique con el vendedor los detalles de la licencia.', 
		'<package name="CollectorsClub.EditorEstadosCalendario_Idiomas" type="Module" version="1.0.0">
		<friendlyName>CollectorsClub - Mantenimiento EstadosCalendario_Idiomas</friendlyName>
		<description>CollectorsClub - Mantenimiento EstadosCalendario_Idiomas</description>
		<iconFile />
		<owner>
			<name>CollectorsClub</name>
			<organization />
			<url />
			<email />
		</owner>
		<license>El archivo de instalación no contiene información de la licencia. Verifique con el vendedor los detalles de la licencia.</license>
		<releaseNotes />
		<components>
			<component type="Module">
				<desktopModule>
					<moduleName>CollectorsClub.EditorEstadosCalendario_Idiomas</moduleName>
					<foldername>CollectorsClub.EditorEstadosCalendario_Idiomas</foldername>
					<businessControllerClass />
					<supportedFeatures />
					<moduleDefinitions>
						<moduleDefinition>
							<friendlyName>CollectorsClub - Mantenimiento EstadosCalendario_Idiomas</friendlyName>
							<definitionName>CollectorsClub - Mantenimiento EstadosCalendario_Idiomas</definitionName>
							<defaultCacheTime>0</defaultCacheTime>
							<moduleControls>
								<moduleControl>
									<controlKey />
									<controlSrc>DesktopModules/CollectorsClub/Editores/EstadoCalendario_IdiomaEditorView.ascx</controlSrc>
									<supportsPartialRendering>False</supportsPartialRendering>
									<controlTitle />
									<controlType>View</controlType>
									<iconFile />
									<helpUrl />
									<supportsPopUps>False</supportsPopUps>
									<viewOrder>0</viewOrder>
								</moduleControl>
							</moduleControls>
						</moduleDefinition>
					</moduleDefinitions>
				</desktopModule>
			</component>
			<component type="File">
				<files>
					<basePath>DesktopModules\CollectorsClub\Editores</basePath>
					<file>
						<name>EstadoCalendario_IdiomaEditorView.ascx</name>
						<sourceFileName>EstadoCalendario_IdiomaEditorView.ascx</sourceFileName>
					</file>
				</files>
			</component>
		</components>
	</package>', 
		'CollectorsClub.EditorEstadosCalendario_Idiomas', 
		'', 
		'CollectorsClub',
		'Module', 
		@PortalId, 
		'Este paquete no tiene notas de la versión', 
		'', 
		'1.0.0'
	)
	set @PackageId = SCOPE_IDENTITY()

	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Mantenimiento EstadosCalendario_Idiomas', 3, -1, -1, '', 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @DesktopModuleContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_DesktopModules (BusinessControllerClass, CompatibleVersions, ContentItemId, CreatedByUserID, CreatedOnDate, Dependencies, Description, FolderName, FriendlyName, IsAdmin, IsPremium, LastModifiedByUserID, LastModifiedOnDate, ModuleName, PackageID, Permissions, Shareable, SupportedFeatures, Version)
	VALUES ('', null, @DesktopModuleContentItemId, @UserIdHost, @Fecha, null, 'Mantenimiento EstadosCalendario_Idiomas', 'CollectorsClub.EditorEstadosCalendario_Idiomas', 'Mantenimiento EstadosCalendario_Idiomas', 0, 0, @UserIdHost, @Fecha, 'CollectorsClub.EditorEstadosCalendario_Idiomas', @PackageId, null, 0, 0, '01.00.00')

	set @DesktopModuleId = SCOPE_IDENTITY()

	INSERT INTO dnn_ModuleDefinitions (CreatedByUserID, CreatedOnDate, DefaultCacheTime, DefinitionName, DesktopModuleID, FriendlyName, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@UserIdHost, @Fecha, 0, 'Mantenimiento EstadosCalendario_Idiomas', @DesktopModuleId, 'Mantenimiento EstadosCalendario_Idiomas', @UserIdHost, @Fecha)

	set @ModuleDefinitionId = SCOPE_IDENTITY()

	INSERT INTO dnn_PortalDesktopModules (CreatedByUserID, CreatedOnDate, DesktopModuleID, LastModifiedByUserID, LastModifiedOnDate, PortalID)
	VALUES (@UserIdHost, @Fecha, @DesktopModuleId, @UserIdHost, @Fecha, @PortalId)

	set @PortalDesktopModuleId = SCOPE_IDENTITY()

	INSERT INTO dnn_DesktopModulePermission (AllowAccess, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, PermissionID, PortalDesktopModuleID, RoleID, UserID)
	VALUES (1, @UserIdHost, @Fecha, @UserIdHost, @Fecha, 7, @PortalDesktopModuleId, @RoleIdHost, null)

	INSERT INTO dnn_ModuleControls (ControlKey, ControlSrc, ControlTitle, ControlType, CreatedByUserID, CreatedOnDate, HelpUrl, IconFile, LastModifiedByUserID, LastModifiedOnDate, ModuleDefID, SupportsPartialRendering, SupportsPopUps, ViewOrder)
	VALUES (null, 'DesktopModules/CollectorsClub/Editores/EstadoCalendario_IdiomaEditorView.ascx', null, 0, @UserIdHost, @Fecha, null, null, @UserIdHost, @Fecha, @ModuleDefinitionId, 0, 0, 0)

	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Mantenimiento EstadosCalendario_Idiomas', 2, @TabId, -1, null, 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @ModuleContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_Modules (AllTabs, ContentItemID, CreatedByUserID, CreatedOnDate, EndDate, InheritViewPermissions, IsDeleted, IsShareable, IsShareableViewOnly, LastContentModifiedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleDefID, PortalID, StartDate)
	VALUES (0, @ModuleContentItemId, @UserIdHost, @Fecha, null, 1, 0, 1, 1, null, @UserIdHost, @Fecha, @ModuleDefinitionId, @PortalId, null)

	set @ModuleId = SCOPE_IDENTITY()

	UPDATE dnn_ContentItems SET ModuleId = @ModuleId WHERE ContentItemID = @ModuleContentItemId

	INSERT INTO dnn_TabModules (Alignment, Border, CacheMethod, CacheTime, Color, ContainerSrc, CreatedByUserID, CreatedOnDate, CultureCode, DefaultLanguageGuid, DisplayPrint, DisplaySyndicate, DisplayTitle, Footer, Header, IconFile, IsDeleted, IsWebSlice,LastModifiedByUserID, LastModifiedOnDate, LocalizedVersionGuid, ModuleID, ModuleOrder, ModuleTitle, PaneName, TabID, UniqueId, VersionGuid, Visibility, WebSliceExpiryDate, WebSliceTitle, WebSliceTTL)
	VALUES (null, null, null, 0, null, null, @UserIdHost, @Fecha, '', null, 0, 0, 0, null, null, null, 0, 0, @UserIdHost, @Fecha, NewId(), @ModuleId, 3, 'Mantenimiento EstadosCalendario_Idiomas', 'ContentPane', @TabId, NewId(), NewId(), 2, null, '', 0)

	set @TabModuleId = SCOPE_IDENTITY()

	-- DNN No le crea ningún permiso
	--INSERT INTO dnn_TabModuleSettings (CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, SettingName, SettingValue, TabModuleID)
	--VALUES (@UserIdHost, @Fecha, @UserIdHost, @Fecha, '', '', @TabModuleId)

	INSERT INTO dnn_ModulePermission (AllowAccess, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleID, PermissionID, PortalID, RoleID, UserID)
	VALUES (1, @UserIdHost, @Fecha, @UserIdHost, @Fecha, @ModuleId, 2, @PortalId, @RoleIdHost, null)

	-- DNN No le crea ningún permiso
	--INSERT INTO dnn_ModuleSettings (CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleID, SettingName, SettingValue) 
	--VALUES (@UserIdHost, @Fecha, @UserIdHost, @Fecha, @ModuleId, '', '') 
end
------------------------------- Fin script del módulo EstadosCalendario_Idiomas  ------------------------------

------------------------------- Inicio script del módulo Eventos  ------------------------------
USE CollectorsClubDNN;
GO

declare @NombrePaginaPadre as nvarchar(50) = 'Mantenimiento'
declare @TabIdMantenimientos as int = (SELECT TabId FROM dnn_tabs WHERE TabName = @NombrePaginaPadre AND [Level] = 0)
declare @PortalId as int = 0
declare @UserIdHost as int = 1
declare @RoleIdHost as int = -2
declare @RoleIdAdministrador as int = 0 -- OLL en GA no quiero que lo vean los Administradores, solo Host, Sino pondría el 5
declare @NivelEditores as int = 1
declare @Fecha as datetime = GetDate()
declare @SkinSrc as nvarchar(100) = '[G]Skins/Porto/CollectorsClub-Inner.ascx'

declare @TabContentItemId as int
declare @TabId as int
declare @PackageId as int
declare @DesktopModuleContentItemId as int
declare @DesktopModuleId as int
declare @ModuleDefinitionId as int
declare @PortalDesktopModuleId as int
declare @ModuleContentItemId as int
declare @ModuleId as int
declare @TabModuleId as int


if not exists(SELECT ContentItemId FROM dnn_ContentItems WHERE Content = 'Eventos')
begin 
	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Eventos', 1, -1, -1, null, 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @TabContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_Tabs (ContainerSrc, ContentItemID, CreatedByUserID, CreatedOnDate, CultureCode, DefaultLanguageGuid, Description, DisableLink, EndDate, IconFile, IconFileLarge, IsDeleted, IsSecure, IsVisible, KeyWords, LastModifiedByUserID, LastModifiedOnDate, Level, LocalizedVersionGuid, PageHeadText, ParentId, PermanentRedirect, PortalID, RefreshInterval, SiteMapPriority, SkinSrc, StartDate, TabName, TabOrder, TabPath, Title, UniqueId, Url, VersionGuid, HasBeenPublished, IsSystem)
	VALUES (null, @TabContentItemId, @UserIdHost, @Fecha, null, null, '', 0, null, '', '', 0, 0, 1, '', @UserIdHost, @Fecha, @NivelEditores, NewId(), null, @TabIdMantenimientos, 0, @PortalId, null, 0.5, @SkinSrc, null, 'Eventos', 3, '//' + @NombrePaginaPadre + '//Eventos', '', NewId(), '', NewId(), 1, 0)

	set @TabId = SCOPE_IDENTITY()

	UPDATE dnn_ContentItems SET TabId = @TabId WHERE ContentItemID = @TabContentItemId

	INSERT INTO dnn_TabSettings (TabID, SettingName, SettingValue, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 'AllowIndex', 'True', @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabSettings (TabID, SettingName, SettingValue, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 'LinkNewWindow', 'False', @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 3, 1, @RoleIdHost, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 4, 1, @RoleIdHost, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 3, 1, @RoleIdAdministrador, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	INSERT INTO dnn_Packages (
		CreatedByUserID, 
		CreatedOnDate, 
		Description, 
		Email, 
		FriendlyName, 
		IsSystemPackage, 
		LastModifiedByUserID, 
		LastModifiedOnDate, 
		License, 
		Manifest, 
		Name, 
		Organization, 
		Owner,
		PackageType, 
		PortalID, 
		ReleaseNotes, 
		Url, 
		Version
	) VALUES (
		@UserIdHost, 
		@Fecha, 
		'Mantenimiento Eventos', 
		'', 
		'Mantenimiento Eventos', 
		0, 
		@UserIdHost, 
		@Fecha, 
		'El archivo de instalación no contiene información de la licencia. Verifique con el vendedor los detalles de la licencia.', 
		'<package name="CollectorsClub.EditorEventos" type="Module" version="1.0.0">
		<friendlyName>CollectorsClub - Mantenimiento Eventos</friendlyName>
		<description>CollectorsClub - Mantenimiento Eventos</description>
		<iconFile />
		<owner>
			<name>CollectorsClub</name>
			<organization />
			<url />
			<email />
		</owner>
		<license>El archivo de instalación no contiene información de la licencia. Verifique con el vendedor los detalles de la licencia.</license>
		<releaseNotes />
		<components>
			<component type="Module">
				<desktopModule>
					<moduleName>CollectorsClub.EditorEventos</moduleName>
					<foldername>CollectorsClub.EditorEventos</foldername>
					<businessControllerClass />
					<supportedFeatures />
					<moduleDefinitions>
						<moduleDefinition>
							<friendlyName>CollectorsClub - Mantenimiento Eventos</friendlyName>
							<definitionName>CollectorsClub - Mantenimiento Eventos</definitionName>
							<defaultCacheTime>0</defaultCacheTime>
							<moduleControls>
								<moduleControl>
									<controlKey />
									<controlSrc>DesktopModules/CollectorsClub/Editores/EventoEditorView.ascx</controlSrc>
									<supportsPartialRendering>False</supportsPartialRendering>
									<controlTitle />
									<controlType>View</controlType>
									<iconFile />
									<helpUrl />
									<supportsPopUps>False</supportsPopUps>
									<viewOrder>0</viewOrder>
								</moduleControl>
							</moduleControls>
						</moduleDefinition>
					</moduleDefinitions>
				</desktopModule>
			</component>
			<component type="File">
				<files>
					<basePath>DesktopModules\CollectorsClub\Editores</basePath>
					<file>
						<name>EventoEditorView.ascx</name>
						<sourceFileName>EventoEditorView.ascx</sourceFileName>
					</file>
				</files>
			</component>
		</components>
	</package>', 
		'CollectorsClub.EditorEventos', 
		'', 
		'CollectorsClub',
		'Module', 
		@PortalId, 
		'Este paquete no tiene notas de la versión', 
		'', 
		'1.0.0'
	)
	set @PackageId = SCOPE_IDENTITY()

	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Mantenimiento Eventos', 3, -1, -1, '', 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @DesktopModuleContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_DesktopModules (BusinessControllerClass, CompatibleVersions, ContentItemId, CreatedByUserID, CreatedOnDate, Dependencies, Description, FolderName, FriendlyName, IsAdmin, IsPremium, LastModifiedByUserID, LastModifiedOnDate, ModuleName, PackageID, Permissions, Shareable, SupportedFeatures, Version)
	VALUES ('', null, @DesktopModuleContentItemId, @UserIdHost, @Fecha, null, 'Mantenimiento Eventos', 'CollectorsClub.EditorEventos', 'Mantenimiento Eventos', 0, 0, @UserIdHost, @Fecha, 'CollectorsClub.EditorEventos', @PackageId, null, 0, 0, '01.00.00')

	set @DesktopModuleId = SCOPE_IDENTITY()

	INSERT INTO dnn_ModuleDefinitions (CreatedByUserID, CreatedOnDate, DefaultCacheTime, DefinitionName, DesktopModuleID, FriendlyName, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@UserIdHost, @Fecha, 0, 'Mantenimiento Eventos', @DesktopModuleId, 'Mantenimiento Eventos', @UserIdHost, @Fecha)

	set @ModuleDefinitionId = SCOPE_IDENTITY()

	INSERT INTO dnn_PortalDesktopModules (CreatedByUserID, CreatedOnDate, DesktopModuleID, LastModifiedByUserID, LastModifiedOnDate, PortalID)
	VALUES (@UserIdHost, @Fecha, @DesktopModuleId, @UserIdHost, @Fecha, @PortalId)

	set @PortalDesktopModuleId = SCOPE_IDENTITY()

	INSERT INTO dnn_DesktopModulePermission (AllowAccess, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, PermissionID, PortalDesktopModuleID, RoleID, UserID)
	VALUES (1, @UserIdHost, @Fecha, @UserIdHost, @Fecha, 7, @PortalDesktopModuleId, @RoleIdHost, null)

	INSERT INTO dnn_ModuleControls (ControlKey, ControlSrc, ControlTitle, ControlType, CreatedByUserID, CreatedOnDate, HelpUrl, IconFile, LastModifiedByUserID, LastModifiedOnDate, ModuleDefID, SupportsPartialRendering, SupportsPopUps, ViewOrder)
	VALUES (null, 'DesktopModules/CollectorsClub/Editores/EventoEditorView.ascx', null, 0, @UserIdHost, @Fecha, null, null, @UserIdHost, @Fecha, @ModuleDefinitionId, 0, 0, 0)

	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Mantenimiento Eventos', 2, @TabId, -1, null, 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @ModuleContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_Modules (AllTabs, ContentItemID, CreatedByUserID, CreatedOnDate, EndDate, InheritViewPermissions, IsDeleted, IsShareable, IsShareableViewOnly, LastContentModifiedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleDefID, PortalID, StartDate)
	VALUES (0, @ModuleContentItemId, @UserIdHost, @Fecha, null, 1, 0, 1, 1, null, @UserIdHost, @Fecha, @ModuleDefinitionId, @PortalId, null)

	set @ModuleId = SCOPE_IDENTITY()

	UPDATE dnn_ContentItems SET ModuleId = @ModuleId WHERE ContentItemID = @ModuleContentItemId

	INSERT INTO dnn_TabModules (Alignment, Border, CacheMethod, CacheTime, Color, ContainerSrc, CreatedByUserID, CreatedOnDate, CultureCode, DefaultLanguageGuid, DisplayPrint, DisplaySyndicate, DisplayTitle, Footer, Header, IconFile, IsDeleted, IsWebSlice,LastModifiedByUserID, LastModifiedOnDate, LocalizedVersionGuid, ModuleID, ModuleOrder, ModuleTitle, PaneName, TabID, UniqueId, VersionGuid, Visibility, WebSliceExpiryDate, WebSliceTitle, WebSliceTTL)
	VALUES (null, null, null, 0, null, null, @UserIdHost, @Fecha, '', null, 0, 0, 0, null, null, null, 0, 0, @UserIdHost, @Fecha, NewId(), @ModuleId, 3, 'Mantenimiento Eventos', 'ContentPane', @TabId, NewId(), NewId(), 2, null, '', 0)

	set @TabModuleId = SCOPE_IDENTITY()

	-- DNN No le crea ningún permiso
	--INSERT INTO dnn_TabModuleSettings (CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, SettingName, SettingValue, TabModuleID)
	--VALUES (@UserIdHost, @Fecha, @UserIdHost, @Fecha, '', '', @TabModuleId)

	INSERT INTO dnn_ModulePermission (AllowAccess, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleID, PermissionID, PortalID, RoleID, UserID)
	VALUES (1, @UserIdHost, @Fecha, @UserIdHost, @Fecha, @ModuleId, 2, @PortalId, @RoleIdHost, null)

	-- DNN No le crea ningún permiso
	--INSERT INTO dnn_ModuleSettings (CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleID, SettingName, SettingValue) 
	--VALUES (@UserIdHost, @Fecha, @UserIdHost, @Fecha, @ModuleId, '', '') 
end
------------------------------- Fin script del módulo Eventos  ------------------------------

------------------------------- Inicio script del módulo Eventos_Idiomas  ------------------------------
USE CollectorsClubDNN;
GO

declare @NombrePaginaPadre as nvarchar(50) = 'Mantenimiento'
declare @TabIdMantenimientos as int = (SELECT TabId FROM dnn_tabs WHERE TabName = @NombrePaginaPadre AND [Level] = 0)
declare @PortalId as int = 0
declare @UserIdHost as int = 1
declare @RoleIdHost as int = -2
declare @RoleIdAdministrador as int = 0 -- OLL en GA no quiero que lo vean los Administradores, solo Host, Sino pondría el 5
declare @NivelEditores as int = 1
declare @Fecha as datetime = GetDate()
declare @SkinSrc as nvarchar(100) = '[G]Skins/Porto/CollectorsClub-Inner.ascx'

declare @TabContentItemId as int
declare @TabId as int
declare @PackageId as int
declare @DesktopModuleContentItemId as int
declare @DesktopModuleId as int
declare @ModuleDefinitionId as int
declare @PortalDesktopModuleId as int
declare @ModuleContentItemId as int
declare @ModuleId as int
declare @TabModuleId as int


if not exists(SELECT ContentItemId FROM dnn_ContentItems WHERE Content = 'Eventos_Idiomas')
begin 
	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Eventos_Idiomas', 1, -1, -1, null, 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @TabContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_Tabs (ContainerSrc, ContentItemID, CreatedByUserID, CreatedOnDate, CultureCode, DefaultLanguageGuid, Description, DisableLink, EndDate, IconFile, IconFileLarge, IsDeleted, IsSecure, IsVisible, KeyWords, LastModifiedByUserID, LastModifiedOnDate, Level, LocalizedVersionGuid, PageHeadText, ParentId, PermanentRedirect, PortalID, RefreshInterval, SiteMapPriority, SkinSrc, StartDate, TabName, TabOrder, TabPath, Title, UniqueId, Url, VersionGuid, HasBeenPublished, IsSystem)
	VALUES (null, @TabContentItemId, @UserIdHost, @Fecha, null, null, '', 0, null, '', '', 0, 0, 1, '', @UserIdHost, @Fecha, @NivelEditores, NewId(), null, @TabIdMantenimientos, 0, @PortalId, null, 0.5, @SkinSrc, null, 'Eventos_Idiomas', 3, '//' + @NombrePaginaPadre + '//Eventos_Idiomas', '', NewId(), '', NewId(), 1, 0)

	set @TabId = SCOPE_IDENTITY()

	UPDATE dnn_ContentItems SET TabId = @TabId WHERE ContentItemID = @TabContentItemId

	INSERT INTO dnn_TabSettings (TabID, SettingName, SettingValue, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 'AllowIndex', 'True', @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabSettings (TabID, SettingName, SettingValue, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 'LinkNewWindow', 'False', @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 3, 1, @RoleIdHost, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 4, 1, @RoleIdHost, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 3, 1, @RoleIdAdministrador, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	INSERT INTO dnn_Packages (
		CreatedByUserID, 
		CreatedOnDate, 
		Description, 
		Email, 
		FriendlyName, 
		IsSystemPackage, 
		LastModifiedByUserID, 
		LastModifiedOnDate, 
		License, 
		Manifest, 
		Name, 
		Organization, 
		Owner,
		PackageType, 
		PortalID, 
		ReleaseNotes, 
		Url, 
		Version
	) VALUES (
		@UserIdHost, 
		@Fecha, 
		'Mantenimiento Eventos_Idiomas', 
		'', 
		'Mantenimiento Eventos_Idiomas', 
		0, 
		@UserIdHost, 
		@Fecha, 
		'El archivo de instalación no contiene información de la licencia. Verifique con el vendedor los detalles de la licencia.', 
		'<package name="CollectorsClub.EditorEventos_Idiomas" type="Module" version="1.0.0">
		<friendlyName>CollectorsClub - Mantenimiento Eventos_Idiomas</friendlyName>
		<description>CollectorsClub - Mantenimiento Eventos_Idiomas</description>
		<iconFile />
		<owner>
			<name>CollectorsClub</name>
			<organization />
			<url />
			<email />
		</owner>
		<license>El archivo de instalación no contiene información de la licencia. Verifique con el vendedor los detalles de la licencia.</license>
		<releaseNotes />
		<components>
			<component type="Module">
				<desktopModule>
					<moduleName>CollectorsClub.EditorEventos_Idiomas</moduleName>
					<foldername>CollectorsClub.EditorEventos_Idiomas</foldername>
					<businessControllerClass />
					<supportedFeatures />
					<moduleDefinitions>
						<moduleDefinition>
							<friendlyName>CollectorsClub - Mantenimiento Eventos_Idiomas</friendlyName>
							<definitionName>CollectorsClub - Mantenimiento Eventos_Idiomas</definitionName>
							<defaultCacheTime>0</defaultCacheTime>
							<moduleControls>
								<moduleControl>
									<controlKey />
									<controlSrc>DesktopModules/CollectorsClub/Editores/Evento_IdiomaEditorView.ascx</controlSrc>
									<supportsPartialRendering>False</supportsPartialRendering>
									<controlTitle />
									<controlType>View</controlType>
									<iconFile />
									<helpUrl />
									<supportsPopUps>False</supportsPopUps>
									<viewOrder>0</viewOrder>
								</moduleControl>
							</moduleControls>
						</moduleDefinition>
					</moduleDefinitions>
				</desktopModule>
			</component>
			<component type="File">
				<files>
					<basePath>DesktopModules\CollectorsClub\Editores</basePath>
					<file>
						<name>Evento_IdiomaEditorView.ascx</name>
						<sourceFileName>Evento_IdiomaEditorView.ascx</sourceFileName>
					</file>
				</files>
			</component>
		</components>
	</package>', 
		'CollectorsClub.EditorEventos_Idiomas', 
		'', 
		'CollectorsClub',
		'Module', 
		@PortalId, 
		'Este paquete no tiene notas de la versión', 
		'', 
		'1.0.0'
	)
	set @PackageId = SCOPE_IDENTITY()

	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Mantenimiento Eventos_Idiomas', 3, -1, -1, '', 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @DesktopModuleContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_DesktopModules (BusinessControllerClass, CompatibleVersions, ContentItemId, CreatedByUserID, CreatedOnDate, Dependencies, Description, FolderName, FriendlyName, IsAdmin, IsPremium, LastModifiedByUserID, LastModifiedOnDate, ModuleName, PackageID, Permissions, Shareable, SupportedFeatures, Version)
	VALUES ('', null, @DesktopModuleContentItemId, @UserIdHost, @Fecha, null, 'Mantenimiento Eventos_Idiomas', 'CollectorsClub.EditorEventos_Idiomas', 'Mantenimiento Eventos_Idiomas', 0, 0, @UserIdHost, @Fecha, 'CollectorsClub.EditorEventos_Idiomas', @PackageId, null, 0, 0, '01.00.00')

	set @DesktopModuleId = SCOPE_IDENTITY()

	INSERT INTO dnn_ModuleDefinitions (CreatedByUserID, CreatedOnDate, DefaultCacheTime, DefinitionName, DesktopModuleID, FriendlyName, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@UserIdHost, @Fecha, 0, 'Mantenimiento Eventos_Idiomas', @DesktopModuleId, 'Mantenimiento Eventos_Idiomas', @UserIdHost, @Fecha)

	set @ModuleDefinitionId = SCOPE_IDENTITY()

	INSERT INTO dnn_PortalDesktopModules (CreatedByUserID, CreatedOnDate, DesktopModuleID, LastModifiedByUserID, LastModifiedOnDate, PortalID)
	VALUES (@UserIdHost, @Fecha, @DesktopModuleId, @UserIdHost, @Fecha, @PortalId)

	set @PortalDesktopModuleId = SCOPE_IDENTITY()

	INSERT INTO dnn_DesktopModulePermission (AllowAccess, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, PermissionID, PortalDesktopModuleID, RoleID, UserID)
	VALUES (1, @UserIdHost, @Fecha, @UserIdHost, @Fecha, 7, @PortalDesktopModuleId, @RoleIdHost, null)

	INSERT INTO dnn_ModuleControls (ControlKey, ControlSrc, ControlTitle, ControlType, CreatedByUserID, CreatedOnDate, HelpUrl, IconFile, LastModifiedByUserID, LastModifiedOnDate, ModuleDefID, SupportsPartialRendering, SupportsPopUps, ViewOrder)
	VALUES (null, 'DesktopModules/CollectorsClub/Editores/Evento_IdiomaEditorView.ascx', null, 0, @UserIdHost, @Fecha, null, null, @UserIdHost, @Fecha, @ModuleDefinitionId, 0, 0, 0)

	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Mantenimiento Eventos_Idiomas', 2, @TabId, -1, null, 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @ModuleContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_Modules (AllTabs, ContentItemID, CreatedByUserID, CreatedOnDate, EndDate, InheritViewPermissions, IsDeleted, IsShareable, IsShareableViewOnly, LastContentModifiedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleDefID, PortalID, StartDate)
	VALUES (0, @ModuleContentItemId, @UserIdHost, @Fecha, null, 1, 0, 1, 1, null, @UserIdHost, @Fecha, @ModuleDefinitionId, @PortalId, null)

	set @ModuleId = SCOPE_IDENTITY()

	UPDATE dnn_ContentItems SET ModuleId = @ModuleId WHERE ContentItemID = @ModuleContentItemId

	INSERT INTO dnn_TabModules (Alignment, Border, CacheMethod, CacheTime, Color, ContainerSrc, CreatedByUserID, CreatedOnDate, CultureCode, DefaultLanguageGuid, DisplayPrint, DisplaySyndicate, DisplayTitle, Footer, Header, IconFile, IsDeleted, IsWebSlice,LastModifiedByUserID, LastModifiedOnDate, LocalizedVersionGuid, ModuleID, ModuleOrder, ModuleTitle, PaneName, TabID, UniqueId, VersionGuid, Visibility, WebSliceExpiryDate, WebSliceTitle, WebSliceTTL)
	VALUES (null, null, null, 0, null, null, @UserIdHost, @Fecha, '', null, 0, 0, 0, null, null, null, 0, 0, @UserIdHost, @Fecha, NewId(), @ModuleId, 3, 'Mantenimiento Eventos_Idiomas', 'ContentPane', @TabId, NewId(), NewId(), 2, null, '', 0)

	set @TabModuleId = SCOPE_IDENTITY()

	-- DNN No le crea ningún permiso
	--INSERT INTO dnn_TabModuleSettings (CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, SettingName, SettingValue, TabModuleID)
	--VALUES (@UserIdHost, @Fecha, @UserIdHost, @Fecha, '', '', @TabModuleId)

	INSERT INTO dnn_ModulePermission (AllowAccess, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleID, PermissionID, PortalID, RoleID, UserID)
	VALUES (1, @UserIdHost, @Fecha, @UserIdHost, @Fecha, @ModuleId, 2, @PortalId, @RoleIdHost, null)

	-- DNN No le crea ningún permiso
	--INSERT INTO dnn_ModuleSettings (CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleID, SettingName, SettingValue) 
	--VALUES (@UserIdHost, @Fecha, @UserIdHost, @Fecha, @ModuleId, '', '') 
end
------------------------------- Fin script del módulo Eventos_Idiomas  ------------------------------

------------------------------- Inicio script del módulo Fabricantes  ------------------------------
USE CollectorsClubDNN;
GO

declare @NombrePaginaPadre as nvarchar(50) = 'Mantenimiento'
declare @TabIdMantenimientos as int = (SELECT TabId FROM dnn_tabs WHERE TabName = @NombrePaginaPadre AND [Level] = 0)
declare @PortalId as int = 0
declare @UserIdHost as int = 1
declare @RoleIdHost as int = -2
declare @RoleIdAdministrador as int = 0 -- OLL en GA no quiero que lo vean los Administradores, solo Host, Sino pondría el 5
declare @NivelEditores as int = 1
declare @Fecha as datetime = GetDate()
declare @SkinSrc as nvarchar(100) = '[G]Skins/Porto/CollectorsClub-Inner.ascx'

declare @TabContentItemId as int
declare @TabId as int
declare @PackageId as int
declare @DesktopModuleContentItemId as int
declare @DesktopModuleId as int
declare @ModuleDefinitionId as int
declare @PortalDesktopModuleId as int
declare @ModuleContentItemId as int
declare @ModuleId as int
declare @TabModuleId as int


if not exists(SELECT ContentItemId FROM dnn_ContentItems WHERE Content = 'Fabricantes')
begin 
	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Fabricantes', 1, -1, -1, null, 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @TabContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_Tabs (ContainerSrc, ContentItemID, CreatedByUserID, CreatedOnDate, CultureCode, DefaultLanguageGuid, Description, DisableLink, EndDate, IconFile, IconFileLarge, IsDeleted, IsSecure, IsVisible, KeyWords, LastModifiedByUserID, LastModifiedOnDate, Level, LocalizedVersionGuid, PageHeadText, ParentId, PermanentRedirect, PortalID, RefreshInterval, SiteMapPriority, SkinSrc, StartDate, TabName, TabOrder, TabPath, Title, UniqueId, Url, VersionGuid, HasBeenPublished, IsSystem)
	VALUES (null, @TabContentItemId, @UserIdHost, @Fecha, null, null, '', 0, null, '', '', 0, 0, 1, '', @UserIdHost, @Fecha, @NivelEditores, NewId(), null, @TabIdMantenimientos, 0, @PortalId, null, 0.5, @SkinSrc, null, 'Fabricantes', 3, '//' + @NombrePaginaPadre + '//Fabricantes', '', NewId(), '', NewId(), 1, 0)

	set @TabId = SCOPE_IDENTITY()

	UPDATE dnn_ContentItems SET TabId = @TabId WHERE ContentItemID = @TabContentItemId

	INSERT INTO dnn_TabSettings (TabID, SettingName, SettingValue, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 'AllowIndex', 'True', @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabSettings (TabID, SettingName, SettingValue, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 'LinkNewWindow', 'False', @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 3, 1, @RoleIdHost, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 4, 1, @RoleIdHost, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 3, 1, @RoleIdAdministrador, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	INSERT INTO dnn_Packages (
		CreatedByUserID, 
		CreatedOnDate, 
		Description, 
		Email, 
		FriendlyName, 
		IsSystemPackage, 
		LastModifiedByUserID, 
		LastModifiedOnDate, 
		License, 
		Manifest, 
		Name, 
		Organization, 
		Owner,
		PackageType, 
		PortalID, 
		ReleaseNotes, 
		Url, 
		Version
	) VALUES (
		@UserIdHost, 
		@Fecha, 
		'Mantenimiento Fabricantes', 
		'', 
		'Mantenimiento Fabricantes', 
		0, 
		@UserIdHost, 
		@Fecha, 
		'El archivo de instalación no contiene información de la licencia. Verifique con el vendedor los detalles de la licencia.', 
		'<package name="CollectorsClub.EditorFabricantes" type="Module" version="1.0.0">
		<friendlyName>CollectorsClub - Mantenimiento Fabricantes</friendlyName>
		<description>CollectorsClub - Mantenimiento Fabricantes</description>
		<iconFile />
		<owner>
			<name>CollectorsClub</name>
			<organization />
			<url />
			<email />
		</owner>
		<license>El archivo de instalación no contiene información de la licencia. Verifique con el vendedor los detalles de la licencia.</license>
		<releaseNotes />
		<components>
			<component type="Module">
				<desktopModule>
					<moduleName>CollectorsClub.EditorFabricantes</moduleName>
					<foldername>CollectorsClub.EditorFabricantes</foldername>
					<businessControllerClass />
					<supportedFeatures />
					<moduleDefinitions>
						<moduleDefinition>
							<friendlyName>CollectorsClub - Mantenimiento Fabricantes</friendlyName>
							<definitionName>CollectorsClub - Mantenimiento Fabricantes</definitionName>
							<defaultCacheTime>0</defaultCacheTime>
							<moduleControls>
								<moduleControl>
									<controlKey />
									<controlSrc>DesktopModules/CollectorsClub/Editores/FabricanteEditorView.ascx</controlSrc>
									<supportsPartialRendering>False</supportsPartialRendering>
									<controlTitle />
									<controlType>View</controlType>
									<iconFile />
									<helpUrl />
									<supportsPopUps>False</supportsPopUps>
									<viewOrder>0</viewOrder>
								</moduleControl>
							</moduleControls>
						</moduleDefinition>
					</moduleDefinitions>
				</desktopModule>
			</component>
			<component type="File">
				<files>
					<basePath>DesktopModules\CollectorsClub\Editores</basePath>
					<file>
						<name>FabricanteEditorView.ascx</name>
						<sourceFileName>FabricanteEditorView.ascx</sourceFileName>
					</file>
				</files>
			</component>
		</components>
	</package>', 
		'CollectorsClub.EditorFabricantes', 
		'', 
		'CollectorsClub',
		'Module', 
		@PortalId, 
		'Este paquete no tiene notas de la versión', 
		'', 
		'1.0.0'
	)
	set @PackageId = SCOPE_IDENTITY()

	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Mantenimiento Fabricantes', 3, -1, -1, '', 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @DesktopModuleContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_DesktopModules (BusinessControllerClass, CompatibleVersions, ContentItemId, CreatedByUserID, CreatedOnDate, Dependencies, Description, FolderName, FriendlyName, IsAdmin, IsPremium, LastModifiedByUserID, LastModifiedOnDate, ModuleName, PackageID, Permissions, Shareable, SupportedFeatures, Version)
	VALUES ('', null, @DesktopModuleContentItemId, @UserIdHost, @Fecha, null, 'Mantenimiento Fabricantes', 'CollectorsClub.EditorFabricantes', 'Mantenimiento Fabricantes', 0, 0, @UserIdHost, @Fecha, 'CollectorsClub.EditorFabricantes', @PackageId, null, 0, 0, '01.00.00')

	set @DesktopModuleId = SCOPE_IDENTITY()

	INSERT INTO dnn_ModuleDefinitions (CreatedByUserID, CreatedOnDate, DefaultCacheTime, DefinitionName, DesktopModuleID, FriendlyName, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@UserIdHost, @Fecha, 0, 'Mantenimiento Fabricantes', @DesktopModuleId, 'Mantenimiento Fabricantes', @UserIdHost, @Fecha)

	set @ModuleDefinitionId = SCOPE_IDENTITY()

	INSERT INTO dnn_PortalDesktopModules (CreatedByUserID, CreatedOnDate, DesktopModuleID, LastModifiedByUserID, LastModifiedOnDate, PortalID)
	VALUES (@UserIdHost, @Fecha, @DesktopModuleId, @UserIdHost, @Fecha, @PortalId)

	set @PortalDesktopModuleId = SCOPE_IDENTITY()

	INSERT INTO dnn_DesktopModulePermission (AllowAccess, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, PermissionID, PortalDesktopModuleID, RoleID, UserID)
	VALUES (1, @UserIdHost, @Fecha, @UserIdHost, @Fecha, 7, @PortalDesktopModuleId, @RoleIdHost, null)

	INSERT INTO dnn_ModuleControls (ControlKey, ControlSrc, ControlTitle, ControlType, CreatedByUserID, CreatedOnDate, HelpUrl, IconFile, LastModifiedByUserID, LastModifiedOnDate, ModuleDefID, SupportsPartialRendering, SupportsPopUps, ViewOrder)
	VALUES (null, 'DesktopModules/CollectorsClub/Editores/FabricanteEditorView.ascx', null, 0, @UserIdHost, @Fecha, null, null, @UserIdHost, @Fecha, @ModuleDefinitionId, 0, 0, 0)

	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Mantenimiento Fabricantes', 2, @TabId, -1, null, 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @ModuleContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_Modules (AllTabs, ContentItemID, CreatedByUserID, CreatedOnDate, EndDate, InheritViewPermissions, IsDeleted, IsShareable, IsShareableViewOnly, LastContentModifiedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleDefID, PortalID, StartDate)
	VALUES (0, @ModuleContentItemId, @UserIdHost, @Fecha, null, 1, 0, 1, 1, null, @UserIdHost, @Fecha, @ModuleDefinitionId, @PortalId, null)

	set @ModuleId = SCOPE_IDENTITY()

	UPDATE dnn_ContentItems SET ModuleId = @ModuleId WHERE ContentItemID = @ModuleContentItemId

	INSERT INTO dnn_TabModules (Alignment, Border, CacheMethod, CacheTime, Color, ContainerSrc, CreatedByUserID, CreatedOnDate, CultureCode, DefaultLanguageGuid, DisplayPrint, DisplaySyndicate, DisplayTitle, Footer, Header, IconFile, IsDeleted, IsWebSlice,LastModifiedByUserID, LastModifiedOnDate, LocalizedVersionGuid, ModuleID, ModuleOrder, ModuleTitle, PaneName, TabID, UniqueId, VersionGuid, Visibility, WebSliceExpiryDate, WebSliceTitle, WebSliceTTL)
	VALUES (null, null, null, 0, null, null, @UserIdHost, @Fecha, '', null, 0, 0, 0, null, null, null, 0, 0, @UserIdHost, @Fecha, NewId(), @ModuleId, 3, 'Mantenimiento Fabricantes', 'ContentPane', @TabId, NewId(), NewId(), 2, null, '', 0)

	set @TabModuleId = SCOPE_IDENTITY()

	-- DNN No le crea ningún permiso
	--INSERT INTO dnn_TabModuleSettings (CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, SettingName, SettingValue, TabModuleID)
	--VALUES (@UserIdHost, @Fecha, @UserIdHost, @Fecha, '', '', @TabModuleId)

	INSERT INTO dnn_ModulePermission (AllowAccess, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleID, PermissionID, PortalID, RoleID, UserID)
	VALUES (1, @UserIdHost, @Fecha, @UserIdHost, @Fecha, @ModuleId, 2, @PortalId, @RoleIdHost, null)

	-- DNN No le crea ningún permiso
	--INSERT INTO dnn_ModuleSettings (CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleID, SettingName, SettingValue) 
	--VALUES (@UserIdHost, @Fecha, @UserIdHost, @Fecha, @ModuleId, '', '') 
end
------------------------------- Fin script del módulo Fabricantes  ------------------------------

------------------------------- Inicio script del módulo Fabricantes_Idiomas  ------------------------------
USE CollectorsClubDNN;
GO

declare @NombrePaginaPadre as nvarchar(50) = 'Mantenimiento'
declare @TabIdMantenimientos as int = (SELECT TabId FROM dnn_tabs WHERE TabName = @NombrePaginaPadre AND [Level] = 0)
declare @PortalId as int = 0
declare @UserIdHost as int = 1
declare @RoleIdHost as int = -2
declare @RoleIdAdministrador as int = 0 -- OLL en GA no quiero que lo vean los Administradores, solo Host, Sino pondría el 5
declare @NivelEditores as int = 1
declare @Fecha as datetime = GetDate()
declare @SkinSrc as nvarchar(100) = '[G]Skins/Porto/CollectorsClub-Inner.ascx'

declare @TabContentItemId as int
declare @TabId as int
declare @PackageId as int
declare @DesktopModuleContentItemId as int
declare @DesktopModuleId as int
declare @ModuleDefinitionId as int
declare @PortalDesktopModuleId as int
declare @ModuleContentItemId as int
declare @ModuleId as int
declare @TabModuleId as int


if not exists(SELECT ContentItemId FROM dnn_ContentItems WHERE Content = 'Fabricantes_Idiomas')
begin 
	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Fabricantes_Idiomas', 1, -1, -1, null, 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @TabContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_Tabs (ContainerSrc, ContentItemID, CreatedByUserID, CreatedOnDate, CultureCode, DefaultLanguageGuid, Description, DisableLink, EndDate, IconFile, IconFileLarge, IsDeleted, IsSecure, IsVisible, KeyWords, LastModifiedByUserID, LastModifiedOnDate, Level, LocalizedVersionGuid, PageHeadText, ParentId, PermanentRedirect, PortalID, RefreshInterval, SiteMapPriority, SkinSrc, StartDate, TabName, TabOrder, TabPath, Title, UniqueId, Url, VersionGuid, HasBeenPublished, IsSystem)
	VALUES (null, @TabContentItemId, @UserIdHost, @Fecha, null, null, '', 0, null, '', '', 0, 0, 1, '', @UserIdHost, @Fecha, @NivelEditores, NewId(), null, @TabIdMantenimientos, 0, @PortalId, null, 0.5, @SkinSrc, null, 'Fabricantes_Idiomas', 3, '//' + @NombrePaginaPadre + '//Fabricantes_Idiomas', '', NewId(), '', NewId(), 1, 0)

	set @TabId = SCOPE_IDENTITY()

	UPDATE dnn_ContentItems SET TabId = @TabId WHERE ContentItemID = @TabContentItemId

	INSERT INTO dnn_TabSettings (TabID, SettingName, SettingValue, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 'AllowIndex', 'True', @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabSettings (TabID, SettingName, SettingValue, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 'LinkNewWindow', 'False', @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 3, 1, @RoleIdHost, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 4, 1, @RoleIdHost, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 3, 1, @RoleIdAdministrador, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	INSERT INTO dnn_Packages (
		CreatedByUserID, 
		CreatedOnDate, 
		Description, 
		Email, 
		FriendlyName, 
		IsSystemPackage, 
		LastModifiedByUserID, 
		LastModifiedOnDate, 
		License, 
		Manifest, 
		Name, 
		Organization, 
		Owner,
		PackageType, 
		PortalID, 
		ReleaseNotes, 
		Url, 
		Version
	) VALUES (
		@UserIdHost, 
		@Fecha, 
		'Mantenimiento Fabricantes_Idiomas', 
		'', 
		'Mantenimiento Fabricantes_Idiomas', 
		0, 
		@UserIdHost, 
		@Fecha, 
		'El archivo de instalación no contiene información de la licencia. Verifique con el vendedor los detalles de la licencia.', 
		'<package name="CollectorsClub.EditorFabricantes_Idiomas" type="Module" version="1.0.0">
		<friendlyName>CollectorsClub - Mantenimiento Fabricantes_Idiomas</friendlyName>
		<description>CollectorsClub - Mantenimiento Fabricantes_Idiomas</description>
		<iconFile />
		<owner>
			<name>CollectorsClub</name>
			<organization />
			<url />
			<email />
		</owner>
		<license>El archivo de instalación no contiene información de la licencia. Verifique con el vendedor los detalles de la licencia.</license>
		<releaseNotes />
		<components>
			<component type="Module">
				<desktopModule>
					<moduleName>CollectorsClub.EditorFabricantes_Idiomas</moduleName>
					<foldername>CollectorsClub.EditorFabricantes_Idiomas</foldername>
					<businessControllerClass />
					<supportedFeatures />
					<moduleDefinitions>
						<moduleDefinition>
							<friendlyName>CollectorsClub - Mantenimiento Fabricantes_Idiomas</friendlyName>
							<definitionName>CollectorsClub - Mantenimiento Fabricantes_Idiomas</definitionName>
							<defaultCacheTime>0</defaultCacheTime>
							<moduleControls>
								<moduleControl>
									<controlKey />
									<controlSrc>DesktopModules/CollectorsClub/Editores/Fabricante_IdiomaEditorView.ascx</controlSrc>
									<supportsPartialRendering>False</supportsPartialRendering>
									<controlTitle />
									<controlType>View</controlType>
									<iconFile />
									<helpUrl />
									<supportsPopUps>False</supportsPopUps>
									<viewOrder>0</viewOrder>
								</moduleControl>
							</moduleControls>
						</moduleDefinition>
					</moduleDefinitions>
				</desktopModule>
			</component>
			<component type="File">
				<files>
					<basePath>DesktopModules\CollectorsClub\Editores</basePath>
					<file>
						<name>Fabricante_IdiomaEditorView.ascx</name>
						<sourceFileName>Fabricante_IdiomaEditorView.ascx</sourceFileName>
					</file>
				</files>
			</component>
		</components>
	</package>', 
		'CollectorsClub.EditorFabricantes_Idiomas', 
		'', 
		'CollectorsClub',
		'Module', 
		@PortalId, 
		'Este paquete no tiene notas de la versión', 
		'', 
		'1.0.0'
	)
	set @PackageId = SCOPE_IDENTITY()

	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Mantenimiento Fabricantes_Idiomas', 3, -1, -1, '', 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @DesktopModuleContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_DesktopModules (BusinessControllerClass, CompatibleVersions, ContentItemId, CreatedByUserID, CreatedOnDate, Dependencies, Description, FolderName, FriendlyName, IsAdmin, IsPremium, LastModifiedByUserID, LastModifiedOnDate, ModuleName, PackageID, Permissions, Shareable, SupportedFeatures, Version)
	VALUES ('', null, @DesktopModuleContentItemId, @UserIdHost, @Fecha, null, 'Mantenimiento Fabricantes_Idiomas', 'CollectorsClub.EditorFabricantes_Idiomas', 'Mantenimiento Fabricantes_Idiomas', 0, 0, @UserIdHost, @Fecha, 'CollectorsClub.EditorFabricantes_Idiomas', @PackageId, null, 0, 0, '01.00.00')

	set @DesktopModuleId = SCOPE_IDENTITY()

	INSERT INTO dnn_ModuleDefinitions (CreatedByUserID, CreatedOnDate, DefaultCacheTime, DefinitionName, DesktopModuleID, FriendlyName, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@UserIdHost, @Fecha, 0, 'Mantenimiento Fabricantes_Idiomas', @DesktopModuleId, 'Mantenimiento Fabricantes_Idiomas', @UserIdHost, @Fecha)

	set @ModuleDefinitionId = SCOPE_IDENTITY()

	INSERT INTO dnn_PortalDesktopModules (CreatedByUserID, CreatedOnDate, DesktopModuleID, LastModifiedByUserID, LastModifiedOnDate, PortalID)
	VALUES (@UserIdHost, @Fecha, @DesktopModuleId, @UserIdHost, @Fecha, @PortalId)

	set @PortalDesktopModuleId = SCOPE_IDENTITY()

	INSERT INTO dnn_DesktopModulePermission (AllowAccess, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, PermissionID, PortalDesktopModuleID, RoleID, UserID)
	VALUES (1, @UserIdHost, @Fecha, @UserIdHost, @Fecha, 7, @PortalDesktopModuleId, @RoleIdHost, null)

	INSERT INTO dnn_ModuleControls (ControlKey, ControlSrc, ControlTitle, ControlType, CreatedByUserID, CreatedOnDate, HelpUrl, IconFile, LastModifiedByUserID, LastModifiedOnDate, ModuleDefID, SupportsPartialRendering, SupportsPopUps, ViewOrder)
	VALUES (null, 'DesktopModules/CollectorsClub/Editores/Fabricante_IdiomaEditorView.ascx', null, 0, @UserIdHost, @Fecha, null, null, @UserIdHost, @Fecha, @ModuleDefinitionId, 0, 0, 0)

	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Mantenimiento Fabricantes_Idiomas', 2, @TabId, -1, null, 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @ModuleContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_Modules (AllTabs, ContentItemID, CreatedByUserID, CreatedOnDate, EndDate, InheritViewPermissions, IsDeleted, IsShareable, IsShareableViewOnly, LastContentModifiedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleDefID, PortalID, StartDate)
	VALUES (0, @ModuleContentItemId, @UserIdHost, @Fecha, null, 1, 0, 1, 1, null, @UserIdHost, @Fecha, @ModuleDefinitionId, @PortalId, null)

	set @ModuleId = SCOPE_IDENTITY()

	UPDATE dnn_ContentItems SET ModuleId = @ModuleId WHERE ContentItemID = @ModuleContentItemId

	INSERT INTO dnn_TabModules (Alignment, Border, CacheMethod, CacheTime, Color, ContainerSrc, CreatedByUserID, CreatedOnDate, CultureCode, DefaultLanguageGuid, DisplayPrint, DisplaySyndicate, DisplayTitle, Footer, Header, IconFile, IsDeleted, IsWebSlice,LastModifiedByUserID, LastModifiedOnDate, LocalizedVersionGuid, ModuleID, ModuleOrder, ModuleTitle, PaneName, TabID, UniqueId, VersionGuid, Visibility, WebSliceExpiryDate, WebSliceTitle, WebSliceTTL)
	VALUES (null, null, null, 0, null, null, @UserIdHost, @Fecha, '', null, 0, 0, 0, null, null, null, 0, 0, @UserIdHost, @Fecha, NewId(), @ModuleId, 3, 'Mantenimiento Fabricantes_Idiomas', 'ContentPane', @TabId, NewId(), NewId(), 2, null, '', 0)

	set @TabModuleId = SCOPE_IDENTITY()

	-- DNN No le crea ningún permiso
	--INSERT INTO dnn_TabModuleSettings (CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, SettingName, SettingValue, TabModuleID)
	--VALUES (@UserIdHost, @Fecha, @UserIdHost, @Fecha, '', '', @TabModuleId)

	INSERT INTO dnn_ModulePermission (AllowAccess, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleID, PermissionID, PortalID, RoleID, UserID)
	VALUES (1, @UserIdHost, @Fecha, @UserIdHost, @Fecha, @ModuleId, 2, @PortalId, @RoleIdHost, null)

	-- DNN No le crea ningún permiso
	--INSERT INTO dnn_ModuleSettings (CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleID, SettingName, SettingValue) 
	--VALUES (@UserIdHost, @Fecha, @UserIdHost, @Fecha, @ModuleId, '', '') 
end
------------------------------- Fin script del módulo Fabricantes_Idiomas  ------------------------------

------------------------------- Inicio script del módulo Fotos  ------------------------------
USE CollectorsClubDNN;
GO

declare @NombrePaginaPadre as nvarchar(50) = 'Mantenimiento'
declare @TabIdMantenimientos as int = (SELECT TabId FROM dnn_tabs WHERE TabName = @NombrePaginaPadre AND [Level] = 0)
declare @PortalId as int = 0
declare @UserIdHost as int = 1
declare @RoleIdHost as int = -2
declare @RoleIdAdministrador as int = 0 -- OLL en GA no quiero que lo vean los Administradores, solo Host, Sino pondría el 5
declare @NivelEditores as int = 1
declare @Fecha as datetime = GetDate()
declare @SkinSrc as nvarchar(100) = '[G]Skins/Porto/CollectorsClub-Inner.ascx'

declare @TabContentItemId as int
declare @TabId as int
declare @PackageId as int
declare @DesktopModuleContentItemId as int
declare @DesktopModuleId as int
declare @ModuleDefinitionId as int
declare @PortalDesktopModuleId as int
declare @ModuleContentItemId as int
declare @ModuleId as int
declare @TabModuleId as int


if not exists(SELECT ContentItemId FROM dnn_ContentItems WHERE Content = 'Fotos')
begin 
	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Fotos', 1, -1, -1, null, 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @TabContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_Tabs (ContainerSrc, ContentItemID, CreatedByUserID, CreatedOnDate, CultureCode, DefaultLanguageGuid, Description, DisableLink, EndDate, IconFile, IconFileLarge, IsDeleted, IsSecure, IsVisible, KeyWords, LastModifiedByUserID, LastModifiedOnDate, Level, LocalizedVersionGuid, PageHeadText, ParentId, PermanentRedirect, PortalID, RefreshInterval, SiteMapPriority, SkinSrc, StartDate, TabName, TabOrder, TabPath, Title, UniqueId, Url, VersionGuid, HasBeenPublished, IsSystem)
	VALUES (null, @TabContentItemId, @UserIdHost, @Fecha, null, null, '', 0, null, '', '', 0, 0, 1, '', @UserIdHost, @Fecha, @NivelEditores, NewId(), null, @TabIdMantenimientos, 0, @PortalId, null, 0.5, @SkinSrc, null, 'Fotos', 3, '//' + @NombrePaginaPadre + '//Fotos', '', NewId(), '', NewId(), 1, 0)

	set @TabId = SCOPE_IDENTITY()

	UPDATE dnn_ContentItems SET TabId = @TabId WHERE ContentItemID = @TabContentItemId

	INSERT INTO dnn_TabSettings (TabID, SettingName, SettingValue, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 'AllowIndex', 'True', @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabSettings (TabID, SettingName, SettingValue, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 'LinkNewWindow', 'False', @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 3, 1, @RoleIdHost, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 4, 1, @RoleIdHost, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 3, 1, @RoleIdAdministrador, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	INSERT INTO dnn_Packages (
		CreatedByUserID, 
		CreatedOnDate, 
		Description, 
		Email, 
		FriendlyName, 
		IsSystemPackage, 
		LastModifiedByUserID, 
		LastModifiedOnDate, 
		License, 
		Manifest, 
		Name, 
		Organization, 
		Owner,
		PackageType, 
		PortalID, 
		ReleaseNotes, 
		Url, 
		Version
	) VALUES (
		@UserIdHost, 
		@Fecha, 
		'Mantenimiento Fotos', 
		'', 
		'Mantenimiento Fotos', 
		0, 
		@UserIdHost, 
		@Fecha, 
		'El archivo de instalación no contiene información de la licencia. Verifique con el vendedor los detalles de la licencia.', 
		'<package name="CollectorsClub.EditorFotos" type="Module" version="1.0.0">
		<friendlyName>CollectorsClub - Mantenimiento Fotos</friendlyName>
		<description>CollectorsClub - Mantenimiento Fotos</description>
		<iconFile />
		<owner>
			<name>CollectorsClub</name>
			<organization />
			<url />
			<email />
		</owner>
		<license>El archivo de instalación no contiene información de la licencia. Verifique con el vendedor los detalles de la licencia.</license>
		<releaseNotes />
		<components>
			<component type="Module">
				<desktopModule>
					<moduleName>CollectorsClub.EditorFotos</moduleName>
					<foldername>CollectorsClub.EditorFotos</foldername>
					<businessControllerClass />
					<supportedFeatures />
					<moduleDefinitions>
						<moduleDefinition>
							<friendlyName>CollectorsClub - Mantenimiento Fotos</friendlyName>
							<definitionName>CollectorsClub - Mantenimiento Fotos</definitionName>
							<defaultCacheTime>0</defaultCacheTime>
							<moduleControls>
								<moduleControl>
									<controlKey />
									<controlSrc>DesktopModules/CollectorsClub/Editores/FotoEditorView.ascx</controlSrc>
									<supportsPartialRendering>False</supportsPartialRendering>
									<controlTitle />
									<controlType>View</controlType>
									<iconFile />
									<helpUrl />
									<supportsPopUps>False</supportsPopUps>
									<viewOrder>0</viewOrder>
								</moduleControl>
							</moduleControls>
						</moduleDefinition>
					</moduleDefinitions>
				</desktopModule>
			</component>
			<component type="File">
				<files>
					<basePath>DesktopModules\CollectorsClub\Editores</basePath>
					<file>
						<name>FotoEditorView.ascx</name>
						<sourceFileName>FotoEditorView.ascx</sourceFileName>
					</file>
				</files>
			</component>
		</components>
	</package>', 
		'CollectorsClub.EditorFotos', 
		'', 
		'CollectorsClub',
		'Module', 
		@PortalId, 
		'Este paquete no tiene notas de la versión', 
		'', 
		'1.0.0'
	)
	set @PackageId = SCOPE_IDENTITY()

	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Mantenimiento Fotos', 3, -1, -1, '', 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @DesktopModuleContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_DesktopModules (BusinessControllerClass, CompatibleVersions, ContentItemId, CreatedByUserID, CreatedOnDate, Dependencies, Description, FolderName, FriendlyName, IsAdmin, IsPremium, LastModifiedByUserID, LastModifiedOnDate, ModuleName, PackageID, Permissions, Shareable, SupportedFeatures, Version)
	VALUES ('', null, @DesktopModuleContentItemId, @UserIdHost, @Fecha, null, 'Mantenimiento Fotos', 'CollectorsClub.EditorFotos', 'Mantenimiento Fotos', 0, 0, @UserIdHost, @Fecha, 'CollectorsClub.EditorFotos', @PackageId, null, 0, 0, '01.00.00')

	set @DesktopModuleId = SCOPE_IDENTITY()

	INSERT INTO dnn_ModuleDefinitions (CreatedByUserID, CreatedOnDate, DefaultCacheTime, DefinitionName, DesktopModuleID, FriendlyName, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@UserIdHost, @Fecha, 0, 'Mantenimiento Fotos', @DesktopModuleId, 'Mantenimiento Fotos', @UserIdHost, @Fecha)

	set @ModuleDefinitionId = SCOPE_IDENTITY()

	INSERT INTO dnn_PortalDesktopModules (CreatedByUserID, CreatedOnDate, DesktopModuleID, LastModifiedByUserID, LastModifiedOnDate, PortalID)
	VALUES (@UserIdHost, @Fecha, @DesktopModuleId, @UserIdHost, @Fecha, @PortalId)

	set @PortalDesktopModuleId = SCOPE_IDENTITY()

	INSERT INTO dnn_DesktopModulePermission (AllowAccess, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, PermissionID, PortalDesktopModuleID, RoleID, UserID)
	VALUES (1, @UserIdHost, @Fecha, @UserIdHost, @Fecha, 7, @PortalDesktopModuleId, @RoleIdHost, null)

	INSERT INTO dnn_ModuleControls (ControlKey, ControlSrc, ControlTitle, ControlType, CreatedByUserID, CreatedOnDate, HelpUrl, IconFile, LastModifiedByUserID, LastModifiedOnDate, ModuleDefID, SupportsPartialRendering, SupportsPopUps, ViewOrder)
	VALUES (null, 'DesktopModules/CollectorsClub/Editores/FotoEditorView.ascx', null, 0, @UserIdHost, @Fecha, null, null, @UserIdHost, @Fecha, @ModuleDefinitionId, 0, 0, 0)

	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Mantenimiento Fotos', 2, @TabId, -1, null, 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @ModuleContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_Modules (AllTabs, ContentItemID, CreatedByUserID, CreatedOnDate, EndDate, InheritViewPermissions, IsDeleted, IsShareable, IsShareableViewOnly, LastContentModifiedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleDefID, PortalID, StartDate)
	VALUES (0, @ModuleContentItemId, @UserIdHost, @Fecha, null, 1, 0, 1, 1, null, @UserIdHost, @Fecha, @ModuleDefinitionId, @PortalId, null)

	set @ModuleId = SCOPE_IDENTITY()

	UPDATE dnn_ContentItems SET ModuleId = @ModuleId WHERE ContentItemID = @ModuleContentItemId

	INSERT INTO dnn_TabModules (Alignment, Border, CacheMethod, CacheTime, Color, ContainerSrc, CreatedByUserID, CreatedOnDate, CultureCode, DefaultLanguageGuid, DisplayPrint, DisplaySyndicate, DisplayTitle, Footer, Header, IconFile, IsDeleted, IsWebSlice,LastModifiedByUserID, LastModifiedOnDate, LocalizedVersionGuid, ModuleID, ModuleOrder, ModuleTitle, PaneName, TabID, UniqueId, VersionGuid, Visibility, WebSliceExpiryDate, WebSliceTitle, WebSliceTTL)
	VALUES (null, null, null, 0, null, null, @UserIdHost, @Fecha, '', null, 0, 0, 0, null, null, null, 0, 0, @UserIdHost, @Fecha, NewId(), @ModuleId, 3, 'Mantenimiento Fotos', 'ContentPane', @TabId, NewId(), NewId(), 2, null, '', 0)

	set @TabModuleId = SCOPE_IDENTITY()

	-- DNN No le crea ningún permiso
	--INSERT INTO dnn_TabModuleSettings (CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, SettingName, SettingValue, TabModuleID)
	--VALUES (@UserIdHost, @Fecha, @UserIdHost, @Fecha, '', '', @TabModuleId)

	INSERT INTO dnn_ModulePermission (AllowAccess, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleID, PermissionID, PortalID, RoleID, UserID)
	VALUES (1, @UserIdHost, @Fecha, @UserIdHost, @Fecha, @ModuleId, 2, @PortalId, @RoleIdHost, null)

	-- DNN No le crea ningún permiso
	--INSERT INTO dnn_ModuleSettings (CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleID, SettingName, SettingValue) 
	--VALUES (@UserIdHost, @Fecha, @UserIdHost, @Fecha, @ModuleId, '', '') 
end
------------------------------- Fin script del módulo Fotos  ------------------------------

------------------------------- Inicio script del módulo Fotos_Idiomas  ------------------------------
USE CollectorsClubDNN;
GO

declare @NombrePaginaPadre as nvarchar(50) = 'Mantenimiento'
declare @TabIdMantenimientos as int = (SELECT TabId FROM dnn_tabs WHERE TabName = @NombrePaginaPadre AND [Level] = 0)
declare @PortalId as int = 0
declare @UserIdHost as int = 1
declare @RoleIdHost as int = -2
declare @RoleIdAdministrador as int = 0 -- OLL en GA no quiero que lo vean los Administradores, solo Host, Sino pondría el 5
declare @NivelEditores as int = 1
declare @Fecha as datetime = GetDate()
declare @SkinSrc as nvarchar(100) = '[G]Skins/Porto/CollectorsClub-Inner.ascx'

declare @TabContentItemId as int
declare @TabId as int
declare @PackageId as int
declare @DesktopModuleContentItemId as int
declare @DesktopModuleId as int
declare @ModuleDefinitionId as int
declare @PortalDesktopModuleId as int
declare @ModuleContentItemId as int
declare @ModuleId as int
declare @TabModuleId as int


if not exists(SELECT ContentItemId FROM dnn_ContentItems WHERE Content = 'Fotos_Idiomas')
begin 
	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Fotos_Idiomas', 1, -1, -1, null, 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @TabContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_Tabs (ContainerSrc, ContentItemID, CreatedByUserID, CreatedOnDate, CultureCode, DefaultLanguageGuid, Description, DisableLink, EndDate, IconFile, IconFileLarge, IsDeleted, IsSecure, IsVisible, KeyWords, LastModifiedByUserID, LastModifiedOnDate, Level, LocalizedVersionGuid, PageHeadText, ParentId, PermanentRedirect, PortalID, RefreshInterval, SiteMapPriority, SkinSrc, StartDate, TabName, TabOrder, TabPath, Title, UniqueId, Url, VersionGuid, HasBeenPublished, IsSystem)
	VALUES (null, @TabContentItemId, @UserIdHost, @Fecha, null, null, '', 0, null, '', '', 0, 0, 1, '', @UserIdHost, @Fecha, @NivelEditores, NewId(), null, @TabIdMantenimientos, 0, @PortalId, null, 0.5, @SkinSrc, null, 'Fotos_Idiomas', 3, '//' + @NombrePaginaPadre + '//Fotos_Idiomas', '', NewId(), '', NewId(), 1, 0)

	set @TabId = SCOPE_IDENTITY()

	UPDATE dnn_ContentItems SET TabId = @TabId WHERE ContentItemID = @TabContentItemId

	INSERT INTO dnn_TabSettings (TabID, SettingName, SettingValue, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 'AllowIndex', 'True', @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabSettings (TabID, SettingName, SettingValue, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 'LinkNewWindow', 'False', @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 3, 1, @RoleIdHost, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 4, 1, @RoleIdHost, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 3, 1, @RoleIdAdministrador, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	INSERT INTO dnn_Packages (
		CreatedByUserID, 
		CreatedOnDate, 
		Description, 
		Email, 
		FriendlyName, 
		IsSystemPackage, 
		LastModifiedByUserID, 
		LastModifiedOnDate, 
		License, 
		Manifest, 
		Name, 
		Organization, 
		Owner,
		PackageType, 
		PortalID, 
		ReleaseNotes, 
		Url, 
		Version
	) VALUES (
		@UserIdHost, 
		@Fecha, 
		'Mantenimiento Fotos_Idiomas', 
		'', 
		'Mantenimiento Fotos_Idiomas', 
		0, 
		@UserIdHost, 
		@Fecha, 
		'El archivo de instalación no contiene información de la licencia. Verifique con el vendedor los detalles de la licencia.', 
		'<package name="CollectorsClub.EditorFotos_Idiomas" type="Module" version="1.0.0">
		<friendlyName>CollectorsClub - Mantenimiento Fotos_Idiomas</friendlyName>
		<description>CollectorsClub - Mantenimiento Fotos_Idiomas</description>
		<iconFile />
		<owner>
			<name>CollectorsClub</name>
			<organization />
			<url />
			<email />
		</owner>
		<license>El archivo de instalación no contiene información de la licencia. Verifique con el vendedor los detalles de la licencia.</license>
		<releaseNotes />
		<components>
			<component type="Module">
				<desktopModule>
					<moduleName>CollectorsClub.EditorFotos_Idiomas</moduleName>
					<foldername>CollectorsClub.EditorFotos_Idiomas</foldername>
					<businessControllerClass />
					<supportedFeatures />
					<moduleDefinitions>
						<moduleDefinition>
							<friendlyName>CollectorsClub - Mantenimiento Fotos_Idiomas</friendlyName>
							<definitionName>CollectorsClub - Mantenimiento Fotos_Idiomas</definitionName>
							<defaultCacheTime>0</defaultCacheTime>
							<moduleControls>
								<moduleControl>
									<controlKey />
									<controlSrc>DesktopModules/CollectorsClub/Editores/Foto_IdiomaEditorView.ascx</controlSrc>
									<supportsPartialRendering>False</supportsPartialRendering>
									<controlTitle />
									<controlType>View</controlType>
									<iconFile />
									<helpUrl />
									<supportsPopUps>False</supportsPopUps>
									<viewOrder>0</viewOrder>
								</moduleControl>
							</moduleControls>
						</moduleDefinition>
					</moduleDefinitions>
				</desktopModule>
			</component>
			<component type="File">
				<files>
					<basePath>DesktopModules\CollectorsClub\Editores</basePath>
					<file>
						<name>Foto_IdiomaEditorView.ascx</name>
						<sourceFileName>Foto_IdiomaEditorView.ascx</sourceFileName>
					</file>
				</files>
			</component>
		</components>
	</package>', 
		'CollectorsClub.EditorFotos_Idiomas', 
		'', 
		'CollectorsClub',
		'Module', 
		@PortalId, 
		'Este paquete no tiene notas de la versión', 
		'', 
		'1.0.0'
	)
	set @PackageId = SCOPE_IDENTITY()

	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Mantenimiento Fotos_Idiomas', 3, -1, -1, '', 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @DesktopModuleContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_DesktopModules (BusinessControllerClass, CompatibleVersions, ContentItemId, CreatedByUserID, CreatedOnDate, Dependencies, Description, FolderName, FriendlyName, IsAdmin, IsPremium, LastModifiedByUserID, LastModifiedOnDate, ModuleName, PackageID, Permissions, Shareable, SupportedFeatures, Version)
	VALUES ('', null, @DesktopModuleContentItemId, @UserIdHost, @Fecha, null, 'Mantenimiento Fotos_Idiomas', 'CollectorsClub.EditorFotos_Idiomas', 'Mantenimiento Fotos_Idiomas', 0, 0, @UserIdHost, @Fecha, 'CollectorsClub.EditorFotos_Idiomas', @PackageId, null, 0, 0, '01.00.00')

	set @DesktopModuleId = SCOPE_IDENTITY()

	INSERT INTO dnn_ModuleDefinitions (CreatedByUserID, CreatedOnDate, DefaultCacheTime, DefinitionName, DesktopModuleID, FriendlyName, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@UserIdHost, @Fecha, 0, 'Mantenimiento Fotos_Idiomas', @DesktopModuleId, 'Mantenimiento Fotos_Idiomas', @UserIdHost, @Fecha)

	set @ModuleDefinitionId = SCOPE_IDENTITY()

	INSERT INTO dnn_PortalDesktopModules (CreatedByUserID, CreatedOnDate, DesktopModuleID, LastModifiedByUserID, LastModifiedOnDate, PortalID)
	VALUES (@UserIdHost, @Fecha, @DesktopModuleId, @UserIdHost, @Fecha, @PortalId)

	set @PortalDesktopModuleId = SCOPE_IDENTITY()

	INSERT INTO dnn_DesktopModulePermission (AllowAccess, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, PermissionID, PortalDesktopModuleID, RoleID, UserID)
	VALUES (1, @UserIdHost, @Fecha, @UserIdHost, @Fecha, 7, @PortalDesktopModuleId, @RoleIdHost, null)

	INSERT INTO dnn_ModuleControls (ControlKey, ControlSrc, ControlTitle, ControlType, CreatedByUserID, CreatedOnDate, HelpUrl, IconFile, LastModifiedByUserID, LastModifiedOnDate, ModuleDefID, SupportsPartialRendering, SupportsPopUps, ViewOrder)
	VALUES (null, 'DesktopModules/CollectorsClub/Editores/Foto_IdiomaEditorView.ascx', null, 0, @UserIdHost, @Fecha, null, null, @UserIdHost, @Fecha, @ModuleDefinitionId, 0, 0, 0)

	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Mantenimiento Fotos_Idiomas', 2, @TabId, -1, null, 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @ModuleContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_Modules (AllTabs, ContentItemID, CreatedByUserID, CreatedOnDate, EndDate, InheritViewPermissions, IsDeleted, IsShareable, IsShareableViewOnly, LastContentModifiedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleDefID, PortalID, StartDate)
	VALUES (0, @ModuleContentItemId, @UserIdHost, @Fecha, null, 1, 0, 1, 1, null, @UserIdHost, @Fecha, @ModuleDefinitionId, @PortalId, null)

	set @ModuleId = SCOPE_IDENTITY()

	UPDATE dnn_ContentItems SET ModuleId = @ModuleId WHERE ContentItemID = @ModuleContentItemId

	INSERT INTO dnn_TabModules (Alignment, Border, CacheMethod, CacheTime, Color, ContainerSrc, CreatedByUserID, CreatedOnDate, CultureCode, DefaultLanguageGuid, DisplayPrint, DisplaySyndicate, DisplayTitle, Footer, Header, IconFile, IsDeleted, IsWebSlice,LastModifiedByUserID, LastModifiedOnDate, LocalizedVersionGuid, ModuleID, ModuleOrder, ModuleTitle, PaneName, TabID, UniqueId, VersionGuid, Visibility, WebSliceExpiryDate, WebSliceTitle, WebSliceTTL)
	VALUES (null, null, null, 0, null, null, @UserIdHost, @Fecha, '', null, 0, 0, 0, null, null, null, 0, 0, @UserIdHost, @Fecha, NewId(), @ModuleId, 3, 'Mantenimiento Fotos_Idiomas', 'ContentPane', @TabId, NewId(), NewId(), 2, null, '', 0)

	set @TabModuleId = SCOPE_IDENTITY()

	-- DNN No le crea ningún permiso
	--INSERT INTO dnn_TabModuleSettings (CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, SettingName, SettingValue, TabModuleID)
	--VALUES (@UserIdHost, @Fecha, @UserIdHost, @Fecha, '', '', @TabModuleId)

	INSERT INTO dnn_ModulePermission (AllowAccess, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleID, PermissionID, PortalID, RoleID, UserID)
	VALUES (1, @UserIdHost, @Fecha, @UserIdHost, @Fecha, @ModuleId, 2, @PortalId, @RoleIdHost, null)

	-- DNN No le crea ningún permiso
	--INSERT INTO dnn_ModuleSettings (CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleID, SettingName, SettingValue) 
	--VALUES (@UserIdHost, @Fecha, @UserIdHost, @Fecha, @ModuleId, '', '') 
end
------------------------------- Fin script del módulo Fotos_Idiomas  ------------------------------

------------------------------- Inicio script del módulo Marcas  ------------------------------
USE CollectorsClubDNN;
GO

declare @NombrePaginaPadre as nvarchar(50) = 'Mantenimiento'
declare @TabIdMantenimientos as int = (SELECT TabId FROM dnn_tabs WHERE TabName = @NombrePaginaPadre AND [Level] = 0)
declare @PortalId as int = 0
declare @UserIdHost as int = 1
declare @RoleIdHost as int = -2
declare @RoleIdAdministrador as int = 0 -- OLL en GA no quiero que lo vean los Administradores, solo Host, Sino pondría el 5
declare @NivelEditores as int = 1
declare @Fecha as datetime = GetDate()
declare @SkinSrc as nvarchar(100) = '[G]Skins/Porto/CollectorsClub-Inner.ascx'

declare @TabContentItemId as int
declare @TabId as int
declare @PackageId as int
declare @DesktopModuleContentItemId as int
declare @DesktopModuleId as int
declare @ModuleDefinitionId as int
declare @PortalDesktopModuleId as int
declare @ModuleContentItemId as int
declare @ModuleId as int
declare @TabModuleId as int


if not exists(SELECT ContentItemId FROM dnn_ContentItems WHERE Content = 'Marcas')
begin 
	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Marcas', 1, -1, -1, null, 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @TabContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_Tabs (ContainerSrc, ContentItemID, CreatedByUserID, CreatedOnDate, CultureCode, DefaultLanguageGuid, Description, DisableLink, EndDate, IconFile, IconFileLarge, IsDeleted, IsSecure, IsVisible, KeyWords, LastModifiedByUserID, LastModifiedOnDate, Level, LocalizedVersionGuid, PageHeadText, ParentId, PermanentRedirect, PortalID, RefreshInterval, SiteMapPriority, SkinSrc, StartDate, TabName, TabOrder, TabPath, Title, UniqueId, Url, VersionGuid, HasBeenPublished, IsSystem)
	VALUES (null, @TabContentItemId, @UserIdHost, @Fecha, null, null, '', 0, null, '', '', 0, 0, 1, '', @UserIdHost, @Fecha, @NivelEditores, NewId(), null, @TabIdMantenimientos, 0, @PortalId, null, 0.5, @SkinSrc, null, 'Marcas', 3, '//' + @NombrePaginaPadre + '//Marcas', '', NewId(), '', NewId(), 1, 0)

	set @TabId = SCOPE_IDENTITY()

	UPDATE dnn_ContentItems SET TabId = @TabId WHERE ContentItemID = @TabContentItemId

	INSERT INTO dnn_TabSettings (TabID, SettingName, SettingValue, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 'AllowIndex', 'True', @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabSettings (TabID, SettingName, SettingValue, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 'LinkNewWindow', 'False', @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 3, 1, @RoleIdHost, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 4, 1, @RoleIdHost, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 3, 1, @RoleIdAdministrador, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	INSERT INTO dnn_Packages (
		CreatedByUserID, 
		CreatedOnDate, 
		Description, 
		Email, 
		FriendlyName, 
		IsSystemPackage, 
		LastModifiedByUserID, 
		LastModifiedOnDate, 
		License, 
		Manifest, 
		Name, 
		Organization, 
		Owner,
		PackageType, 
		PortalID, 
		ReleaseNotes, 
		Url, 
		Version
	) VALUES (
		@UserIdHost, 
		@Fecha, 
		'Mantenimiento Marcas', 
		'', 
		'Mantenimiento Marcas', 
		0, 
		@UserIdHost, 
		@Fecha, 
		'El archivo de instalación no contiene información de la licencia. Verifique con el vendedor los detalles de la licencia.', 
		'<package name="CollectorsClub.EditorMarcas" type="Module" version="1.0.0">
		<friendlyName>CollectorsClub - Mantenimiento Marcas</friendlyName>
		<description>CollectorsClub - Mantenimiento Marcas</description>
		<iconFile />
		<owner>
			<name>CollectorsClub</name>
			<organization />
			<url />
			<email />
		</owner>
		<license>El archivo de instalación no contiene información de la licencia. Verifique con el vendedor los detalles de la licencia.</license>
		<releaseNotes />
		<components>
			<component type="Module">
				<desktopModule>
					<moduleName>CollectorsClub.EditorMarcas</moduleName>
					<foldername>CollectorsClub.EditorMarcas</foldername>
					<businessControllerClass />
					<supportedFeatures />
					<moduleDefinitions>
						<moduleDefinition>
							<friendlyName>CollectorsClub - Mantenimiento Marcas</friendlyName>
							<definitionName>CollectorsClub - Mantenimiento Marcas</definitionName>
							<defaultCacheTime>0</defaultCacheTime>
							<moduleControls>
								<moduleControl>
									<controlKey />
									<controlSrc>DesktopModules/CollectorsClub/Editores/MarcaEditorView.ascx</controlSrc>
									<supportsPartialRendering>False</supportsPartialRendering>
									<controlTitle />
									<controlType>View</controlType>
									<iconFile />
									<helpUrl />
									<supportsPopUps>False</supportsPopUps>
									<viewOrder>0</viewOrder>
								</moduleControl>
							</moduleControls>
						</moduleDefinition>
					</moduleDefinitions>
				</desktopModule>
			</component>
			<component type="File">
				<files>
					<basePath>DesktopModules\CollectorsClub\Editores</basePath>
					<file>
						<name>MarcaEditorView.ascx</name>
						<sourceFileName>MarcaEditorView.ascx</sourceFileName>
					</file>
				</files>
			</component>
		</components>
	</package>', 
		'CollectorsClub.EditorMarcas', 
		'', 
		'CollectorsClub',
		'Module', 
		@PortalId, 
		'Este paquete no tiene notas de la versión', 
		'', 
		'1.0.0'
	)
	set @PackageId = SCOPE_IDENTITY()

	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Mantenimiento Marcas', 3, -1, -1, '', 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @DesktopModuleContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_DesktopModules (BusinessControllerClass, CompatibleVersions, ContentItemId, CreatedByUserID, CreatedOnDate, Dependencies, Description, FolderName, FriendlyName, IsAdmin, IsPremium, LastModifiedByUserID, LastModifiedOnDate, ModuleName, PackageID, Permissions, Shareable, SupportedFeatures, Version)
	VALUES ('', null, @DesktopModuleContentItemId, @UserIdHost, @Fecha, null, 'Mantenimiento Marcas', 'CollectorsClub.EditorMarcas', 'Mantenimiento Marcas', 0, 0, @UserIdHost, @Fecha, 'CollectorsClub.EditorMarcas', @PackageId, null, 0, 0, '01.00.00')

	set @DesktopModuleId = SCOPE_IDENTITY()

	INSERT INTO dnn_ModuleDefinitions (CreatedByUserID, CreatedOnDate, DefaultCacheTime, DefinitionName, DesktopModuleID, FriendlyName, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@UserIdHost, @Fecha, 0, 'Mantenimiento Marcas', @DesktopModuleId, 'Mantenimiento Marcas', @UserIdHost, @Fecha)

	set @ModuleDefinitionId = SCOPE_IDENTITY()

	INSERT INTO dnn_PortalDesktopModules (CreatedByUserID, CreatedOnDate, DesktopModuleID, LastModifiedByUserID, LastModifiedOnDate, PortalID)
	VALUES (@UserIdHost, @Fecha, @DesktopModuleId, @UserIdHost, @Fecha, @PortalId)

	set @PortalDesktopModuleId = SCOPE_IDENTITY()

	INSERT INTO dnn_DesktopModulePermission (AllowAccess, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, PermissionID, PortalDesktopModuleID, RoleID, UserID)
	VALUES (1, @UserIdHost, @Fecha, @UserIdHost, @Fecha, 7, @PortalDesktopModuleId, @RoleIdHost, null)

	INSERT INTO dnn_ModuleControls (ControlKey, ControlSrc, ControlTitle, ControlType, CreatedByUserID, CreatedOnDate, HelpUrl, IconFile, LastModifiedByUserID, LastModifiedOnDate, ModuleDefID, SupportsPartialRendering, SupportsPopUps, ViewOrder)
	VALUES (null, 'DesktopModules/CollectorsClub/Editores/MarcaEditorView.ascx', null, 0, @UserIdHost, @Fecha, null, null, @UserIdHost, @Fecha, @ModuleDefinitionId, 0, 0, 0)

	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Mantenimiento Marcas', 2, @TabId, -1, null, 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @ModuleContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_Modules (AllTabs, ContentItemID, CreatedByUserID, CreatedOnDate, EndDate, InheritViewPermissions, IsDeleted, IsShareable, IsShareableViewOnly, LastContentModifiedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleDefID, PortalID, StartDate)
	VALUES (0, @ModuleContentItemId, @UserIdHost, @Fecha, null, 1, 0, 1, 1, null, @UserIdHost, @Fecha, @ModuleDefinitionId, @PortalId, null)

	set @ModuleId = SCOPE_IDENTITY()

	UPDATE dnn_ContentItems SET ModuleId = @ModuleId WHERE ContentItemID = @ModuleContentItemId

	INSERT INTO dnn_TabModules (Alignment, Border, CacheMethod, CacheTime, Color, ContainerSrc, CreatedByUserID, CreatedOnDate, CultureCode, DefaultLanguageGuid, DisplayPrint, DisplaySyndicate, DisplayTitle, Footer, Header, IconFile, IsDeleted, IsWebSlice,LastModifiedByUserID, LastModifiedOnDate, LocalizedVersionGuid, ModuleID, ModuleOrder, ModuleTitle, PaneName, TabID, UniqueId, VersionGuid, Visibility, WebSliceExpiryDate, WebSliceTitle, WebSliceTTL)
	VALUES (null, null, null, 0, null, null, @UserIdHost, @Fecha, '', null, 0, 0, 0, null, null, null, 0, 0, @UserIdHost, @Fecha, NewId(), @ModuleId, 3, 'Mantenimiento Marcas', 'ContentPane', @TabId, NewId(), NewId(), 2, null, '', 0)

	set @TabModuleId = SCOPE_IDENTITY()

	-- DNN No le crea ningún permiso
	--INSERT INTO dnn_TabModuleSettings (CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, SettingName, SettingValue, TabModuleID)
	--VALUES (@UserIdHost, @Fecha, @UserIdHost, @Fecha, '', '', @TabModuleId)

	INSERT INTO dnn_ModulePermission (AllowAccess, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleID, PermissionID, PortalID, RoleID, UserID)
	VALUES (1, @UserIdHost, @Fecha, @UserIdHost, @Fecha, @ModuleId, 2, @PortalId, @RoleIdHost, null)

	-- DNN No le crea ningún permiso
	--INSERT INTO dnn_ModuleSettings (CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleID, SettingName, SettingValue) 
	--VALUES (@UserIdHost, @Fecha, @UserIdHost, @Fecha, @ModuleId, '', '') 
end
------------------------------- Fin script del módulo Marcas  ------------------------------

------------------------------- Inicio script del módulo SolicitudesContacto  ------------------------------
USE CollectorsClubDNN;
GO

declare @NombrePaginaPadre as nvarchar(50) = 'Mantenimiento'
declare @TabIdMantenimientos as int = (SELECT TabId FROM dnn_tabs WHERE TabName = @NombrePaginaPadre AND [Level] = 0)
declare @PortalId as int = 0
declare @UserIdHost as int = 1
declare @RoleIdHost as int = -2
declare @RoleIdAdministrador as int = 0 -- OLL en GA no quiero que lo vean los Administradores, solo Host, Sino pondría el 5
declare @NivelEditores as int = 1
declare @Fecha as datetime = GetDate()
declare @SkinSrc as nvarchar(100) = '[G]Skins/Porto/CollectorsClub-Inner.ascx'

declare @TabContentItemId as int
declare @TabId as int
declare @PackageId as int
declare @DesktopModuleContentItemId as int
declare @DesktopModuleId as int
declare @ModuleDefinitionId as int
declare @PortalDesktopModuleId as int
declare @ModuleContentItemId as int
declare @ModuleId as int
declare @TabModuleId as int


if not exists(SELECT ContentItemId FROM dnn_ContentItems WHERE Content = 'SolicitudesContacto')
begin 
	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('SolicitudesContacto', 1, -1, -1, null, 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @TabContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_Tabs (ContainerSrc, ContentItemID, CreatedByUserID, CreatedOnDate, CultureCode, DefaultLanguageGuid, Description, DisableLink, EndDate, IconFile, IconFileLarge, IsDeleted, IsSecure, IsVisible, KeyWords, LastModifiedByUserID, LastModifiedOnDate, Level, LocalizedVersionGuid, PageHeadText, ParentId, PermanentRedirect, PortalID, RefreshInterval, SiteMapPriority, SkinSrc, StartDate, TabName, TabOrder, TabPath, Title, UniqueId, Url, VersionGuid, HasBeenPublished, IsSystem)
	VALUES (null, @TabContentItemId, @UserIdHost, @Fecha, null, null, '', 0, null, '', '', 0, 0, 1, '', @UserIdHost, @Fecha, @NivelEditores, NewId(), null, @TabIdMantenimientos, 0, @PortalId, null, 0.5, @SkinSrc, null, 'SolicitudesContacto', 3, '//' + @NombrePaginaPadre + '//SolicitudesContacto', '', NewId(), '', NewId(), 1, 0)

	set @TabId = SCOPE_IDENTITY()

	UPDATE dnn_ContentItems SET TabId = @TabId WHERE ContentItemID = @TabContentItemId

	INSERT INTO dnn_TabSettings (TabID, SettingName, SettingValue, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 'AllowIndex', 'True', @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabSettings (TabID, SettingName, SettingValue, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 'LinkNewWindow', 'False', @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 3, 1, @RoleIdHost, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 4, 1, @RoleIdHost, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 3, 1, @RoleIdAdministrador, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	INSERT INTO dnn_Packages (
		CreatedByUserID, 
		CreatedOnDate, 
		Description, 
		Email, 
		FriendlyName, 
		IsSystemPackage, 
		LastModifiedByUserID, 
		LastModifiedOnDate, 
		License, 
		Manifest, 
		Name, 
		Organization, 
		Owner,
		PackageType, 
		PortalID, 
		ReleaseNotes, 
		Url, 
		Version
	) VALUES (
		@UserIdHost, 
		@Fecha, 
		'Mantenimiento SolicitudesContacto', 
		'', 
		'Mantenimiento SolicitudesContacto', 
		0, 
		@UserIdHost, 
		@Fecha, 
		'El archivo de instalación no contiene información de la licencia. Verifique con el vendedor los detalles de la licencia.', 
		'<package name="CollectorsClub.EditorSolicitudesContacto" type="Module" version="1.0.0">
		<friendlyName>CollectorsClub - Mantenimiento SolicitudesContacto</friendlyName>
		<description>CollectorsClub - Mantenimiento SolicitudesContacto</description>
		<iconFile />
		<owner>
			<name>CollectorsClub</name>
			<organization />
			<url />
			<email />
		</owner>
		<license>El archivo de instalación no contiene información de la licencia. Verifique con el vendedor los detalles de la licencia.</license>
		<releaseNotes />
		<components>
			<component type="Module">
				<desktopModule>
					<moduleName>CollectorsClub.EditorSolicitudesContacto</moduleName>
					<foldername>CollectorsClub.EditorSolicitudesContacto</foldername>
					<businessControllerClass />
					<supportedFeatures />
					<moduleDefinitions>
						<moduleDefinition>
							<friendlyName>CollectorsClub - Mantenimiento SolicitudesContacto</friendlyName>
							<definitionName>CollectorsClub - Mantenimiento SolicitudesContacto</definitionName>
							<defaultCacheTime>0</defaultCacheTime>
							<moduleControls>
								<moduleControl>
									<controlKey />
									<controlSrc>DesktopModules/CollectorsClub/Editores/SolicitudContactoEditorView.ascx</controlSrc>
									<supportsPartialRendering>False</supportsPartialRendering>
									<controlTitle />
									<controlType>View</controlType>
									<iconFile />
									<helpUrl />
									<supportsPopUps>False</supportsPopUps>
									<viewOrder>0</viewOrder>
								</moduleControl>
							</moduleControls>
						</moduleDefinition>
					</moduleDefinitions>
				</desktopModule>
			</component>
			<component type="File">
				<files>
					<basePath>DesktopModules\CollectorsClub\Editores</basePath>
					<file>
						<name>SolicitudContactoEditorView.ascx</name>
						<sourceFileName>SolicitudContactoEditorView.ascx</sourceFileName>
					</file>
				</files>
			</component>
		</components>
	</package>', 
		'CollectorsClub.EditorSolicitudesContacto', 
		'', 
		'CollectorsClub',
		'Module', 
		@PortalId, 
		'Este paquete no tiene notas de la versión', 
		'', 
		'1.0.0'
	)
	set @PackageId = SCOPE_IDENTITY()

	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Mantenimiento SolicitudesContacto', 3, -1, -1, '', 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @DesktopModuleContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_DesktopModules (BusinessControllerClass, CompatibleVersions, ContentItemId, CreatedByUserID, CreatedOnDate, Dependencies, Description, FolderName, FriendlyName, IsAdmin, IsPremium, LastModifiedByUserID, LastModifiedOnDate, ModuleName, PackageID, Permissions, Shareable, SupportedFeatures, Version)
	VALUES ('', null, @DesktopModuleContentItemId, @UserIdHost, @Fecha, null, 'Mantenimiento SolicitudesContacto', 'CollectorsClub.EditorSolicitudesContacto', 'Mantenimiento SolicitudesContacto', 0, 0, @UserIdHost, @Fecha, 'CollectorsClub.EditorSolicitudesContacto', @PackageId, null, 0, 0, '01.00.00')

	set @DesktopModuleId = SCOPE_IDENTITY()

	INSERT INTO dnn_ModuleDefinitions (CreatedByUserID, CreatedOnDate, DefaultCacheTime, DefinitionName, DesktopModuleID, FriendlyName, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@UserIdHost, @Fecha, 0, 'Mantenimiento SolicitudesContacto', @DesktopModuleId, 'Mantenimiento SolicitudesContacto', @UserIdHost, @Fecha)

	set @ModuleDefinitionId = SCOPE_IDENTITY()

	INSERT INTO dnn_PortalDesktopModules (CreatedByUserID, CreatedOnDate, DesktopModuleID, LastModifiedByUserID, LastModifiedOnDate, PortalID)
	VALUES (@UserIdHost, @Fecha, @DesktopModuleId, @UserIdHost, @Fecha, @PortalId)

	set @PortalDesktopModuleId = SCOPE_IDENTITY()

	INSERT INTO dnn_DesktopModulePermission (AllowAccess, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, PermissionID, PortalDesktopModuleID, RoleID, UserID)
	VALUES (1, @UserIdHost, @Fecha, @UserIdHost, @Fecha, 7, @PortalDesktopModuleId, @RoleIdHost, null)

	INSERT INTO dnn_ModuleControls (ControlKey, ControlSrc, ControlTitle, ControlType, CreatedByUserID, CreatedOnDate, HelpUrl, IconFile, LastModifiedByUserID, LastModifiedOnDate, ModuleDefID, SupportsPartialRendering, SupportsPopUps, ViewOrder)
	VALUES (null, 'DesktopModules/CollectorsClub/Editores/SolicitudContactoEditorView.ascx', null, 0, @UserIdHost, @Fecha, null, null, @UserIdHost, @Fecha, @ModuleDefinitionId, 0, 0, 0)

	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Mantenimiento SolicitudesContacto', 2, @TabId, -1, null, 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @ModuleContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_Modules (AllTabs, ContentItemID, CreatedByUserID, CreatedOnDate, EndDate, InheritViewPermissions, IsDeleted, IsShareable, IsShareableViewOnly, LastContentModifiedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleDefID, PortalID, StartDate)
	VALUES (0, @ModuleContentItemId, @UserIdHost, @Fecha, null, 1, 0, 1, 1, null, @UserIdHost, @Fecha, @ModuleDefinitionId, @PortalId, null)

	set @ModuleId = SCOPE_IDENTITY()

	UPDATE dnn_ContentItems SET ModuleId = @ModuleId WHERE ContentItemID = @ModuleContentItemId

	INSERT INTO dnn_TabModules (Alignment, Border, CacheMethod, CacheTime, Color, ContainerSrc, CreatedByUserID, CreatedOnDate, CultureCode, DefaultLanguageGuid, DisplayPrint, DisplaySyndicate, DisplayTitle, Footer, Header, IconFile, IsDeleted, IsWebSlice,LastModifiedByUserID, LastModifiedOnDate, LocalizedVersionGuid, ModuleID, ModuleOrder, ModuleTitle, PaneName, TabID, UniqueId, VersionGuid, Visibility, WebSliceExpiryDate, WebSliceTitle, WebSliceTTL)
	VALUES (null, null, null, 0, null, null, @UserIdHost, @Fecha, '', null, 0, 0, 0, null, null, null, 0, 0, @UserIdHost, @Fecha, NewId(), @ModuleId, 3, 'Mantenimiento SolicitudesContacto', 'ContentPane', @TabId, NewId(), NewId(), 2, null, '', 0)

	set @TabModuleId = SCOPE_IDENTITY()

	-- DNN No le crea ningún permiso
	--INSERT INTO dnn_TabModuleSettings (CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, SettingName, SettingValue, TabModuleID)
	--VALUES (@UserIdHost, @Fecha, @UserIdHost, @Fecha, '', '', @TabModuleId)

	INSERT INTO dnn_ModulePermission (AllowAccess, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleID, PermissionID, PortalID, RoleID, UserID)
	VALUES (1, @UserIdHost, @Fecha, @UserIdHost, @Fecha, @ModuleId, 2, @PortalId, @RoleIdHost, null)

	-- DNN No le crea ningún permiso
	--INSERT INTO dnn_ModuleSettings (CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleID, SettingName, SettingValue) 
	--VALUES (@UserIdHost, @Fecha, @UserIdHost, @Fecha, @ModuleId, '', '') 
end
------------------------------- Fin script del módulo SolicitudesContacto  ------------------------------

------------------------------- Inicio script del módulo SubcategoriasCalendario  ------------------------------
USE CollectorsClubDNN;
GO

declare @NombrePaginaPadre as nvarchar(50) = 'Mantenimiento'
declare @TabIdMantenimientos as int = (SELECT TabId FROM dnn_tabs WHERE TabName = @NombrePaginaPadre AND [Level] = 0)
declare @PortalId as int = 0
declare @UserIdHost as int = 1
declare @RoleIdHost as int = -2
declare @RoleIdAdministrador as int = 0 -- OLL en GA no quiero que lo vean los Administradores, solo Host, Sino pondría el 5
declare @NivelEditores as int = 1
declare @Fecha as datetime = GetDate()
declare @SkinSrc as nvarchar(100) = '[G]Skins/Porto/CollectorsClub-Inner.ascx'

declare @TabContentItemId as int
declare @TabId as int
declare @PackageId as int
declare @DesktopModuleContentItemId as int
declare @DesktopModuleId as int
declare @ModuleDefinitionId as int
declare @PortalDesktopModuleId as int
declare @ModuleContentItemId as int
declare @ModuleId as int
declare @TabModuleId as int


if not exists(SELECT ContentItemId FROM dnn_ContentItems WHERE Content = 'SubcategoriasCalendario')
begin 
	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('SubcategoriasCalendario', 1, -1, -1, null, 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @TabContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_Tabs (ContainerSrc, ContentItemID, CreatedByUserID, CreatedOnDate, CultureCode, DefaultLanguageGuid, Description, DisableLink, EndDate, IconFile, IconFileLarge, IsDeleted, IsSecure, IsVisible, KeyWords, LastModifiedByUserID, LastModifiedOnDate, Level, LocalizedVersionGuid, PageHeadText, ParentId, PermanentRedirect, PortalID, RefreshInterval, SiteMapPriority, SkinSrc, StartDate, TabName, TabOrder, TabPath, Title, UniqueId, Url, VersionGuid, HasBeenPublished, IsSystem)
	VALUES (null, @TabContentItemId, @UserIdHost, @Fecha, null, null, '', 0, null, '', '', 0, 0, 1, '', @UserIdHost, @Fecha, @NivelEditores, NewId(), null, @TabIdMantenimientos, 0, @PortalId, null, 0.5, @SkinSrc, null, 'SubcategoriasCalendario', 3, '//' + @NombrePaginaPadre + '//SubcategoriasCalendario', '', NewId(), '', NewId(), 1, 0)

	set @TabId = SCOPE_IDENTITY()

	UPDATE dnn_ContentItems SET TabId = @TabId WHERE ContentItemID = @TabContentItemId

	INSERT INTO dnn_TabSettings (TabID, SettingName, SettingValue, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 'AllowIndex', 'True', @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabSettings (TabID, SettingName, SettingValue, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 'LinkNewWindow', 'False', @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 3, 1, @RoleIdHost, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 4, 1, @RoleIdHost, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 3, 1, @RoleIdAdministrador, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	INSERT INTO dnn_Packages (
		CreatedByUserID, 
		CreatedOnDate, 
		Description, 
		Email, 
		FriendlyName, 
		IsSystemPackage, 
		LastModifiedByUserID, 
		LastModifiedOnDate, 
		License, 
		Manifest, 
		Name, 
		Organization, 
		Owner,
		PackageType, 
		PortalID, 
		ReleaseNotes, 
		Url, 
		Version
	) VALUES (
		@UserIdHost, 
		@Fecha, 
		'Mantenimiento SubcategoriasCalendario', 
		'', 
		'Mantenimiento SubcategoriasCalendario', 
		0, 
		@UserIdHost, 
		@Fecha, 
		'El archivo de instalación no contiene información de la licencia. Verifique con el vendedor los detalles de la licencia.', 
		'<package name="CollectorsClub.EditorSubcategoriasCalendario" type="Module" version="1.0.0">
		<friendlyName>CollectorsClub - Mantenimiento SubcategoriasCalendario</friendlyName>
		<description>CollectorsClub - Mantenimiento SubcategoriasCalendario</description>
		<iconFile />
		<owner>
			<name>CollectorsClub</name>
			<organization />
			<url />
			<email />
		</owner>
		<license>El archivo de instalación no contiene información de la licencia. Verifique con el vendedor los detalles de la licencia.</license>
		<releaseNotes />
		<components>
			<component type="Module">
				<desktopModule>
					<moduleName>CollectorsClub.EditorSubcategoriasCalendario</moduleName>
					<foldername>CollectorsClub.EditorSubcategoriasCalendario</foldername>
					<businessControllerClass />
					<supportedFeatures />
					<moduleDefinitions>
						<moduleDefinition>
							<friendlyName>CollectorsClub - Mantenimiento SubcategoriasCalendario</friendlyName>
							<definitionName>CollectorsClub - Mantenimiento SubcategoriasCalendario</definitionName>
							<defaultCacheTime>0</defaultCacheTime>
							<moduleControls>
								<moduleControl>
									<controlKey />
									<controlSrc>DesktopModules/CollectorsClub/Editores/SubcategoriaCalendarioEditorView.ascx</controlSrc>
									<supportsPartialRendering>False</supportsPartialRendering>
									<controlTitle />
									<controlType>View</controlType>
									<iconFile />
									<helpUrl />
									<supportsPopUps>False</supportsPopUps>
									<viewOrder>0</viewOrder>
								</moduleControl>
							</moduleControls>
						</moduleDefinition>
					</moduleDefinitions>
				</desktopModule>
			</component>
			<component type="File">
				<files>
					<basePath>DesktopModules\CollectorsClub\Editores</basePath>
					<file>
						<name>SubcategoriaCalendarioEditorView.ascx</name>
						<sourceFileName>SubcategoriaCalendarioEditorView.ascx</sourceFileName>
					</file>
				</files>
			</component>
		</components>
	</package>', 
		'CollectorsClub.EditorSubcategoriasCalendario', 
		'', 
		'CollectorsClub',
		'Module', 
		@PortalId, 
		'Este paquete no tiene notas de la versión', 
		'', 
		'1.0.0'
	)
	set @PackageId = SCOPE_IDENTITY()

	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Mantenimiento SubcategoriasCalendario', 3, -1, -1, '', 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @DesktopModuleContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_DesktopModules (BusinessControllerClass, CompatibleVersions, ContentItemId, CreatedByUserID, CreatedOnDate, Dependencies, Description, FolderName, FriendlyName, IsAdmin, IsPremium, LastModifiedByUserID, LastModifiedOnDate, ModuleName, PackageID, Permissions, Shareable, SupportedFeatures, Version)
	VALUES ('', null, @DesktopModuleContentItemId, @UserIdHost, @Fecha, null, 'Mantenimiento SubcategoriasCalendario', 'CollectorsClub.EditorSubcategoriasCalendario', 'Mantenimiento SubcategoriasCalendario', 0, 0, @UserIdHost, @Fecha, 'CollectorsClub.EditorSubcategoriasCalendario', @PackageId, null, 0, 0, '01.00.00')

	set @DesktopModuleId = SCOPE_IDENTITY()

	INSERT INTO dnn_ModuleDefinitions (CreatedByUserID, CreatedOnDate, DefaultCacheTime, DefinitionName, DesktopModuleID, FriendlyName, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@UserIdHost, @Fecha, 0, 'Mantenimiento SubcategoriasCalendario', @DesktopModuleId, 'Mantenimiento SubcategoriasCalendario', @UserIdHost, @Fecha)

	set @ModuleDefinitionId = SCOPE_IDENTITY()

	INSERT INTO dnn_PortalDesktopModules (CreatedByUserID, CreatedOnDate, DesktopModuleID, LastModifiedByUserID, LastModifiedOnDate, PortalID)
	VALUES (@UserIdHost, @Fecha, @DesktopModuleId, @UserIdHost, @Fecha, @PortalId)

	set @PortalDesktopModuleId = SCOPE_IDENTITY()

	INSERT INTO dnn_DesktopModulePermission (AllowAccess, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, PermissionID, PortalDesktopModuleID, RoleID, UserID)
	VALUES (1, @UserIdHost, @Fecha, @UserIdHost, @Fecha, 7, @PortalDesktopModuleId, @RoleIdHost, null)

	INSERT INTO dnn_ModuleControls (ControlKey, ControlSrc, ControlTitle, ControlType, CreatedByUserID, CreatedOnDate, HelpUrl, IconFile, LastModifiedByUserID, LastModifiedOnDate, ModuleDefID, SupportsPartialRendering, SupportsPopUps, ViewOrder)
	VALUES (null, 'DesktopModules/CollectorsClub/Editores/SubcategoriaCalendarioEditorView.ascx', null, 0, @UserIdHost, @Fecha, null, null, @UserIdHost, @Fecha, @ModuleDefinitionId, 0, 0, 0)

	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Mantenimiento SubcategoriasCalendario', 2, @TabId, -1, null, 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @ModuleContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_Modules (AllTabs, ContentItemID, CreatedByUserID, CreatedOnDate, EndDate, InheritViewPermissions, IsDeleted, IsShareable, IsShareableViewOnly, LastContentModifiedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleDefID, PortalID, StartDate)
	VALUES (0, @ModuleContentItemId, @UserIdHost, @Fecha, null, 1, 0, 1, 1, null, @UserIdHost, @Fecha, @ModuleDefinitionId, @PortalId, null)

	set @ModuleId = SCOPE_IDENTITY()

	UPDATE dnn_ContentItems SET ModuleId = @ModuleId WHERE ContentItemID = @ModuleContentItemId

	INSERT INTO dnn_TabModules (Alignment, Border, CacheMethod, CacheTime, Color, ContainerSrc, CreatedByUserID, CreatedOnDate, CultureCode, DefaultLanguageGuid, DisplayPrint, DisplaySyndicate, DisplayTitle, Footer, Header, IconFile, IsDeleted, IsWebSlice,LastModifiedByUserID, LastModifiedOnDate, LocalizedVersionGuid, ModuleID, ModuleOrder, ModuleTitle, PaneName, TabID, UniqueId, VersionGuid, Visibility, WebSliceExpiryDate, WebSliceTitle, WebSliceTTL)
	VALUES (null, null, null, 0, null, null, @UserIdHost, @Fecha, '', null, 0, 0, 0, null, null, null, 0, 0, @UserIdHost, @Fecha, NewId(), @ModuleId, 3, 'Mantenimiento SubcategoriasCalendario', 'ContentPane', @TabId, NewId(), NewId(), 2, null, '', 0)

	set @TabModuleId = SCOPE_IDENTITY()

	-- DNN No le crea ningún permiso
	--INSERT INTO dnn_TabModuleSettings (CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, SettingName, SettingValue, TabModuleID)
	--VALUES (@UserIdHost, @Fecha, @UserIdHost, @Fecha, '', '', @TabModuleId)

	INSERT INTO dnn_ModulePermission (AllowAccess, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleID, PermissionID, PortalID, RoleID, UserID)
	VALUES (1, @UserIdHost, @Fecha, @UserIdHost, @Fecha, @ModuleId, 2, @PortalId, @RoleIdHost, null)

	-- DNN No le crea ningún permiso
	--INSERT INTO dnn_ModuleSettings (CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleID, SettingName, SettingValue) 
	--VALUES (@UserIdHost, @Fecha, @UserIdHost, @Fecha, @ModuleId, '', '') 
end
------------------------------- Fin script del módulo SubcategoriasCalendario  ------------------------------

------------------------------- Inicio script del módulo SubcategoriasCalendario_Idiomas  ------------------------------
USE CollectorsClubDNN;
GO

declare @NombrePaginaPadre as nvarchar(50) = 'Mantenimiento'
declare @TabIdMantenimientos as int = (SELECT TabId FROM dnn_tabs WHERE TabName = @NombrePaginaPadre AND [Level] = 0)
declare @PortalId as int = 0
declare @UserIdHost as int = 1
declare @RoleIdHost as int = -2
declare @RoleIdAdministrador as int = 0 -- OLL en GA no quiero que lo vean los Administradores, solo Host, Sino pondría el 5
declare @NivelEditores as int = 1
declare @Fecha as datetime = GetDate()
declare @SkinSrc as nvarchar(100) = '[G]Skins/Porto/CollectorsClub-Inner.ascx'

declare @TabContentItemId as int
declare @TabId as int
declare @PackageId as int
declare @DesktopModuleContentItemId as int
declare @DesktopModuleId as int
declare @ModuleDefinitionId as int
declare @PortalDesktopModuleId as int
declare @ModuleContentItemId as int
declare @ModuleId as int
declare @TabModuleId as int


if not exists(SELECT ContentItemId FROM dnn_ContentItems WHERE Content = 'SubcategoriasCalendario_Idiomas')
begin 
	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('SubcategoriasCalendario_Idiomas', 1, -1, -1, null, 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @TabContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_Tabs (ContainerSrc, ContentItemID, CreatedByUserID, CreatedOnDate, CultureCode, DefaultLanguageGuid, Description, DisableLink, EndDate, IconFile, IconFileLarge, IsDeleted, IsSecure, IsVisible, KeyWords, LastModifiedByUserID, LastModifiedOnDate, Level, LocalizedVersionGuid, PageHeadText, ParentId, PermanentRedirect, PortalID, RefreshInterval, SiteMapPriority, SkinSrc, StartDate, TabName, TabOrder, TabPath, Title, UniqueId, Url, VersionGuid, HasBeenPublished, IsSystem)
	VALUES (null, @TabContentItemId, @UserIdHost, @Fecha, null, null, '', 0, null, '', '', 0, 0, 1, '', @UserIdHost, @Fecha, @NivelEditores, NewId(), null, @TabIdMantenimientos, 0, @PortalId, null, 0.5, @SkinSrc, null, 'SubcategoriasCalendario_Idiomas', 3, '//' + @NombrePaginaPadre + '//SubcategoriasCalendario_Idiomas', '', NewId(), '', NewId(), 1, 0)

	set @TabId = SCOPE_IDENTITY()

	UPDATE dnn_ContentItems SET TabId = @TabId WHERE ContentItemID = @TabContentItemId

	INSERT INTO dnn_TabSettings (TabID, SettingName, SettingValue, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 'AllowIndex', 'True', @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabSettings (TabID, SettingName, SettingValue, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 'LinkNewWindow', 'False', @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 3, 1, @RoleIdHost, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 4, 1, @RoleIdHost, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 3, 1, @RoleIdAdministrador, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	INSERT INTO dnn_Packages (
		CreatedByUserID, 
		CreatedOnDate, 
		Description, 
		Email, 
		FriendlyName, 
		IsSystemPackage, 
		LastModifiedByUserID, 
		LastModifiedOnDate, 
		License, 
		Manifest, 
		Name, 
		Organization, 
		Owner,
		PackageType, 
		PortalID, 
		ReleaseNotes, 
		Url, 
		Version
	) VALUES (
		@UserIdHost, 
		@Fecha, 
		'Mantenimiento SubcategoriasCalendario_Idiomas', 
		'', 
		'Mantenimiento SubcategoriasCalendario_Idiomas', 
		0, 
		@UserIdHost, 
		@Fecha, 
		'El archivo de instalación no contiene información de la licencia. Verifique con el vendedor los detalles de la licencia.', 
		'<package name="CollectorsClub.EditorSubcategoriasCalendario_Idiomas" type="Module" version="1.0.0">
		<friendlyName>CollectorsClub - Mantenimiento SubcategoriasCalendario_Idiomas</friendlyName>
		<description>CollectorsClub - Mantenimiento SubcategoriasCalendario_Idiomas</description>
		<iconFile />
		<owner>
			<name>CollectorsClub</name>
			<organization />
			<url />
			<email />
		</owner>
		<license>El archivo de instalación no contiene información de la licencia. Verifique con el vendedor los detalles de la licencia.</license>
		<releaseNotes />
		<components>
			<component type="Module">
				<desktopModule>
					<moduleName>CollectorsClub.EditorSubcategoriasCalendario_Idiomas</moduleName>
					<foldername>CollectorsClub.EditorSubcategoriasCalendario_Idiomas</foldername>
					<businessControllerClass />
					<supportedFeatures />
					<moduleDefinitions>
						<moduleDefinition>
							<friendlyName>CollectorsClub - Mantenimiento SubcategoriasCalendario_Idiomas</friendlyName>
							<definitionName>CollectorsClub - Mantenimiento SubcategoriasCalendario_Idiomas</definitionName>
							<defaultCacheTime>0</defaultCacheTime>
							<moduleControls>
								<moduleControl>
									<controlKey />
									<controlSrc>DesktopModules/CollectorsClub/Editores/SubcategoriaCalendario_IdiomaEditorView.ascx</controlSrc>
									<supportsPartialRendering>False</supportsPartialRendering>
									<controlTitle />
									<controlType>View</controlType>
									<iconFile />
									<helpUrl />
									<supportsPopUps>False</supportsPopUps>
									<viewOrder>0</viewOrder>
								</moduleControl>
							</moduleControls>
						</moduleDefinition>
					</moduleDefinitions>
				</desktopModule>
			</component>
			<component type="File">
				<files>
					<basePath>DesktopModules\CollectorsClub\Editores</basePath>
					<file>
						<name>SubcategoriaCalendario_IdiomaEditorView.ascx</name>
						<sourceFileName>SubcategoriaCalendario_IdiomaEditorView.ascx</sourceFileName>
					</file>
				</files>
			</component>
		</components>
	</package>', 
		'CollectorsClub.EditorSubcategoriasCalendario_Idiomas', 
		'', 
		'CollectorsClub',
		'Module', 
		@PortalId, 
		'Este paquete no tiene notas de la versión', 
		'', 
		'1.0.0'
	)
	set @PackageId = SCOPE_IDENTITY()

	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Mantenimiento SubcategoriasCalendario_Idiomas', 3, -1, -1, '', 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @DesktopModuleContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_DesktopModules (BusinessControllerClass, CompatibleVersions, ContentItemId, CreatedByUserID, CreatedOnDate, Dependencies, Description, FolderName, FriendlyName, IsAdmin, IsPremium, LastModifiedByUserID, LastModifiedOnDate, ModuleName, PackageID, Permissions, Shareable, SupportedFeatures, Version)
	VALUES ('', null, @DesktopModuleContentItemId, @UserIdHost, @Fecha, null, 'Mantenimiento SubcategoriasCalendario_Idiomas', 'CollectorsClub.EditorSubcategoriasCalendario_Idiomas', 'Mantenimiento SubcategoriasCalendario_Idiomas', 0, 0, @UserIdHost, @Fecha, 'CollectorsClub.EditorSubcategoriasCalendario_Idiomas', @PackageId, null, 0, 0, '01.00.00')

	set @DesktopModuleId = SCOPE_IDENTITY()

	INSERT INTO dnn_ModuleDefinitions (CreatedByUserID, CreatedOnDate, DefaultCacheTime, DefinitionName, DesktopModuleID, FriendlyName, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@UserIdHost, @Fecha, 0, 'Mantenimiento SubcategoriasCalendario_Idiomas', @DesktopModuleId, 'Mantenimiento SubcategoriasCalendario_Idiomas', @UserIdHost, @Fecha)

	set @ModuleDefinitionId = SCOPE_IDENTITY()

	INSERT INTO dnn_PortalDesktopModules (CreatedByUserID, CreatedOnDate, DesktopModuleID, LastModifiedByUserID, LastModifiedOnDate, PortalID)
	VALUES (@UserIdHost, @Fecha, @DesktopModuleId, @UserIdHost, @Fecha, @PortalId)

	set @PortalDesktopModuleId = SCOPE_IDENTITY()

	INSERT INTO dnn_DesktopModulePermission (AllowAccess, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, PermissionID, PortalDesktopModuleID, RoleID, UserID)
	VALUES (1, @UserIdHost, @Fecha, @UserIdHost, @Fecha, 7, @PortalDesktopModuleId, @RoleIdHost, null)

	INSERT INTO dnn_ModuleControls (ControlKey, ControlSrc, ControlTitle, ControlType, CreatedByUserID, CreatedOnDate, HelpUrl, IconFile, LastModifiedByUserID, LastModifiedOnDate, ModuleDefID, SupportsPartialRendering, SupportsPopUps, ViewOrder)
	VALUES (null, 'DesktopModules/CollectorsClub/Editores/SubcategoriaCalendario_IdiomaEditorView.ascx', null, 0, @UserIdHost, @Fecha, null, null, @UserIdHost, @Fecha, @ModuleDefinitionId, 0, 0, 0)

	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Mantenimiento SubcategoriasCalendario_Idiomas', 2, @TabId, -1, null, 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @ModuleContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_Modules (AllTabs, ContentItemID, CreatedByUserID, CreatedOnDate, EndDate, InheritViewPermissions, IsDeleted, IsShareable, IsShareableViewOnly, LastContentModifiedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleDefID, PortalID, StartDate)
	VALUES (0, @ModuleContentItemId, @UserIdHost, @Fecha, null, 1, 0, 1, 1, null, @UserIdHost, @Fecha, @ModuleDefinitionId, @PortalId, null)

	set @ModuleId = SCOPE_IDENTITY()

	UPDATE dnn_ContentItems SET ModuleId = @ModuleId WHERE ContentItemID = @ModuleContentItemId

	INSERT INTO dnn_TabModules (Alignment, Border, CacheMethod, CacheTime, Color, ContainerSrc, CreatedByUserID, CreatedOnDate, CultureCode, DefaultLanguageGuid, DisplayPrint, DisplaySyndicate, DisplayTitle, Footer, Header, IconFile, IsDeleted, IsWebSlice,LastModifiedByUserID, LastModifiedOnDate, LocalizedVersionGuid, ModuleID, ModuleOrder, ModuleTitle, PaneName, TabID, UniqueId, VersionGuid, Visibility, WebSliceExpiryDate, WebSliceTitle, WebSliceTTL)
	VALUES (null, null, null, 0, null, null, @UserIdHost, @Fecha, '', null, 0, 0, 0, null, null, null, 0, 0, @UserIdHost, @Fecha, NewId(), @ModuleId, 3, 'Mantenimiento SubcategoriasCalendario_Idiomas', 'ContentPane', @TabId, NewId(), NewId(), 2, null, '', 0)

	set @TabModuleId = SCOPE_IDENTITY()

	-- DNN No le crea ningún permiso
	--INSERT INTO dnn_TabModuleSettings (CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, SettingName, SettingValue, TabModuleID)
	--VALUES (@UserIdHost, @Fecha, @UserIdHost, @Fecha, '', '', @TabModuleId)

	INSERT INTO dnn_ModulePermission (AllowAccess, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleID, PermissionID, PortalID, RoleID, UserID)
	VALUES (1, @UserIdHost, @Fecha, @UserIdHost, @Fecha, @ModuleId, 2, @PortalId, @RoleIdHost, null)

	-- DNN No le crea ningún permiso
	--INSERT INTO dnn_ModuleSettings (CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleID, SettingName, SettingValue) 
	--VALUES (@UserIdHost, @Fecha, @UserIdHost, @Fecha, @ModuleId, '', '') 
end
------------------------------- Fin script del módulo SubcategoriasCalendario_Idiomas  ------------------------------

------------------------------- Inicio script del módulo TiposColeccionCalendario  ------------------------------
USE CollectorsClubDNN;
GO

declare @NombrePaginaPadre as nvarchar(50) = 'Mantenimiento'
declare @TabIdMantenimientos as int = (SELECT TabId FROM dnn_tabs WHERE TabName = @NombrePaginaPadre AND [Level] = 0)
declare @PortalId as int = 0
declare @UserIdHost as int = 1
declare @RoleIdHost as int = -2
declare @RoleIdAdministrador as int = 0 -- OLL en GA no quiero que lo vean los Administradores, solo Host, Sino pondría el 5
declare @NivelEditores as int = 1
declare @Fecha as datetime = GetDate()
declare @SkinSrc as nvarchar(100) = '[G]Skins/Porto/CollectorsClub-Inner.ascx'

declare @TabContentItemId as int
declare @TabId as int
declare @PackageId as int
declare @DesktopModuleContentItemId as int
declare @DesktopModuleId as int
declare @ModuleDefinitionId as int
declare @PortalDesktopModuleId as int
declare @ModuleContentItemId as int
declare @ModuleId as int
declare @TabModuleId as int


if not exists(SELECT ContentItemId FROM dnn_ContentItems WHERE Content = 'TiposColeccionCalendario')
begin 
	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('TiposColeccionCalendario', 1, -1, -1, null, 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @TabContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_Tabs (ContainerSrc, ContentItemID, CreatedByUserID, CreatedOnDate, CultureCode, DefaultLanguageGuid, Description, DisableLink, EndDate, IconFile, IconFileLarge, IsDeleted, IsSecure, IsVisible, KeyWords, LastModifiedByUserID, LastModifiedOnDate, Level, LocalizedVersionGuid, PageHeadText, ParentId, PermanentRedirect, PortalID, RefreshInterval, SiteMapPriority, SkinSrc, StartDate, TabName, TabOrder, TabPath, Title, UniqueId, Url, VersionGuid, HasBeenPublished, IsSystem)
	VALUES (null, @TabContentItemId, @UserIdHost, @Fecha, null, null, '', 0, null, '', '', 0, 0, 1, '', @UserIdHost, @Fecha, @NivelEditores, NewId(), null, @TabIdMantenimientos, 0, @PortalId, null, 0.5, @SkinSrc, null, 'TiposColeccionCalendario', 3, '//' + @NombrePaginaPadre + '//TiposColeccionCalendario', '', NewId(), '', NewId(), 1, 0)

	set @TabId = SCOPE_IDENTITY()

	UPDATE dnn_ContentItems SET TabId = @TabId WHERE ContentItemID = @TabContentItemId

	INSERT INTO dnn_TabSettings (TabID, SettingName, SettingValue, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 'AllowIndex', 'True', @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabSettings (TabID, SettingName, SettingValue, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 'LinkNewWindow', 'False', @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 3, 1, @RoleIdHost, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 4, 1, @RoleIdHost, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 3, 1, @RoleIdAdministrador, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	INSERT INTO dnn_Packages (
		CreatedByUserID, 
		CreatedOnDate, 
		Description, 
		Email, 
		FriendlyName, 
		IsSystemPackage, 
		LastModifiedByUserID, 
		LastModifiedOnDate, 
		License, 
		Manifest, 
		Name, 
		Organization, 
		Owner,
		PackageType, 
		PortalID, 
		ReleaseNotes, 
		Url, 
		Version
	) VALUES (
		@UserIdHost, 
		@Fecha, 
		'Mantenimiento TiposColeccionCalendario', 
		'', 
		'Mantenimiento TiposColeccionCalendario', 
		0, 
		@UserIdHost, 
		@Fecha, 
		'El archivo de instalación no contiene información de la licencia. Verifique con el vendedor los detalles de la licencia.', 
		'<package name="CollectorsClub.EditorTiposColeccionCalendario" type="Module" version="1.0.0">
		<friendlyName>CollectorsClub - Mantenimiento TiposColeccionCalendario</friendlyName>
		<description>CollectorsClub - Mantenimiento TiposColeccionCalendario</description>
		<iconFile />
		<owner>
			<name>CollectorsClub</name>
			<organization />
			<url />
			<email />
		</owner>
		<license>El archivo de instalación no contiene información de la licencia. Verifique con el vendedor los detalles de la licencia.</license>
		<releaseNotes />
		<components>
			<component type="Module">
				<desktopModule>
					<moduleName>CollectorsClub.EditorTiposColeccionCalendario</moduleName>
					<foldername>CollectorsClub.EditorTiposColeccionCalendario</foldername>
					<businessControllerClass />
					<supportedFeatures />
					<moduleDefinitions>
						<moduleDefinition>
							<friendlyName>CollectorsClub - Mantenimiento TiposColeccionCalendario</friendlyName>
							<definitionName>CollectorsClub - Mantenimiento TiposColeccionCalendario</definitionName>
							<defaultCacheTime>0</defaultCacheTime>
							<moduleControls>
								<moduleControl>
									<controlKey />
									<controlSrc>DesktopModules/CollectorsClub/Editores/TipoColeccionCalendarioEditorView.ascx</controlSrc>
									<supportsPartialRendering>False</supportsPartialRendering>
									<controlTitle />
									<controlType>View</controlType>
									<iconFile />
									<helpUrl />
									<supportsPopUps>False</supportsPopUps>
									<viewOrder>0</viewOrder>
								</moduleControl>
							</moduleControls>
						</moduleDefinition>
					</moduleDefinitions>
				</desktopModule>
			</component>
			<component type="File">
				<files>
					<basePath>DesktopModules\CollectorsClub\Editores</basePath>
					<file>
						<name>TipoColeccionCalendarioEditorView.ascx</name>
						<sourceFileName>TipoColeccionCalendarioEditorView.ascx</sourceFileName>
					</file>
				</files>
			</component>
		</components>
	</package>', 
		'CollectorsClub.EditorTiposColeccionCalendario', 
		'', 
		'CollectorsClub',
		'Module', 
		@PortalId, 
		'Este paquete no tiene notas de la versión', 
		'', 
		'1.0.0'
	)
	set @PackageId = SCOPE_IDENTITY()

	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Mantenimiento TiposColeccionCalendario', 3, -1, -1, '', 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @DesktopModuleContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_DesktopModules (BusinessControllerClass, CompatibleVersions, ContentItemId, CreatedByUserID, CreatedOnDate, Dependencies, Description, FolderName, FriendlyName, IsAdmin, IsPremium, LastModifiedByUserID, LastModifiedOnDate, ModuleName, PackageID, Permissions, Shareable, SupportedFeatures, Version)
	VALUES ('', null, @DesktopModuleContentItemId, @UserIdHost, @Fecha, null, 'Mantenimiento TiposColeccionCalendario', 'CollectorsClub.EditorTiposColeccionCalendario', 'Mantenimiento TiposColeccionCalendario', 0, 0, @UserIdHost, @Fecha, 'CollectorsClub.EditorTiposColeccionCalendario', @PackageId, null, 0, 0, '01.00.00')

	set @DesktopModuleId = SCOPE_IDENTITY()

	INSERT INTO dnn_ModuleDefinitions (CreatedByUserID, CreatedOnDate, DefaultCacheTime, DefinitionName, DesktopModuleID, FriendlyName, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@UserIdHost, @Fecha, 0, 'Mantenimiento TiposColeccionCalendario', @DesktopModuleId, 'Mantenimiento TiposColeccionCalendario', @UserIdHost, @Fecha)

	set @ModuleDefinitionId = SCOPE_IDENTITY()

	INSERT INTO dnn_PortalDesktopModules (CreatedByUserID, CreatedOnDate, DesktopModuleID, LastModifiedByUserID, LastModifiedOnDate, PortalID)
	VALUES (@UserIdHost, @Fecha, @DesktopModuleId, @UserIdHost, @Fecha, @PortalId)

	set @PortalDesktopModuleId = SCOPE_IDENTITY()

	INSERT INTO dnn_DesktopModulePermission (AllowAccess, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, PermissionID, PortalDesktopModuleID, RoleID, UserID)
	VALUES (1, @UserIdHost, @Fecha, @UserIdHost, @Fecha, 7, @PortalDesktopModuleId, @RoleIdHost, null)

	INSERT INTO dnn_ModuleControls (ControlKey, ControlSrc, ControlTitle, ControlType, CreatedByUserID, CreatedOnDate, HelpUrl, IconFile, LastModifiedByUserID, LastModifiedOnDate, ModuleDefID, SupportsPartialRendering, SupportsPopUps, ViewOrder)
	VALUES (null, 'DesktopModules/CollectorsClub/Editores/TipoColeccionCalendarioEditorView.ascx', null, 0, @UserIdHost, @Fecha, null, null, @UserIdHost, @Fecha, @ModuleDefinitionId, 0, 0, 0)

	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Mantenimiento TiposColeccionCalendario', 2, @TabId, -1, null, 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @ModuleContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_Modules (AllTabs, ContentItemID, CreatedByUserID, CreatedOnDate, EndDate, InheritViewPermissions, IsDeleted, IsShareable, IsShareableViewOnly, LastContentModifiedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleDefID, PortalID, StartDate)
	VALUES (0, @ModuleContentItemId, @UserIdHost, @Fecha, null, 1, 0, 1, 1, null, @UserIdHost, @Fecha, @ModuleDefinitionId, @PortalId, null)

	set @ModuleId = SCOPE_IDENTITY()

	UPDATE dnn_ContentItems SET ModuleId = @ModuleId WHERE ContentItemID = @ModuleContentItemId

	INSERT INTO dnn_TabModules (Alignment, Border, CacheMethod, CacheTime, Color, ContainerSrc, CreatedByUserID, CreatedOnDate, CultureCode, DefaultLanguageGuid, DisplayPrint, DisplaySyndicate, DisplayTitle, Footer, Header, IconFile, IsDeleted, IsWebSlice,LastModifiedByUserID, LastModifiedOnDate, LocalizedVersionGuid, ModuleID, ModuleOrder, ModuleTitle, PaneName, TabID, UniqueId, VersionGuid, Visibility, WebSliceExpiryDate, WebSliceTitle, WebSliceTTL)
	VALUES (null, null, null, 0, null, null, @UserIdHost, @Fecha, '', null, 0, 0, 0, null, null, null, 0, 0, @UserIdHost, @Fecha, NewId(), @ModuleId, 3, 'Mantenimiento TiposColeccionCalendario', 'ContentPane', @TabId, NewId(), NewId(), 2, null, '', 0)

	set @TabModuleId = SCOPE_IDENTITY()

	-- DNN No le crea ningún permiso
	--INSERT INTO dnn_TabModuleSettings (CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, SettingName, SettingValue, TabModuleID)
	--VALUES (@UserIdHost, @Fecha, @UserIdHost, @Fecha, '', '', @TabModuleId)

	INSERT INTO dnn_ModulePermission (AllowAccess, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleID, PermissionID, PortalID, RoleID, UserID)
	VALUES (1, @UserIdHost, @Fecha, @UserIdHost, @Fecha, @ModuleId, 2, @PortalId, @RoleIdHost, null)

	-- DNN No le crea ningún permiso
	--INSERT INTO dnn_ModuleSettings (CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleID, SettingName, SettingValue) 
	--VALUES (@UserIdHost, @Fecha, @UserIdHost, @Fecha, @ModuleId, '', '') 
end
------------------------------- Fin script del módulo TiposColeccionCalendario  ------------------------------

------------------------------- Inicio script del módulo TiposColeccionCalendario_Idiomas  ------------------------------
USE CollectorsClubDNN;
GO

declare @NombrePaginaPadre as nvarchar(50) = 'Mantenimiento'
declare @TabIdMantenimientos as int = (SELECT TabId FROM dnn_tabs WHERE TabName = @NombrePaginaPadre AND [Level] = 0)
declare @PortalId as int = 0
declare @UserIdHost as int = 1
declare @RoleIdHost as int = -2
declare @RoleIdAdministrador as int = 0 -- OLL en GA no quiero que lo vean los Administradores, solo Host, Sino pondría el 5
declare @NivelEditores as int = 1
declare @Fecha as datetime = GetDate()
declare @SkinSrc as nvarchar(100) = '[G]Skins/Porto/CollectorsClub-Inner.ascx'

declare @TabContentItemId as int
declare @TabId as int
declare @PackageId as int
declare @DesktopModuleContentItemId as int
declare @DesktopModuleId as int
declare @ModuleDefinitionId as int
declare @PortalDesktopModuleId as int
declare @ModuleContentItemId as int
declare @ModuleId as int
declare @TabModuleId as int


if not exists(SELECT ContentItemId FROM dnn_ContentItems WHERE Content = 'TiposColeccionCalendario_Idiomas')
begin 
	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('TiposColeccionCalendario_Idiomas', 1, -1, -1, null, 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @TabContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_Tabs (ContainerSrc, ContentItemID, CreatedByUserID, CreatedOnDate, CultureCode, DefaultLanguageGuid, Description, DisableLink, EndDate, IconFile, IconFileLarge, IsDeleted, IsSecure, IsVisible, KeyWords, LastModifiedByUserID, LastModifiedOnDate, Level, LocalizedVersionGuid, PageHeadText, ParentId, PermanentRedirect, PortalID, RefreshInterval, SiteMapPriority, SkinSrc, StartDate, TabName, TabOrder, TabPath, Title, UniqueId, Url, VersionGuid, HasBeenPublished, IsSystem)
	VALUES (null, @TabContentItemId, @UserIdHost, @Fecha, null, null, '', 0, null, '', '', 0, 0, 1, '', @UserIdHost, @Fecha, @NivelEditores, NewId(), null, @TabIdMantenimientos, 0, @PortalId, null, 0.5, @SkinSrc, null, 'TiposColeccionCalendario_Idiomas', 3, '//' + @NombrePaginaPadre + '//TiposColeccionCalendario_Idiomas', '', NewId(), '', NewId(), 1, 0)

	set @TabId = SCOPE_IDENTITY()

	UPDATE dnn_ContentItems SET TabId = @TabId WHERE ContentItemID = @TabContentItemId

	INSERT INTO dnn_TabSettings (TabID, SettingName, SettingValue, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 'AllowIndex', 'True', @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabSettings (TabID, SettingName, SettingValue, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 'LinkNewWindow', 'False', @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 3, 1, @RoleIdHost, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 4, 1, @RoleIdHost, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 3, 1, @RoleIdAdministrador, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	INSERT INTO dnn_Packages (
		CreatedByUserID, 
		CreatedOnDate, 
		Description, 
		Email, 
		FriendlyName, 
		IsSystemPackage, 
		LastModifiedByUserID, 
		LastModifiedOnDate, 
		License, 
		Manifest, 
		Name, 
		Organization, 
		Owner,
		PackageType, 
		PortalID, 
		ReleaseNotes, 
		Url, 
		Version
	) VALUES (
		@UserIdHost, 
		@Fecha, 
		'Mantenimiento TiposColeccionCalendario_Idiomas', 
		'', 
		'Mantenimiento TiposColeccionCalendario_Idiomas', 
		0, 
		@UserIdHost, 
		@Fecha, 
		'El archivo de instalación no contiene información de la licencia. Verifique con el vendedor los detalles de la licencia.', 
		'<package name="CollectorsClub.EditorTiposColeccionCalendario_Idiomas" type="Module" version="1.0.0">
		<friendlyName>CollectorsClub - Mantenimiento TiposColeccionCalendario_Idiomas</friendlyName>
		<description>CollectorsClub - Mantenimiento TiposColeccionCalendario_Idiomas</description>
		<iconFile />
		<owner>
			<name>CollectorsClub</name>
			<organization />
			<url />
			<email />
		</owner>
		<license>El archivo de instalación no contiene información de la licencia. Verifique con el vendedor los detalles de la licencia.</license>
		<releaseNotes />
		<components>
			<component type="Module">
				<desktopModule>
					<moduleName>CollectorsClub.EditorTiposColeccionCalendario_Idiomas</moduleName>
					<foldername>CollectorsClub.EditorTiposColeccionCalendario_Idiomas</foldername>
					<businessControllerClass />
					<supportedFeatures />
					<moduleDefinitions>
						<moduleDefinition>
							<friendlyName>CollectorsClub - Mantenimiento TiposColeccionCalendario_Idiomas</friendlyName>
							<definitionName>CollectorsClub - Mantenimiento TiposColeccionCalendario_Idiomas</definitionName>
							<defaultCacheTime>0</defaultCacheTime>
							<moduleControls>
								<moduleControl>
									<controlKey />
									<controlSrc>DesktopModules/CollectorsClub/Editores/TipoColeccionCalendario_IdiomaEditorView.ascx</controlSrc>
									<supportsPartialRendering>False</supportsPartialRendering>
									<controlTitle />
									<controlType>View</controlType>
									<iconFile />
									<helpUrl />
									<supportsPopUps>False</supportsPopUps>
									<viewOrder>0</viewOrder>
								</moduleControl>
							</moduleControls>
						</moduleDefinition>
					</moduleDefinitions>
				</desktopModule>
			</component>
			<component type="File">
				<files>
					<basePath>DesktopModules\CollectorsClub\Editores</basePath>
					<file>
						<name>TipoColeccionCalendario_IdiomaEditorView.ascx</name>
						<sourceFileName>TipoColeccionCalendario_IdiomaEditorView.ascx</sourceFileName>
					</file>
				</files>
			</component>
		</components>
	</package>', 
		'CollectorsClub.EditorTiposColeccionCalendario_Idiomas', 
		'', 
		'CollectorsClub',
		'Module', 
		@PortalId, 
		'Este paquete no tiene notas de la versión', 
		'', 
		'1.0.0'
	)
	set @PackageId = SCOPE_IDENTITY()

	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Mantenimiento TiposColeccionCalendario_Idiomas', 3, -1, -1, '', 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @DesktopModuleContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_DesktopModules (BusinessControllerClass, CompatibleVersions, ContentItemId, CreatedByUserID, CreatedOnDate, Dependencies, Description, FolderName, FriendlyName, IsAdmin, IsPremium, LastModifiedByUserID, LastModifiedOnDate, ModuleName, PackageID, Permissions, Shareable, SupportedFeatures, Version)
	VALUES ('', null, @DesktopModuleContentItemId, @UserIdHost, @Fecha, null, 'Mantenimiento TiposColeccionCalendario_Idiomas', 'CollectorsClub.EditorTiposColeccionCalendario_Idiomas', 'Mantenimiento TiposColeccionCalendario_Idiomas', 0, 0, @UserIdHost, @Fecha, 'CollectorsClub.EditorTiposColeccionCalendario_Idiomas', @PackageId, null, 0, 0, '01.00.00')

	set @DesktopModuleId = SCOPE_IDENTITY()

	INSERT INTO dnn_ModuleDefinitions (CreatedByUserID, CreatedOnDate, DefaultCacheTime, DefinitionName, DesktopModuleID, FriendlyName, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@UserIdHost, @Fecha, 0, 'Mantenimiento TiposColeccionCalendario_Idiomas', @DesktopModuleId, 'Mantenimiento TiposColeccionCalendario_Idiomas', @UserIdHost, @Fecha)

	set @ModuleDefinitionId = SCOPE_IDENTITY()

	INSERT INTO dnn_PortalDesktopModules (CreatedByUserID, CreatedOnDate, DesktopModuleID, LastModifiedByUserID, LastModifiedOnDate, PortalID)
	VALUES (@UserIdHost, @Fecha, @DesktopModuleId, @UserIdHost, @Fecha, @PortalId)

	set @PortalDesktopModuleId = SCOPE_IDENTITY()

	INSERT INTO dnn_DesktopModulePermission (AllowAccess, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, PermissionID, PortalDesktopModuleID, RoleID, UserID)
	VALUES (1, @UserIdHost, @Fecha, @UserIdHost, @Fecha, 7, @PortalDesktopModuleId, @RoleIdHost, null)

	INSERT INTO dnn_ModuleControls (ControlKey, ControlSrc, ControlTitle, ControlType, CreatedByUserID, CreatedOnDate, HelpUrl, IconFile, LastModifiedByUserID, LastModifiedOnDate, ModuleDefID, SupportsPartialRendering, SupportsPopUps, ViewOrder)
	VALUES (null, 'DesktopModules/CollectorsClub/Editores/TipoColeccionCalendario_IdiomaEditorView.ascx', null, 0, @UserIdHost, @Fecha, null, null, @UserIdHost, @Fecha, @ModuleDefinitionId, 0, 0, 0)

	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Mantenimiento TiposColeccionCalendario_Idiomas', 2, @TabId, -1, null, 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @ModuleContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_Modules (AllTabs, ContentItemID, CreatedByUserID, CreatedOnDate, EndDate, InheritViewPermissions, IsDeleted, IsShareable, IsShareableViewOnly, LastContentModifiedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleDefID, PortalID, StartDate)
	VALUES (0, @ModuleContentItemId, @UserIdHost, @Fecha, null, 1, 0, 1, 1, null, @UserIdHost, @Fecha, @ModuleDefinitionId, @PortalId, null)

	set @ModuleId = SCOPE_IDENTITY()

	UPDATE dnn_ContentItems SET ModuleId = @ModuleId WHERE ContentItemID = @ModuleContentItemId

	INSERT INTO dnn_TabModules (Alignment, Border, CacheMethod, CacheTime, Color, ContainerSrc, CreatedByUserID, CreatedOnDate, CultureCode, DefaultLanguageGuid, DisplayPrint, DisplaySyndicate, DisplayTitle, Footer, Header, IconFile, IsDeleted, IsWebSlice,LastModifiedByUserID, LastModifiedOnDate, LocalizedVersionGuid, ModuleID, ModuleOrder, ModuleTitle, PaneName, TabID, UniqueId, VersionGuid, Visibility, WebSliceExpiryDate, WebSliceTitle, WebSliceTTL)
	VALUES (null, null, null, 0, null, null, @UserIdHost, @Fecha, '', null, 0, 0, 0, null, null, null, 0, 0, @UserIdHost, @Fecha, NewId(), @ModuleId, 3, 'Mantenimiento TiposColeccionCalendario_Idiomas', 'ContentPane', @TabId, NewId(), NewId(), 2, null, '', 0)

	set @TabModuleId = SCOPE_IDENTITY()

	-- DNN No le crea ningún permiso
	--INSERT INTO dnn_TabModuleSettings (CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, SettingName, SettingValue, TabModuleID)
	--VALUES (@UserIdHost, @Fecha, @UserIdHost, @Fecha, '', '', @TabModuleId)

	INSERT INTO dnn_ModulePermission (AllowAccess, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleID, PermissionID, PortalID, RoleID, UserID)
	VALUES (1, @UserIdHost, @Fecha, @UserIdHost, @Fecha, @ModuleId, 2, @PortalId, @RoleIdHost, null)

	-- DNN No le crea ningún permiso
	--INSERT INTO dnn_ModuleSettings (CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleID, SettingName, SettingValue) 
	--VALUES (@UserIdHost, @Fecha, @UserIdHost, @Fecha, @ModuleId, '', '') 
end
------------------------------- Fin script del módulo TiposColeccionCalendario_Idiomas  ------------------------------

------------------------------- Inicio script del módulo TiposEvento  ------------------------------
USE CollectorsClubDNN;
GO

declare @NombrePaginaPadre as nvarchar(50) = 'Mantenimiento'
declare @TabIdMantenimientos as int = (SELECT TabId FROM dnn_tabs WHERE TabName = @NombrePaginaPadre AND [Level] = 0)
declare @PortalId as int = 0
declare @UserIdHost as int = 1
declare @RoleIdHost as int = -2
declare @RoleIdAdministrador as int = 0 -- OLL en GA no quiero que lo vean los Administradores, solo Host, Sino pondría el 5
declare @NivelEditores as int = 1
declare @Fecha as datetime = GetDate()
declare @SkinSrc as nvarchar(100) = '[G]Skins/Porto/CollectorsClub-Inner.ascx'

declare @TabContentItemId as int
declare @TabId as int
declare @PackageId as int
declare @DesktopModuleContentItemId as int
declare @DesktopModuleId as int
declare @ModuleDefinitionId as int
declare @PortalDesktopModuleId as int
declare @ModuleContentItemId as int
declare @ModuleId as int
declare @TabModuleId as int


if not exists(SELECT ContentItemId FROM dnn_ContentItems WHERE Content = 'TiposEvento')
begin 
	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('TiposEvento', 1, -1, -1, null, 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @TabContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_Tabs (ContainerSrc, ContentItemID, CreatedByUserID, CreatedOnDate, CultureCode, DefaultLanguageGuid, Description, DisableLink, EndDate, IconFile, IconFileLarge, IsDeleted, IsSecure, IsVisible, KeyWords, LastModifiedByUserID, LastModifiedOnDate, Level, LocalizedVersionGuid, PageHeadText, ParentId, PermanentRedirect, PortalID, RefreshInterval, SiteMapPriority, SkinSrc, StartDate, TabName, TabOrder, TabPath, Title, UniqueId, Url, VersionGuid, HasBeenPublished, IsSystem)
	VALUES (null, @TabContentItemId, @UserIdHost, @Fecha, null, null, '', 0, null, '', '', 0, 0, 1, '', @UserIdHost, @Fecha, @NivelEditores, NewId(), null, @TabIdMantenimientos, 0, @PortalId, null, 0.5, @SkinSrc, null, 'TiposEvento', 3, '//' + @NombrePaginaPadre + '//TiposEvento', '', NewId(), '', NewId(), 1, 0)

	set @TabId = SCOPE_IDENTITY()

	UPDATE dnn_ContentItems SET TabId = @TabId WHERE ContentItemID = @TabContentItemId

	INSERT INTO dnn_TabSettings (TabID, SettingName, SettingValue, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 'AllowIndex', 'True', @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabSettings (TabID, SettingName, SettingValue, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 'LinkNewWindow', 'False', @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 3, 1, @RoleIdHost, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 4, 1, @RoleIdHost, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 3, 1, @RoleIdAdministrador, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	INSERT INTO dnn_Packages (
		CreatedByUserID, 
		CreatedOnDate, 
		Description, 
		Email, 
		FriendlyName, 
		IsSystemPackage, 
		LastModifiedByUserID, 
		LastModifiedOnDate, 
		License, 
		Manifest, 
		Name, 
		Organization, 
		Owner,
		PackageType, 
		PortalID, 
		ReleaseNotes, 
		Url, 
		Version
	) VALUES (
		@UserIdHost, 
		@Fecha, 
		'Mantenimiento TiposEvento', 
		'', 
		'Mantenimiento TiposEvento', 
		0, 
		@UserIdHost, 
		@Fecha, 
		'El archivo de instalación no contiene información de la licencia. Verifique con el vendedor los detalles de la licencia.', 
		'<package name="CollectorsClub.EditorTiposEvento" type="Module" version="1.0.0">
		<friendlyName>CollectorsClub - Mantenimiento TiposEvento</friendlyName>
		<description>CollectorsClub - Mantenimiento TiposEvento</description>
		<iconFile />
		<owner>
			<name>CollectorsClub</name>
			<organization />
			<url />
			<email />
		</owner>
		<license>El archivo de instalación no contiene información de la licencia. Verifique con el vendedor los detalles de la licencia.</license>
		<releaseNotes />
		<components>
			<component type="Module">
				<desktopModule>
					<moduleName>CollectorsClub.EditorTiposEvento</moduleName>
					<foldername>CollectorsClub.EditorTiposEvento</foldername>
					<businessControllerClass />
					<supportedFeatures />
					<moduleDefinitions>
						<moduleDefinition>
							<friendlyName>CollectorsClub - Mantenimiento TiposEvento</friendlyName>
							<definitionName>CollectorsClub - Mantenimiento TiposEvento</definitionName>
							<defaultCacheTime>0</defaultCacheTime>
							<moduleControls>
								<moduleControl>
									<controlKey />
									<controlSrc>DesktopModules/CollectorsClub/Editores/TipoEventoEditorView.ascx</controlSrc>
									<supportsPartialRendering>False</supportsPartialRendering>
									<controlTitle />
									<controlType>View</controlType>
									<iconFile />
									<helpUrl />
									<supportsPopUps>False</supportsPopUps>
									<viewOrder>0</viewOrder>
								</moduleControl>
							</moduleControls>
						</moduleDefinition>
					</moduleDefinitions>
				</desktopModule>
			</component>
			<component type="File">
				<files>
					<basePath>DesktopModules\CollectorsClub\Editores</basePath>
					<file>
						<name>TipoEventoEditorView.ascx</name>
						<sourceFileName>TipoEventoEditorView.ascx</sourceFileName>
					</file>
				</files>
			</component>
		</components>
	</package>', 
		'CollectorsClub.EditorTiposEvento', 
		'', 
		'CollectorsClub',
		'Module', 
		@PortalId, 
		'Este paquete no tiene notas de la versión', 
		'', 
		'1.0.0'
	)
	set @PackageId = SCOPE_IDENTITY()

	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Mantenimiento TiposEvento', 3, -1, -1, '', 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @DesktopModuleContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_DesktopModules (BusinessControllerClass, CompatibleVersions, ContentItemId, CreatedByUserID, CreatedOnDate, Dependencies, Description, FolderName, FriendlyName, IsAdmin, IsPremium, LastModifiedByUserID, LastModifiedOnDate, ModuleName, PackageID, Permissions, Shareable, SupportedFeatures, Version)
	VALUES ('', null, @DesktopModuleContentItemId, @UserIdHost, @Fecha, null, 'Mantenimiento TiposEvento', 'CollectorsClub.EditorTiposEvento', 'Mantenimiento TiposEvento', 0, 0, @UserIdHost, @Fecha, 'CollectorsClub.EditorTiposEvento', @PackageId, null, 0, 0, '01.00.00')

	set @DesktopModuleId = SCOPE_IDENTITY()

	INSERT INTO dnn_ModuleDefinitions (CreatedByUserID, CreatedOnDate, DefaultCacheTime, DefinitionName, DesktopModuleID, FriendlyName, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@UserIdHost, @Fecha, 0, 'Mantenimiento TiposEvento', @DesktopModuleId, 'Mantenimiento TiposEvento', @UserIdHost, @Fecha)

	set @ModuleDefinitionId = SCOPE_IDENTITY()

	INSERT INTO dnn_PortalDesktopModules (CreatedByUserID, CreatedOnDate, DesktopModuleID, LastModifiedByUserID, LastModifiedOnDate, PortalID)
	VALUES (@UserIdHost, @Fecha, @DesktopModuleId, @UserIdHost, @Fecha, @PortalId)

	set @PortalDesktopModuleId = SCOPE_IDENTITY()

	INSERT INTO dnn_DesktopModulePermission (AllowAccess, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, PermissionID, PortalDesktopModuleID, RoleID, UserID)
	VALUES (1, @UserIdHost, @Fecha, @UserIdHost, @Fecha, 7, @PortalDesktopModuleId, @RoleIdHost, null)

	INSERT INTO dnn_ModuleControls (ControlKey, ControlSrc, ControlTitle, ControlType, CreatedByUserID, CreatedOnDate, HelpUrl, IconFile, LastModifiedByUserID, LastModifiedOnDate, ModuleDefID, SupportsPartialRendering, SupportsPopUps, ViewOrder)
	VALUES (null, 'DesktopModules/CollectorsClub/Editores/TipoEventoEditorView.ascx', null, 0, @UserIdHost, @Fecha, null, null, @UserIdHost, @Fecha, @ModuleDefinitionId, 0, 0, 0)

	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Mantenimiento TiposEvento', 2, @TabId, -1, null, 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @ModuleContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_Modules (AllTabs, ContentItemID, CreatedByUserID, CreatedOnDate, EndDate, InheritViewPermissions, IsDeleted, IsShareable, IsShareableViewOnly, LastContentModifiedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleDefID, PortalID, StartDate)
	VALUES (0, @ModuleContentItemId, @UserIdHost, @Fecha, null, 1, 0, 1, 1, null, @UserIdHost, @Fecha, @ModuleDefinitionId, @PortalId, null)

	set @ModuleId = SCOPE_IDENTITY()

	UPDATE dnn_ContentItems SET ModuleId = @ModuleId WHERE ContentItemID = @ModuleContentItemId

	INSERT INTO dnn_TabModules (Alignment, Border, CacheMethod, CacheTime, Color, ContainerSrc, CreatedByUserID, CreatedOnDate, CultureCode, DefaultLanguageGuid, DisplayPrint, DisplaySyndicate, DisplayTitle, Footer, Header, IconFile, IsDeleted, IsWebSlice,LastModifiedByUserID, LastModifiedOnDate, LocalizedVersionGuid, ModuleID, ModuleOrder, ModuleTitle, PaneName, TabID, UniqueId, VersionGuid, Visibility, WebSliceExpiryDate, WebSliceTitle, WebSliceTTL)
	VALUES (null, null, null, 0, null, null, @UserIdHost, @Fecha, '', null, 0, 0, 0, null, null, null, 0, 0, @UserIdHost, @Fecha, NewId(), @ModuleId, 3, 'Mantenimiento TiposEvento', 'ContentPane', @TabId, NewId(), NewId(), 2, null, '', 0)

	set @TabModuleId = SCOPE_IDENTITY()

	-- DNN No le crea ningún permiso
	--INSERT INTO dnn_TabModuleSettings (CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, SettingName, SettingValue, TabModuleID)
	--VALUES (@UserIdHost, @Fecha, @UserIdHost, @Fecha, '', '', @TabModuleId)

	INSERT INTO dnn_ModulePermission (AllowAccess, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleID, PermissionID, PortalID, RoleID, UserID)
	VALUES (1, @UserIdHost, @Fecha, @UserIdHost, @Fecha, @ModuleId, 2, @PortalId, @RoleIdHost, null)

	-- DNN No le crea ningún permiso
	--INSERT INTO dnn_ModuleSettings (CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleID, SettingName, SettingValue) 
	--VALUES (@UserIdHost, @Fecha, @UserIdHost, @Fecha, @ModuleId, '', '') 
end
------------------------------- Fin script del módulo TiposEvento  ------------------------------

------------------------------- Inicio script del módulo TiposEvento_Idiomas  ------------------------------
USE CollectorsClubDNN;
GO

declare @NombrePaginaPadre as nvarchar(50) = 'Mantenimiento'
declare @TabIdMantenimientos as int = (SELECT TabId FROM dnn_tabs WHERE TabName = @NombrePaginaPadre AND [Level] = 0)
declare @PortalId as int = 0
declare @UserIdHost as int = 1
declare @RoleIdHost as int = -2
declare @RoleIdAdministrador as int = 0 -- OLL en GA no quiero que lo vean los Administradores, solo Host, Sino pondría el 5
declare @NivelEditores as int = 1
declare @Fecha as datetime = GetDate()
declare @SkinSrc as nvarchar(100) = '[G]Skins/Porto/CollectorsClub-Inner.ascx'

declare @TabContentItemId as int
declare @TabId as int
declare @PackageId as int
declare @DesktopModuleContentItemId as int
declare @DesktopModuleId as int
declare @ModuleDefinitionId as int
declare @PortalDesktopModuleId as int
declare @ModuleContentItemId as int
declare @ModuleId as int
declare @TabModuleId as int


if not exists(SELECT ContentItemId FROM dnn_ContentItems WHERE Content = 'TiposEvento_Idiomas')
begin 
	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('TiposEvento_Idiomas', 1, -1, -1, null, 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @TabContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_Tabs (ContainerSrc, ContentItemID, CreatedByUserID, CreatedOnDate, CultureCode, DefaultLanguageGuid, Description, DisableLink, EndDate, IconFile, IconFileLarge, IsDeleted, IsSecure, IsVisible, KeyWords, LastModifiedByUserID, LastModifiedOnDate, Level, LocalizedVersionGuid, PageHeadText, ParentId, PermanentRedirect, PortalID, RefreshInterval, SiteMapPriority, SkinSrc, StartDate, TabName, TabOrder, TabPath, Title, UniqueId, Url, VersionGuid, HasBeenPublished, IsSystem)
	VALUES (null, @TabContentItemId, @UserIdHost, @Fecha, null, null, '', 0, null, '', '', 0, 0, 1, '', @UserIdHost, @Fecha, @NivelEditores, NewId(), null, @TabIdMantenimientos, 0, @PortalId, null, 0.5, @SkinSrc, null, 'TiposEvento_Idiomas', 3, '//' + @NombrePaginaPadre + '//TiposEvento_Idiomas', '', NewId(), '', NewId(), 1, 0)

	set @TabId = SCOPE_IDENTITY()

	UPDATE dnn_ContentItems SET TabId = @TabId WHERE ContentItemID = @TabContentItemId

	INSERT INTO dnn_TabSettings (TabID, SettingName, SettingValue, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 'AllowIndex', 'True', @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabSettings (TabID, SettingName, SettingValue, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 'LinkNewWindow', 'False', @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 3, 1, @RoleIdHost, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 4, 1, @RoleIdHost, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 3, 1, @RoleIdAdministrador, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	INSERT INTO dnn_Packages (
		CreatedByUserID, 
		CreatedOnDate, 
		Description, 
		Email, 
		FriendlyName, 
		IsSystemPackage, 
		LastModifiedByUserID, 
		LastModifiedOnDate, 
		License, 
		Manifest, 
		Name, 
		Organization, 
		Owner,
		PackageType, 
		PortalID, 
		ReleaseNotes, 
		Url, 
		Version
	) VALUES (
		@UserIdHost, 
		@Fecha, 
		'Mantenimiento TiposEvento_Idiomas', 
		'', 
		'Mantenimiento TiposEvento_Idiomas', 
		0, 
		@UserIdHost, 
		@Fecha, 
		'El archivo de instalación no contiene información de la licencia. Verifique con el vendedor los detalles de la licencia.', 
		'<package name="CollectorsClub.EditorTiposEvento_Idiomas" type="Module" version="1.0.0">
		<friendlyName>CollectorsClub - Mantenimiento TiposEvento_Idiomas</friendlyName>
		<description>CollectorsClub - Mantenimiento TiposEvento_Idiomas</description>
		<iconFile />
		<owner>
			<name>CollectorsClub</name>
			<organization />
			<url />
			<email />
		</owner>
		<license>El archivo de instalación no contiene información de la licencia. Verifique con el vendedor los detalles de la licencia.</license>
		<releaseNotes />
		<components>
			<component type="Module">
				<desktopModule>
					<moduleName>CollectorsClub.EditorTiposEvento_Idiomas</moduleName>
					<foldername>CollectorsClub.EditorTiposEvento_Idiomas</foldername>
					<businessControllerClass />
					<supportedFeatures />
					<moduleDefinitions>
						<moduleDefinition>
							<friendlyName>CollectorsClub - Mantenimiento TiposEvento_Idiomas</friendlyName>
							<definitionName>CollectorsClub - Mantenimiento TiposEvento_Idiomas</definitionName>
							<defaultCacheTime>0</defaultCacheTime>
							<moduleControls>
								<moduleControl>
									<controlKey />
									<controlSrc>DesktopModules/CollectorsClub/Editores/TipoEvento_IdiomaEditorView.ascx</controlSrc>
									<supportsPartialRendering>False</supportsPartialRendering>
									<controlTitle />
									<controlType>View</controlType>
									<iconFile />
									<helpUrl />
									<supportsPopUps>False</supportsPopUps>
									<viewOrder>0</viewOrder>
								</moduleControl>
							</moduleControls>
						</moduleDefinition>
					</moduleDefinitions>
				</desktopModule>
			</component>
			<component type="File">
				<files>
					<basePath>DesktopModules\CollectorsClub\Editores</basePath>
					<file>
						<name>TipoEvento_IdiomaEditorView.ascx</name>
						<sourceFileName>TipoEvento_IdiomaEditorView.ascx</sourceFileName>
					</file>
				</files>
			</component>
		</components>
	</package>', 
		'CollectorsClub.EditorTiposEvento_Idiomas', 
		'', 
		'CollectorsClub',
		'Module', 
		@PortalId, 
		'Este paquete no tiene notas de la versión', 
		'', 
		'1.0.0'
	)
	set @PackageId = SCOPE_IDENTITY()

	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Mantenimiento TiposEvento_Idiomas', 3, -1, -1, '', 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @DesktopModuleContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_DesktopModules (BusinessControllerClass, CompatibleVersions, ContentItemId, CreatedByUserID, CreatedOnDate, Dependencies, Description, FolderName, FriendlyName, IsAdmin, IsPremium, LastModifiedByUserID, LastModifiedOnDate, ModuleName, PackageID, Permissions, Shareable, SupportedFeatures, Version)
	VALUES ('', null, @DesktopModuleContentItemId, @UserIdHost, @Fecha, null, 'Mantenimiento TiposEvento_Idiomas', 'CollectorsClub.EditorTiposEvento_Idiomas', 'Mantenimiento TiposEvento_Idiomas', 0, 0, @UserIdHost, @Fecha, 'CollectorsClub.EditorTiposEvento_Idiomas', @PackageId, null, 0, 0, '01.00.00')

	set @DesktopModuleId = SCOPE_IDENTITY()

	INSERT INTO dnn_ModuleDefinitions (CreatedByUserID, CreatedOnDate, DefaultCacheTime, DefinitionName, DesktopModuleID, FriendlyName, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@UserIdHost, @Fecha, 0, 'Mantenimiento TiposEvento_Idiomas', @DesktopModuleId, 'Mantenimiento TiposEvento_Idiomas', @UserIdHost, @Fecha)

	set @ModuleDefinitionId = SCOPE_IDENTITY()

	INSERT INTO dnn_PortalDesktopModules (CreatedByUserID, CreatedOnDate, DesktopModuleID, LastModifiedByUserID, LastModifiedOnDate, PortalID)
	VALUES (@UserIdHost, @Fecha, @DesktopModuleId, @UserIdHost, @Fecha, @PortalId)

	set @PortalDesktopModuleId = SCOPE_IDENTITY()

	INSERT INTO dnn_DesktopModulePermission (AllowAccess, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, PermissionID, PortalDesktopModuleID, RoleID, UserID)
	VALUES (1, @UserIdHost, @Fecha, @UserIdHost, @Fecha, 7, @PortalDesktopModuleId, @RoleIdHost, null)

	INSERT INTO dnn_ModuleControls (ControlKey, ControlSrc, ControlTitle, ControlType, CreatedByUserID, CreatedOnDate, HelpUrl, IconFile, LastModifiedByUserID, LastModifiedOnDate, ModuleDefID, SupportsPartialRendering, SupportsPopUps, ViewOrder)
	VALUES (null, 'DesktopModules/CollectorsClub/Editores/TipoEvento_IdiomaEditorView.ascx', null, 0, @UserIdHost, @Fecha, null, null, @UserIdHost, @Fecha, @ModuleDefinitionId, 0, 0, 0)

	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Mantenimiento TiposEvento_Idiomas', 2, @TabId, -1, null, 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @ModuleContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_Modules (AllTabs, ContentItemID, CreatedByUserID, CreatedOnDate, EndDate, InheritViewPermissions, IsDeleted, IsShareable, IsShareableViewOnly, LastContentModifiedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleDefID, PortalID, StartDate)
	VALUES (0, @ModuleContentItemId, @UserIdHost, @Fecha, null, 1, 0, 1, 1, null, @UserIdHost, @Fecha, @ModuleDefinitionId, @PortalId, null)

	set @ModuleId = SCOPE_IDENTITY()

	UPDATE dnn_ContentItems SET ModuleId = @ModuleId WHERE ContentItemID = @ModuleContentItemId

	INSERT INTO dnn_TabModules (Alignment, Border, CacheMethod, CacheTime, Color, ContainerSrc, CreatedByUserID, CreatedOnDate, CultureCode, DefaultLanguageGuid, DisplayPrint, DisplaySyndicate, DisplayTitle, Footer, Header, IconFile, IsDeleted, IsWebSlice,LastModifiedByUserID, LastModifiedOnDate, LocalizedVersionGuid, ModuleID, ModuleOrder, ModuleTitle, PaneName, TabID, UniqueId, VersionGuid, Visibility, WebSliceExpiryDate, WebSliceTitle, WebSliceTTL)
	VALUES (null, null, null, 0, null, null, @UserIdHost, @Fecha, '', null, 0, 0, 0, null, null, null, 0, 0, @UserIdHost, @Fecha, NewId(), @ModuleId, 3, 'Mantenimiento TiposEvento_Idiomas', 'ContentPane', @TabId, NewId(), NewId(), 2, null, '', 0)

	set @TabModuleId = SCOPE_IDENTITY()

	-- DNN No le crea ningún permiso
	--INSERT INTO dnn_TabModuleSettings (CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, SettingName, SettingValue, TabModuleID)
	--VALUES (@UserIdHost, @Fecha, @UserIdHost, @Fecha, '', '', @TabModuleId)

	INSERT INTO dnn_ModulePermission (AllowAccess, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleID, PermissionID, PortalID, RoleID, UserID)
	VALUES (1, @UserIdHost, @Fecha, @UserIdHost, @Fecha, @ModuleId, 2, @PortalId, @RoleIdHost, null)

	-- DNN No le crea ningún permiso
	--INSERT INTO dnn_ModuleSettings (CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleID, SettingName, SettingValue) 
	--VALUES (@UserIdHost, @Fecha, @UserIdHost, @Fecha, @ModuleId, '', '') 
end
------------------------------- Fin script del módulo TiposEvento_Idiomas  ------------------------------

------------------------------- Inicio script del módulo Usuarios  ------------------------------
USE CollectorsClubDNN;
GO

declare @NombrePaginaPadre as nvarchar(50) = 'Mantenimiento'
declare @TabIdMantenimientos as int = (SELECT TabId FROM dnn_tabs WHERE TabName = @NombrePaginaPadre AND [Level] = 0)
declare @PortalId as int = 0
declare @UserIdHost as int = 1
declare @RoleIdHost as int = -2
declare @RoleIdAdministrador as int = 0 -- OLL en GA no quiero que lo vean los Administradores, solo Host, Sino pondría el 5
declare @NivelEditores as int = 1
declare @Fecha as datetime = GetDate()
declare @SkinSrc as nvarchar(100) = '[G]Skins/Porto/CollectorsClub-Inner.ascx'

declare @TabContentItemId as int
declare @TabId as int
declare @PackageId as int
declare @DesktopModuleContentItemId as int
declare @DesktopModuleId as int
declare @ModuleDefinitionId as int
declare @PortalDesktopModuleId as int
declare @ModuleContentItemId as int
declare @ModuleId as int
declare @TabModuleId as int


if not exists(SELECT ContentItemId FROM dnn_ContentItems WHERE Content = 'Usuarios')
begin 
	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Usuarios', 1, -1, -1, null, 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @TabContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_Tabs (ContainerSrc, ContentItemID, CreatedByUserID, CreatedOnDate, CultureCode, DefaultLanguageGuid, Description, DisableLink, EndDate, IconFile, IconFileLarge, IsDeleted, IsSecure, IsVisible, KeyWords, LastModifiedByUserID, LastModifiedOnDate, Level, LocalizedVersionGuid, PageHeadText, ParentId, PermanentRedirect, PortalID, RefreshInterval, SiteMapPriority, SkinSrc, StartDate, TabName, TabOrder, TabPath, Title, UniqueId, Url, VersionGuid, HasBeenPublished, IsSystem)
	VALUES (null, @TabContentItemId, @UserIdHost, @Fecha, null, null, '', 0, null, '', '', 0, 0, 1, '', @UserIdHost, @Fecha, @NivelEditores, NewId(), null, @TabIdMantenimientos, 0, @PortalId, null, 0.5, @SkinSrc, null, 'Usuarios', 3, '//' + @NombrePaginaPadre + '//Usuarios', '', NewId(), '', NewId(), 1, 0)

	set @TabId = SCOPE_IDENTITY()

	UPDATE dnn_ContentItems SET TabId = @TabId WHERE ContentItemID = @TabContentItemId

	INSERT INTO dnn_TabSettings (TabID, SettingName, SettingValue, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 'AllowIndex', 'True', @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabSettings (TabID, SettingName, SettingValue, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 'LinkNewWindow', 'False', @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 3, 1, @RoleIdHost, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 4, 1, @RoleIdHost, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 3, 1, @RoleIdAdministrador, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	INSERT INTO dnn_Packages (
		CreatedByUserID, 
		CreatedOnDate, 
		Description, 
		Email, 
		FriendlyName, 
		IsSystemPackage, 
		LastModifiedByUserID, 
		LastModifiedOnDate, 
		License, 
		Manifest, 
		Name, 
		Organization, 
		Owner,
		PackageType, 
		PortalID, 
		ReleaseNotes, 
		Url, 
		Version
	) VALUES (
		@UserIdHost, 
		@Fecha, 
		'Mantenimiento Usuarios', 
		'', 
		'Mantenimiento Usuarios', 
		0, 
		@UserIdHost, 
		@Fecha, 
		'El archivo de instalación no contiene información de la licencia. Verifique con el vendedor los detalles de la licencia.', 
		'<package name="CollectorsClub.EditorUsuarios" type="Module" version="1.0.0">
		<friendlyName>CollectorsClub - Mantenimiento Usuarios</friendlyName>
		<description>CollectorsClub - Mantenimiento Usuarios</description>
		<iconFile />
		<owner>
			<name>CollectorsClub</name>
			<organization />
			<url />
			<email />
		</owner>
		<license>El archivo de instalación no contiene información de la licencia. Verifique con el vendedor los detalles de la licencia.</license>
		<releaseNotes />
		<components>
			<component type="Module">
				<desktopModule>
					<moduleName>CollectorsClub.EditorUsuarios</moduleName>
					<foldername>CollectorsClub.EditorUsuarios</foldername>
					<businessControllerClass />
					<supportedFeatures />
					<moduleDefinitions>
						<moduleDefinition>
							<friendlyName>CollectorsClub - Mantenimiento Usuarios</friendlyName>
							<definitionName>CollectorsClub - Mantenimiento Usuarios</definitionName>
							<defaultCacheTime>0</defaultCacheTime>
							<moduleControls>
								<moduleControl>
									<controlKey />
									<controlSrc>DesktopModules/CollectorsClub/Editores/UsuarioEditorView.ascx</controlSrc>
									<supportsPartialRendering>False</supportsPartialRendering>
									<controlTitle />
									<controlType>View</controlType>
									<iconFile />
									<helpUrl />
									<supportsPopUps>False</supportsPopUps>
									<viewOrder>0</viewOrder>
								</moduleControl>
							</moduleControls>
						</moduleDefinition>
					</moduleDefinitions>
				</desktopModule>
			</component>
			<component type="File">
				<files>
					<basePath>DesktopModules\CollectorsClub\Editores</basePath>
					<file>
						<name>UsuarioEditorView.ascx</name>
						<sourceFileName>UsuarioEditorView.ascx</sourceFileName>
					</file>
				</files>
			</component>
		</components>
	</package>', 
		'CollectorsClub.EditorUsuarios', 
		'', 
		'CollectorsClub',
		'Module', 
		@PortalId, 
		'Este paquete no tiene notas de la versión', 
		'', 
		'1.0.0'
	)
	set @PackageId = SCOPE_IDENTITY()

	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Mantenimiento Usuarios', 3, -1, -1, '', 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @DesktopModuleContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_DesktopModules (BusinessControllerClass, CompatibleVersions, ContentItemId, CreatedByUserID, CreatedOnDate, Dependencies, Description, FolderName, FriendlyName, IsAdmin, IsPremium, LastModifiedByUserID, LastModifiedOnDate, ModuleName, PackageID, Permissions, Shareable, SupportedFeatures, Version)
	VALUES ('', null, @DesktopModuleContentItemId, @UserIdHost, @Fecha, null, 'Mantenimiento Usuarios', 'CollectorsClub.EditorUsuarios', 'Mantenimiento Usuarios', 0, 0, @UserIdHost, @Fecha, 'CollectorsClub.EditorUsuarios', @PackageId, null, 0, 0, '01.00.00')

	set @DesktopModuleId = SCOPE_IDENTITY()

	INSERT INTO dnn_ModuleDefinitions (CreatedByUserID, CreatedOnDate, DefaultCacheTime, DefinitionName, DesktopModuleID, FriendlyName, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@UserIdHost, @Fecha, 0, 'Mantenimiento Usuarios', @DesktopModuleId, 'Mantenimiento Usuarios', @UserIdHost, @Fecha)

	set @ModuleDefinitionId = SCOPE_IDENTITY()

	INSERT INTO dnn_PortalDesktopModules (CreatedByUserID, CreatedOnDate, DesktopModuleID, LastModifiedByUserID, LastModifiedOnDate, PortalID)
	VALUES (@UserIdHost, @Fecha, @DesktopModuleId, @UserIdHost, @Fecha, @PortalId)

	set @PortalDesktopModuleId = SCOPE_IDENTITY()

	INSERT INTO dnn_DesktopModulePermission (AllowAccess, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, PermissionID, PortalDesktopModuleID, RoleID, UserID)
	VALUES (1, @UserIdHost, @Fecha, @UserIdHost, @Fecha, 7, @PortalDesktopModuleId, @RoleIdHost, null)

	INSERT INTO dnn_ModuleControls (ControlKey, ControlSrc, ControlTitle, ControlType, CreatedByUserID, CreatedOnDate, HelpUrl, IconFile, LastModifiedByUserID, LastModifiedOnDate, ModuleDefID, SupportsPartialRendering, SupportsPopUps, ViewOrder)
	VALUES (null, 'DesktopModules/CollectorsClub/Editores/UsuarioEditorView.ascx', null, 0, @UserIdHost, @Fecha, null, null, @UserIdHost, @Fecha, @ModuleDefinitionId, 0, 0, 0)

	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Mantenimiento Usuarios', 2, @TabId, -1, null, 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @ModuleContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_Modules (AllTabs, ContentItemID, CreatedByUserID, CreatedOnDate, EndDate, InheritViewPermissions, IsDeleted, IsShareable, IsShareableViewOnly, LastContentModifiedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleDefID, PortalID, StartDate)
	VALUES (0, @ModuleContentItemId, @UserIdHost, @Fecha, null, 1, 0, 1, 1, null, @UserIdHost, @Fecha, @ModuleDefinitionId, @PortalId, null)

	set @ModuleId = SCOPE_IDENTITY()

	UPDATE dnn_ContentItems SET ModuleId = @ModuleId WHERE ContentItemID = @ModuleContentItemId

	INSERT INTO dnn_TabModules (Alignment, Border, CacheMethod, CacheTime, Color, ContainerSrc, CreatedByUserID, CreatedOnDate, CultureCode, DefaultLanguageGuid, DisplayPrint, DisplaySyndicate, DisplayTitle, Footer, Header, IconFile, IsDeleted, IsWebSlice,LastModifiedByUserID, LastModifiedOnDate, LocalizedVersionGuid, ModuleID, ModuleOrder, ModuleTitle, PaneName, TabID, UniqueId, VersionGuid, Visibility, WebSliceExpiryDate, WebSliceTitle, WebSliceTTL)
	VALUES (null, null, null, 0, null, null, @UserIdHost, @Fecha, '', null, 0, 0, 0, null, null, null, 0, 0, @UserIdHost, @Fecha, NewId(), @ModuleId, 3, 'Mantenimiento Usuarios', 'ContentPane', @TabId, NewId(), NewId(), 2, null, '', 0)

	set @TabModuleId = SCOPE_IDENTITY()

	-- DNN No le crea ningún permiso
	--INSERT INTO dnn_TabModuleSettings (CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, SettingName, SettingValue, TabModuleID)
	--VALUES (@UserIdHost, @Fecha, @UserIdHost, @Fecha, '', '', @TabModuleId)

	INSERT INTO dnn_ModulePermission (AllowAccess, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleID, PermissionID, PortalID, RoleID, UserID)
	VALUES (1, @UserIdHost, @Fecha, @UserIdHost, @Fecha, @ModuleId, 2, @PortalId, @RoleIdHost, null)

	-- DNN No le crea ningún permiso
	--INSERT INTO dnn_ModuleSettings (CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleID, SettingName, SettingValue) 
	--VALUES (@UserIdHost, @Fecha, @UserIdHost, @Fecha, @ModuleId, '', '') 
end
------------------------------- Fin script del módulo Usuarios  ------------------------------

------------------------------- Inicio script del módulo Videos  ------------------------------
USE CollectorsClubDNN;
GO

declare @NombrePaginaPadre as nvarchar(50) = 'Mantenimiento'
declare @TabIdMantenimientos as int = (SELECT TabId FROM dnn_tabs WHERE TabName = @NombrePaginaPadre AND [Level] = 0)
declare @PortalId as int = 0
declare @UserIdHost as int = 1
declare @RoleIdHost as int = -2
declare @RoleIdAdministrador as int = 0 -- OLL en GA no quiero que lo vean los Administradores, solo Host, Sino pondría el 5
declare @NivelEditores as int = 1
declare @Fecha as datetime = GetDate()
declare @SkinSrc as nvarchar(100) = '[G]Skins/Porto/CollectorsClub-Inner.ascx'

declare @TabContentItemId as int
declare @TabId as int
declare @PackageId as int
declare @DesktopModuleContentItemId as int
declare @DesktopModuleId as int
declare @ModuleDefinitionId as int
declare @PortalDesktopModuleId as int
declare @ModuleContentItemId as int
declare @ModuleId as int
declare @TabModuleId as int


if not exists(SELECT ContentItemId FROM dnn_ContentItems WHERE Content = 'Videos')
begin 
	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Videos', 1, -1, -1, null, 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @TabContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_Tabs (ContainerSrc, ContentItemID, CreatedByUserID, CreatedOnDate, CultureCode, DefaultLanguageGuid, Description, DisableLink, EndDate, IconFile, IconFileLarge, IsDeleted, IsSecure, IsVisible, KeyWords, LastModifiedByUserID, LastModifiedOnDate, Level, LocalizedVersionGuid, PageHeadText, ParentId, PermanentRedirect, PortalID, RefreshInterval, SiteMapPriority, SkinSrc, StartDate, TabName, TabOrder, TabPath, Title, UniqueId, Url, VersionGuid, HasBeenPublished, IsSystem)
	VALUES (null, @TabContentItemId, @UserIdHost, @Fecha, null, null, '', 0, null, '', '', 0, 0, 1, '', @UserIdHost, @Fecha, @NivelEditores, NewId(), null, @TabIdMantenimientos, 0, @PortalId, null, 0.5, @SkinSrc, null, 'Videos', 3, '//' + @NombrePaginaPadre + '//Videos', '', NewId(), '', NewId(), 1, 0)

	set @TabId = SCOPE_IDENTITY()

	UPDATE dnn_ContentItems SET TabId = @TabId WHERE ContentItemID = @TabContentItemId

	INSERT INTO dnn_TabSettings (TabID, SettingName, SettingValue, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 'AllowIndex', 'True', @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabSettings (TabID, SettingName, SettingValue, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 'LinkNewWindow', 'False', @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 3, 1, @RoleIdHost, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 4, 1, @RoleIdHost, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 3, 1, @RoleIdAdministrador, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	INSERT INTO dnn_Packages (
		CreatedByUserID, 
		CreatedOnDate, 
		Description, 
		Email, 
		FriendlyName, 
		IsSystemPackage, 
		LastModifiedByUserID, 
		LastModifiedOnDate, 
		License, 
		Manifest, 
		Name, 
		Organization, 
		Owner,
		PackageType, 
		PortalID, 
		ReleaseNotes, 
		Url, 
		Version
	) VALUES (
		@UserIdHost, 
		@Fecha, 
		'Mantenimiento Videos', 
		'', 
		'Mantenimiento Videos', 
		0, 
		@UserIdHost, 
		@Fecha, 
		'El archivo de instalación no contiene información de la licencia. Verifique con el vendedor los detalles de la licencia.', 
		'<package name="CollectorsClub.EditorVideos" type="Module" version="1.0.0">
		<friendlyName>CollectorsClub - Mantenimiento Videos</friendlyName>
		<description>CollectorsClub - Mantenimiento Videos</description>
		<iconFile />
		<owner>
			<name>CollectorsClub</name>
			<organization />
			<url />
			<email />
		</owner>
		<license>El archivo de instalación no contiene información de la licencia. Verifique con el vendedor los detalles de la licencia.</license>
		<releaseNotes />
		<components>
			<component type="Module">
				<desktopModule>
					<moduleName>CollectorsClub.EditorVideos</moduleName>
					<foldername>CollectorsClub.EditorVideos</foldername>
					<businessControllerClass />
					<supportedFeatures />
					<moduleDefinitions>
						<moduleDefinition>
							<friendlyName>CollectorsClub - Mantenimiento Videos</friendlyName>
							<definitionName>CollectorsClub - Mantenimiento Videos</definitionName>
							<defaultCacheTime>0</defaultCacheTime>
							<moduleControls>
								<moduleControl>
									<controlKey />
									<controlSrc>DesktopModules/CollectorsClub/Editores/VideoEditorView.ascx</controlSrc>
									<supportsPartialRendering>False</supportsPartialRendering>
									<controlTitle />
									<controlType>View</controlType>
									<iconFile />
									<helpUrl />
									<supportsPopUps>False</supportsPopUps>
									<viewOrder>0</viewOrder>
								</moduleControl>
							</moduleControls>
						</moduleDefinition>
					</moduleDefinitions>
				</desktopModule>
			</component>
			<component type="File">
				<files>
					<basePath>DesktopModules\CollectorsClub\Editores</basePath>
					<file>
						<name>VideoEditorView.ascx</name>
						<sourceFileName>VideoEditorView.ascx</sourceFileName>
					</file>
				</files>
			</component>
		</components>
	</package>', 
		'CollectorsClub.EditorVideos', 
		'', 
		'CollectorsClub',
		'Module', 
		@PortalId, 
		'Este paquete no tiene notas de la versión', 
		'', 
		'1.0.0'
	)
	set @PackageId = SCOPE_IDENTITY()

	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Mantenimiento Videos', 3, -1, -1, '', 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @DesktopModuleContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_DesktopModules (BusinessControllerClass, CompatibleVersions, ContentItemId, CreatedByUserID, CreatedOnDate, Dependencies, Description, FolderName, FriendlyName, IsAdmin, IsPremium, LastModifiedByUserID, LastModifiedOnDate, ModuleName, PackageID, Permissions, Shareable, SupportedFeatures, Version)
	VALUES ('', null, @DesktopModuleContentItemId, @UserIdHost, @Fecha, null, 'Mantenimiento Videos', 'CollectorsClub.EditorVideos', 'Mantenimiento Videos', 0, 0, @UserIdHost, @Fecha, 'CollectorsClub.EditorVideos', @PackageId, null, 0, 0, '01.00.00')

	set @DesktopModuleId = SCOPE_IDENTITY()

	INSERT INTO dnn_ModuleDefinitions (CreatedByUserID, CreatedOnDate, DefaultCacheTime, DefinitionName, DesktopModuleID, FriendlyName, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@UserIdHost, @Fecha, 0, 'Mantenimiento Videos', @DesktopModuleId, 'Mantenimiento Videos', @UserIdHost, @Fecha)

	set @ModuleDefinitionId = SCOPE_IDENTITY()

	INSERT INTO dnn_PortalDesktopModules (CreatedByUserID, CreatedOnDate, DesktopModuleID, LastModifiedByUserID, LastModifiedOnDate, PortalID)
	VALUES (@UserIdHost, @Fecha, @DesktopModuleId, @UserIdHost, @Fecha, @PortalId)

	set @PortalDesktopModuleId = SCOPE_IDENTITY()

	INSERT INTO dnn_DesktopModulePermission (AllowAccess, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, PermissionID, PortalDesktopModuleID, RoleID, UserID)
	VALUES (1, @UserIdHost, @Fecha, @UserIdHost, @Fecha, 7, @PortalDesktopModuleId, @RoleIdHost, null)

	INSERT INTO dnn_ModuleControls (ControlKey, ControlSrc, ControlTitle, ControlType, CreatedByUserID, CreatedOnDate, HelpUrl, IconFile, LastModifiedByUserID, LastModifiedOnDate, ModuleDefID, SupportsPartialRendering, SupportsPopUps, ViewOrder)
	VALUES (null, 'DesktopModules/CollectorsClub/Editores/VideoEditorView.ascx', null, 0, @UserIdHost, @Fecha, null, null, @UserIdHost, @Fecha, @ModuleDefinitionId, 0, 0, 0)

	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Mantenimiento Videos', 2, @TabId, -1, null, 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @ModuleContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_Modules (AllTabs, ContentItemID, CreatedByUserID, CreatedOnDate, EndDate, InheritViewPermissions, IsDeleted, IsShareable, IsShareableViewOnly, LastContentModifiedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleDefID, PortalID, StartDate)
	VALUES (0, @ModuleContentItemId, @UserIdHost, @Fecha, null, 1, 0, 1, 1, null, @UserIdHost, @Fecha, @ModuleDefinitionId, @PortalId, null)

	set @ModuleId = SCOPE_IDENTITY()

	UPDATE dnn_ContentItems SET ModuleId = @ModuleId WHERE ContentItemID = @ModuleContentItemId

	INSERT INTO dnn_TabModules (Alignment, Border, CacheMethod, CacheTime, Color, ContainerSrc, CreatedByUserID, CreatedOnDate, CultureCode, DefaultLanguageGuid, DisplayPrint, DisplaySyndicate, DisplayTitle, Footer, Header, IconFile, IsDeleted, IsWebSlice,LastModifiedByUserID, LastModifiedOnDate, LocalizedVersionGuid, ModuleID, ModuleOrder, ModuleTitle, PaneName, TabID, UniqueId, VersionGuid, Visibility, WebSliceExpiryDate, WebSliceTitle, WebSliceTTL)
	VALUES (null, null, null, 0, null, null, @UserIdHost, @Fecha, '', null, 0, 0, 0, null, null, null, 0, 0, @UserIdHost, @Fecha, NewId(), @ModuleId, 3, 'Mantenimiento Videos', 'ContentPane', @TabId, NewId(), NewId(), 2, null, '', 0)

	set @TabModuleId = SCOPE_IDENTITY()

	-- DNN No le crea ningún permiso
	--INSERT INTO dnn_TabModuleSettings (CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, SettingName, SettingValue, TabModuleID)
	--VALUES (@UserIdHost, @Fecha, @UserIdHost, @Fecha, '', '', @TabModuleId)

	INSERT INTO dnn_ModulePermission (AllowAccess, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleID, PermissionID, PortalID, RoleID, UserID)
	VALUES (1, @UserIdHost, @Fecha, @UserIdHost, @Fecha, @ModuleId, 2, @PortalId, @RoleIdHost, null)

	-- DNN No le crea ningún permiso
	--INSERT INTO dnn_ModuleSettings (CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleID, SettingName, SettingValue) 
	--VALUES (@UserIdHost, @Fecha, @UserIdHost, @Fecha, @ModuleId, '', '') 
end
------------------------------- Fin script del módulo Videos  ------------------------------

------------------------------- Inicio script del módulo Videos_Idiomas  ------------------------------
USE CollectorsClubDNN;
GO

declare @NombrePaginaPadre as nvarchar(50) = 'Mantenimiento'
declare @TabIdMantenimientos as int = (SELECT TabId FROM dnn_tabs WHERE TabName = @NombrePaginaPadre AND [Level] = 0)
declare @PortalId as int = 0
declare @UserIdHost as int = 1
declare @RoleIdHost as int = -2
declare @RoleIdAdministrador as int = 0 -- OLL en GA no quiero que lo vean los Administradores, solo Host, Sino pondría el 5
declare @NivelEditores as int = 1
declare @Fecha as datetime = GetDate()
declare @SkinSrc as nvarchar(100) = '[G]Skins/Porto/CollectorsClub-Inner.ascx'

declare @TabContentItemId as int
declare @TabId as int
declare @PackageId as int
declare @DesktopModuleContentItemId as int
declare @DesktopModuleId as int
declare @ModuleDefinitionId as int
declare @PortalDesktopModuleId as int
declare @ModuleContentItemId as int
declare @ModuleId as int
declare @TabModuleId as int


if not exists(SELECT ContentItemId FROM dnn_ContentItems WHERE Content = 'Videos_Idiomas')
begin 
	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Videos_Idiomas', 1, -1, -1, null, 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @TabContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_Tabs (ContainerSrc, ContentItemID, CreatedByUserID, CreatedOnDate, CultureCode, DefaultLanguageGuid, Description, DisableLink, EndDate, IconFile, IconFileLarge, IsDeleted, IsSecure, IsVisible, KeyWords, LastModifiedByUserID, LastModifiedOnDate, Level, LocalizedVersionGuid, PageHeadText, ParentId, PermanentRedirect, PortalID, RefreshInterval, SiteMapPriority, SkinSrc, StartDate, TabName, TabOrder, TabPath, Title, UniqueId, Url, VersionGuid, HasBeenPublished, IsSystem)
	VALUES (null, @TabContentItemId, @UserIdHost, @Fecha, null, null, '', 0, null, '', '', 0, 0, 1, '', @UserIdHost, @Fecha, @NivelEditores, NewId(), null, @TabIdMantenimientos, 0, @PortalId, null, 0.5, @SkinSrc, null, 'Videos_Idiomas', 3, '//' + @NombrePaginaPadre + '//Videos_Idiomas', '', NewId(), '', NewId(), 1, 0)

	set @TabId = SCOPE_IDENTITY()

	UPDATE dnn_ContentItems SET TabId = @TabId WHERE ContentItemID = @TabContentItemId

	INSERT INTO dnn_TabSettings (TabID, SettingName, SettingValue, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 'AllowIndex', 'True', @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabSettings (TabID, SettingName, SettingValue, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 'LinkNewWindow', 'False', @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 3, 1, @RoleIdHost, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 4, 1, @RoleIdHost, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)
	INSERT INTO dnn_TabPermission (TabID, PermissionID, AllowAccess, RoleID, UserID, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@TabId, 3, 1, @RoleIdAdministrador, null, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	INSERT INTO dnn_Packages (
		CreatedByUserID, 
		CreatedOnDate, 
		Description, 
		Email, 
		FriendlyName, 
		IsSystemPackage, 
		LastModifiedByUserID, 
		LastModifiedOnDate, 
		License, 
		Manifest, 
		Name, 
		Organization, 
		Owner,
		PackageType, 
		PortalID, 
		ReleaseNotes, 
		Url, 
		Version
	) VALUES (
		@UserIdHost, 
		@Fecha, 
		'Mantenimiento Videos_Idiomas', 
		'', 
		'Mantenimiento Videos_Idiomas', 
		0, 
		@UserIdHost, 
		@Fecha, 
		'El archivo de instalación no contiene información de la licencia. Verifique con el vendedor los detalles de la licencia.', 
		'<package name="CollectorsClub.EditorVideos_Idiomas" type="Module" version="1.0.0">
		<friendlyName>CollectorsClub - Mantenimiento Videos_Idiomas</friendlyName>
		<description>CollectorsClub - Mantenimiento Videos_Idiomas</description>
		<iconFile />
		<owner>
			<name>CollectorsClub</name>
			<organization />
			<url />
			<email />
		</owner>
		<license>El archivo de instalación no contiene información de la licencia. Verifique con el vendedor los detalles de la licencia.</license>
		<releaseNotes />
		<components>
			<component type="Module">
				<desktopModule>
					<moduleName>CollectorsClub.EditorVideos_Idiomas</moduleName>
					<foldername>CollectorsClub.EditorVideos_Idiomas</foldername>
					<businessControllerClass />
					<supportedFeatures />
					<moduleDefinitions>
						<moduleDefinition>
							<friendlyName>CollectorsClub - Mantenimiento Videos_Idiomas</friendlyName>
							<definitionName>CollectorsClub - Mantenimiento Videos_Idiomas</definitionName>
							<defaultCacheTime>0</defaultCacheTime>
							<moduleControls>
								<moduleControl>
									<controlKey />
									<controlSrc>DesktopModules/CollectorsClub/Editores/Video_IdiomaEditorView.ascx</controlSrc>
									<supportsPartialRendering>False</supportsPartialRendering>
									<controlTitle />
									<controlType>View</controlType>
									<iconFile />
									<helpUrl />
									<supportsPopUps>False</supportsPopUps>
									<viewOrder>0</viewOrder>
								</moduleControl>
							</moduleControls>
						</moduleDefinition>
					</moduleDefinitions>
				</desktopModule>
			</component>
			<component type="File">
				<files>
					<basePath>DesktopModules\CollectorsClub\Editores</basePath>
					<file>
						<name>Video_IdiomaEditorView.ascx</name>
						<sourceFileName>Video_IdiomaEditorView.ascx</sourceFileName>
					</file>
				</files>
			</component>
		</components>
	</package>', 
		'CollectorsClub.EditorVideos_Idiomas', 
		'', 
		'CollectorsClub',
		'Module', 
		@PortalId, 
		'Este paquete no tiene notas de la versión', 
		'', 
		'1.0.0'
	)
	set @PackageId = SCOPE_IDENTITY()

	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Mantenimiento Videos_Idiomas', 3, -1, -1, '', 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @DesktopModuleContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_DesktopModules (BusinessControllerClass, CompatibleVersions, ContentItemId, CreatedByUserID, CreatedOnDate, Dependencies, Description, FolderName, FriendlyName, IsAdmin, IsPremium, LastModifiedByUserID, LastModifiedOnDate, ModuleName, PackageID, Permissions, Shareable, SupportedFeatures, Version)
	VALUES ('', null, @DesktopModuleContentItemId, @UserIdHost, @Fecha, null, 'Mantenimiento Videos_Idiomas', 'CollectorsClub.EditorVideos_Idiomas', 'Mantenimiento Videos_Idiomas', 0, 0, @UserIdHost, @Fecha, 'CollectorsClub.EditorVideos_Idiomas', @PackageId, null, 0, 0, '01.00.00')

	set @DesktopModuleId = SCOPE_IDENTITY()

	INSERT INTO dnn_ModuleDefinitions (CreatedByUserID, CreatedOnDate, DefaultCacheTime, DefinitionName, DesktopModuleID, FriendlyName, LastModifiedByUserID, LastModifiedOnDate)
	VALUES (@UserIdHost, @Fecha, 0, 'Mantenimiento Videos_Idiomas', @DesktopModuleId, 'Mantenimiento Videos_Idiomas', @UserIdHost, @Fecha)

	set @ModuleDefinitionId = SCOPE_IDENTITY()

	INSERT INTO dnn_PortalDesktopModules (CreatedByUserID, CreatedOnDate, DesktopModuleID, LastModifiedByUserID, LastModifiedOnDate, PortalID)
	VALUES (@UserIdHost, @Fecha, @DesktopModuleId, @UserIdHost, @Fecha, @PortalId)

	set @PortalDesktopModuleId = SCOPE_IDENTITY()

	INSERT INTO dnn_DesktopModulePermission (AllowAccess, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, PermissionID, PortalDesktopModuleID, RoleID, UserID)
	VALUES (1, @UserIdHost, @Fecha, @UserIdHost, @Fecha, 7, @PortalDesktopModuleId, @RoleIdHost, null)

	INSERT INTO dnn_ModuleControls (ControlKey, ControlSrc, ControlTitle, ControlType, CreatedByUserID, CreatedOnDate, HelpUrl, IconFile, LastModifiedByUserID, LastModifiedOnDate, ModuleDefID, SupportsPartialRendering, SupportsPopUps, ViewOrder)
	VALUES (null, 'DesktopModules/CollectorsClub/Editores/Video_IdiomaEditorView.ascx', null, 0, @UserIdHost, @Fecha, null, null, @UserIdHost, @Fecha, @ModuleDefinitionId, 0, 0, 0)

	INSERT INTO dnn_ContentItems (Content, ContentTypeID, TabID, ModuleID, ContentKey, Indexed, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate)
	VALUES ('Mantenimiento Videos_Idiomas', 2, @TabId, -1, null, 0, @UserIdHost, @Fecha, @UserIdHost, @Fecha)

	set @ModuleContentItemId = SCOPE_IDENTITY()

	INSERT INTO dnn_Modules (AllTabs, ContentItemID, CreatedByUserID, CreatedOnDate, EndDate, InheritViewPermissions, IsDeleted, IsShareable, IsShareableViewOnly, LastContentModifiedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleDefID, PortalID, StartDate)
	VALUES (0, @ModuleContentItemId, @UserIdHost, @Fecha, null, 1, 0, 1, 1, null, @UserIdHost, @Fecha, @ModuleDefinitionId, @PortalId, null)

	set @ModuleId = SCOPE_IDENTITY()

	UPDATE dnn_ContentItems SET ModuleId = @ModuleId WHERE ContentItemID = @ModuleContentItemId

	INSERT INTO dnn_TabModules (Alignment, Border, CacheMethod, CacheTime, Color, ContainerSrc, CreatedByUserID, CreatedOnDate, CultureCode, DefaultLanguageGuid, DisplayPrint, DisplaySyndicate, DisplayTitle, Footer, Header, IconFile, IsDeleted, IsWebSlice,LastModifiedByUserID, LastModifiedOnDate, LocalizedVersionGuid, ModuleID, ModuleOrder, ModuleTitle, PaneName, TabID, UniqueId, VersionGuid, Visibility, WebSliceExpiryDate, WebSliceTitle, WebSliceTTL)
	VALUES (null, null, null, 0, null, null, @UserIdHost, @Fecha, '', null, 0, 0, 0, null, null, null, 0, 0, @UserIdHost, @Fecha, NewId(), @ModuleId, 3, 'Mantenimiento Videos_Idiomas', 'ContentPane', @TabId, NewId(), NewId(), 2, null, '', 0)

	set @TabModuleId = SCOPE_IDENTITY()

	-- DNN No le crea ningún permiso
	--INSERT INTO dnn_TabModuleSettings (CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, SettingName, SettingValue, TabModuleID)
	--VALUES (@UserIdHost, @Fecha, @UserIdHost, @Fecha, '', '', @TabModuleId)

	INSERT INTO dnn_ModulePermission (AllowAccess, CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleID, PermissionID, PortalID, RoleID, UserID)
	VALUES (1, @UserIdHost, @Fecha, @UserIdHost, @Fecha, @ModuleId, 2, @PortalId, @RoleIdHost, null)

	-- DNN No le crea ningún permiso
	--INSERT INTO dnn_ModuleSettings (CreatedByUserID, CreatedOnDate, LastModifiedByUserID, LastModifiedOnDate, ModuleID, SettingName, SettingValue) 
	--VALUES (@UserIdHost, @Fecha, @UserIdHost, @Fecha, @ModuleId, '', '') 
end
------------------------------- Fin script del módulo Videos_Idiomas  ------------------------------

