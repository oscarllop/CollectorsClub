﻿using System;
using System.Linq;

namespace Dnn.PersonaBar.Security.Components.Checks
{
    public class CheckHiddenSystemFiles : IAuditCheck
    {
        public CheckResult Execute()
        {
            var result = new CheckResult(SeverityEnum.Unverified, "CheckHiddenSystemFiles");
            try
            {
                var investigatefiles = Utility.FineHiddenSystemFiles();
                if (investigatefiles.Any())
                {
                    result.Severity = SeverityEnum.Failure;
                    foreach (var filename in investigatefiles)
                    {
                        result.Notes.Add("file:" + filename);
                    }
                }
                else
                {
                    result.Severity = SeverityEnum.Pass;
                }
            }
            catch (Exception)
            {
                throw;
            }
            return result;
        }
    }
}