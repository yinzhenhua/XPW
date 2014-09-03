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
                    ecpChart.DataSource = _bc.CreateEquipmentEnergyTable(ds);
                    ecpChart.Titles["ecpTitle"].Text = dlSite.SelectedItem.Text;
                    ecpChart.Series["ecpSeries"].ChartType = System.Web.UI.DataVisualization.Charting.SeriesChartType.Column;
                    ecpChart.Series["ecpSeries"]["PointWidth"] = "0.8";
                    ecpChart.Series["ecpSeries"]["BarLabelStyle"] = "Center";
                    ecpChart.Series["ecpSeries"]["DrawingStyle"] = "Cylinder";
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

        protected void gvDept_RowCreated(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    //移除最后一行ImageButton
                    if (e.Row.RowIndex == 11)
                    {
                        ImageButton imageBtn = e.Row.Cells[17].FindControl("btnGraph") as ImageButton;
                        if (imageBtn != null)
                        {
                            e.Row.Cells[17].Controls.Remove(imageBtn);
                        }
                    }
                }
                if (e.Row.RowType == DataControlRowType.Header)
                {
                    string[] strs = Common.GetQuarters();
                    e.Row.Cells[10].Text = strs[0];
                    e.Row.Cells[11].Text = strs[1];
                    e.Row.Cells[12].Text = strs[2];
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected void gvDept_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                e.Row.Attributes.Add("style", "height:30px");
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
    }
}