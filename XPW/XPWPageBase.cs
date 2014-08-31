using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using Microsoft.Practices.EnterpriseLibrary.ExceptionHandling;

namespace XPW
{
    public class XPWPageBase : Page
    {
        public bool HandleException(Exception ex)
        {
            return ExceptionPolicy.HandleException(ex, "UI Policy");
        }
    }
}