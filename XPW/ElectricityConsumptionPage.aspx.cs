using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using XPW.BC;
using XPW.BE;

namespace XPW
{
    public partial class ElectricityConsumptionPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ElectricityConsumptionBC bc = new ElectricityConsumptionBC();
            ElectricityConsumptionDS ds = bc.GetAllEquipmentEnergy();
        }
    }
}