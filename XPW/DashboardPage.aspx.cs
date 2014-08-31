using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using XPW.BC;

namespace XPW
{
    public partial class DashboardPage : XPWPageBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DashboardBC bc = new DashboardBC();
            lblCOO2.Text = bc.GetMonthCO2Total().ToString();
        }
    }
}