using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using Thinktecture.IdentityModel.Web.Configuration;

[assembly:PreApplicationStartMethod(typeof(AppStart), "Start")]

namespace Thinktecture.IdentityModel.Web.Configuration
{
    public class AppStart
    {
        public static void Start()
        {
            SessionConfiguration.Start();
        }
    }
}
