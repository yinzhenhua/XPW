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
            dlSite.Items.AddRange(new ListItem[] {
                    new ListItem("ALL","-1"),
                    new ListItem("FAC","390"),
                    new ListItem("TEST","394"),
                    new ListItem("DP","391"),
                    new ListItem("KGD","395"),
                    new ListItem("BOP","393"),
                    new ListItem("MOLD","392"),
                    new ListItem("COP","400"),
                    new ListItem("SMT","398"),
                    new ListItem("LAB","397"),
                    new ListItem("EMI","396"),
                    new ListItem("RFF","399"),
                });
            ElectricityConsumptionDS ds = _bc.GetAllEquipmentEnergy();
            gvDept.DataSource = ds.ElectricityConsumption;
            gvDept.DataBind();
        }

        protected void dlSite_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                if (dlSite.SelectedIndex == 0)
                {
                    ElectricityConsumptionDS ds = _bc.GetAllEquipmentEnergy();
                    gvDept.DataSource = ds.ElectricityConsumption;
                    gvDept.DataBind();
                    ecpChart.Visible = false;
                }
                else
                {
                    int deviceID = Convert.ToInt32(dlSite.SelectedValue);
                    ElectricityConsumptionDS ds = _bc.GetEquipmentEnergy(deviceID);
                    gvDept.DataSource = ds.ElectricityConsumption;
                    gvDept.DataBind();
                    //MsChart
                    ecpChart.Visible = true;
                    ecpChart.Titles.Add(dlSite.SelectedItem.Text);
                    ecpChart.Series["ecpSeries"].ChartType = System.Web.UI.DataVisualization.Charting.SeriesChartType.Column;
                    ecpChart.DataSource = _bc.CreateEquipmentEnergyTable(ds);
                    ecpChart.Series["ecpSeries"].IsValueShownAsLabel = true;//显示坐标值
                    ecpChart.Series["ecpSeries"].XValueMember = "Name";//X轴数据成员列
                    ecpChart.Series["ecpSeries"].YValueMembers = "Total";//Y轴数据成员列
                    ecpChart.ChartAreas["ecpChartArea"].AxisX.Interval = 1;//X轴数据的间距
                    ecpChart.ChartAreas["ecpChartArea"].AxisX.TextOrientation = System.Web.UI.DataVisualization.Charting.TextOrientation.Horizontal;
                    ecpChart.ChartAreas["ecpChartArea"].AxisX.MajorGrid.Enabled = false;//不显示竖着的分割线
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}