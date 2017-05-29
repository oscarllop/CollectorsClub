﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using Dnn.PersonaBar.Library;
using Dnn.PersonaBar.Library.Attributes;
using System.Net.Http;
using System.Web.Http;
using Dnn.PersonaBar.UI.Services.DTO;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Entities.Users;
using DotNetNuke.Instrumentation;
using DotNetNuke.Security.Roles;
using DotNetNuke.Web.Api;

namespace Dnn.PersonaBar.UI.Services
{
    /// <summary>
    /// Services used for common components.
    /// </summary>
    [MenuPermission(Scope = ServiceScope.Regular)]
    public class ComponentsController : PersonaBarApiController
    {
        private static readonly ILog Logger = LoggerSource.Instance.GetLogger(typeof (ComponentsController));

        #region API in Admin Level

        [HttpGet]
        [DnnAuthorize(StaticRoles = Constants.AdminsRoleName)]
        public HttpResponseMessage GetRoleGroups(bool reload = false)
        {
            try
            {
                if (reload)
                {
                    DataCache.RemoveCache(string.Format(DataCache.RoleGroupsCacheKey, PortalId));
                }

                var groups = RoleController.GetRoleGroups(PortalId)
                                .Cast<RoleGroupInfo>()
                                .Select(RoleGroupDto.FromRoleGroupInfo);

                return Request.CreateResponse(HttpStatusCode.OK, groups);
            }
            catch (Exception ex)
            {
                Logger.Error(ex);
                return Request.CreateResponse(HttpStatusCode.InternalServerError, new { Error = ex.Message });
            }
        }

        #endregion

        #region API in Regular Level

        [HttpGet]
        public HttpResponseMessage GetSuggestionUsers(string keyword, int count)
        {
            try
            {
                if (string.IsNullOrEmpty(keyword))
                {
                    return Request.CreateResponse(HttpStatusCode.OK, new List<SuggestionDto>());
                }

                var displayMatch = keyword + "%";
                var totalRecords = 0;
                var matchedUsers = UserController.GetUsersByDisplayName(PortalId, displayMatch, 0, count,
                    ref totalRecords, false, false)
                    .Cast<UserInfo>()
                    .Select(u => new SuggestionDto()
                    {
                        Value = u.UserID,
                        Label = $"{u.DisplayName}"
                    });

                return Request.CreateResponse(HttpStatusCode.OK, matchedUsers);
            }
            catch (Exception ex)
            {
                Logger.Error(ex);
                return Request.CreateResponse(HttpStatusCode.InternalServerError, new { Error = ex.Message });
            }

        }

        public HttpResponseMessage GetSuggestionRoles(string keyword, int roleGroupId, int count)
        {
            try
            {
                if (string.IsNullOrEmpty(keyword))
                {
                    return Request.CreateResponse(HttpStatusCode.OK, new List<SuggestionDto>());
                }

                var matchedRoles = RoleController.Instance.GetRoles(PortalId)
                    .Where(r => (roleGroupId == -2 || r.RoleGroupID == roleGroupId)
                                && r.RoleName.IndexOf(keyword, StringComparison.InvariantCultureIgnoreCase) > -1)
                    .Select(r => new SuggestionDto()
                    {
                        Value = r.RoleID,
                        Label = r.RoleName
                    });

                return Request.CreateResponse(HttpStatusCode.OK, matchedRoles);
            }
            catch (Exception ex)
            {
                Logger.Error(ex);
                return Request.CreateResponse(HttpStatusCode.InternalServerError, new { Error = ex.Message });
            }

        }

        #endregion
    }
}