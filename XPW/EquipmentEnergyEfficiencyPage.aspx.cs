using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using XPW.BC;
using XPW.BE;

namespace XPW
{
    public partial class EquipmentEnergyEfficiencyPage : System.Web.UI.Page
    {
        private ElectricityConsumptionBC _bc = new ElectricityConsumptionBC();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Initialize();
            }
        }

        private void Initialize()
        {
            int deviceID = Convert.ToInt32(Request.QueryString["DeviceID"]);
            string name = Request.QueryString["Name"] as string;
            ElectricityConsumptionDS ds = _bc.GetEquipmentEnergy(deviceID);
            //MsChart
            ecpChart.Titles["ecpTitle"].Text = name;
            ecpChart.Series["ecpSeries"].ChartType = System.Web.UI.DataVisualization.Charting.SeriesChartType.Column;
            ecpChart.Series["ecpSeries"]["PointWidth"] = "0.8";
            ecpChart.Series["ecpSeries"]["BarLabelStyle"] = "Center";
            ecpChart.Series["ecpSeries"]["DrawingStyle"] = "Cylinder";
            ecpChart.Series["ecpSeries"].ToolTip = "#VALX:#VALY";
            ecpChart.Series["ecpSeries"].IsValueShownAsLabel = false;//显示坐标值
            ecpChart.Series["ecpSeries"].XValueMember = "Name";//X轴数据成员列
            ecpChart.Series["ecpSeries"].YValueMembers = "Total";//Y轴数据成员列
            ecpChart.ChartAreas["ecpChartArea"].AxisY.LabelStyle.ForeColor = Color.Red;
            ecpChart.ChartAreas["ecpChartArea"].AxisY.LabelStyle.Font = new Font("Microsoft Sans Serif", 8);
            ecpChart.ChartAreas["ecpChartArea"].AxisX.LabelStyle.Font = new Font("Microsoft Sans Serif", 10, FontStyle.Bold);
            ecpChart.ChartAreas["ecpChartArea"].AxisX.Interval = 1;
            ecpChart.ChartAreas["ecpChartArea"].AxisX.LabelStyle.ForeColor = Color.FromArgb(155, 187, 89);
            ecpChart.ChartAreas["ecpChartArea"].AxisX.MajorGrid.Enabled = false;//不显示竖着的分割线
            ecpChart.DataSource = _bc.CreateEquipmentEnergyTable(ds);
            ecpChart.DataBind();
        }
    }
}