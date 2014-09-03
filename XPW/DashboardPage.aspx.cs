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
        DashboardBC _bc = new DashboardBC();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public int CO2
        {
            get
            {
                return (int)(_bc.GetCO2Year() * 0.001);
            }
        }

        public int Trees
        {
            get
            {
                return (int)(_bc.GetCO2Year() / 111);
            }
        }
    }
}