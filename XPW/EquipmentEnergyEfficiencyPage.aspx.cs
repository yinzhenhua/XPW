using System;
using System.Collections.Generic;
using System.Data;
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
        private EquipmentEnergyBC _bc = new EquipmentEnergyBC();
        private ElectricityConsumptionBC _consumptionBC = new ElectricityConsumptionBC();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Initialize();
            }
        }

        private void Initialize()
        {
            int deviceID = 395;//Convert.ToInt32(Request.QueryString["DeviceID"]);
            string name = "KDG";//Request.QueryString["Name"];
            lblTitle.Text = string.Format("{0} - Dept. Equipment Efficiency", name);
            //Chart图
            ElectricityConsumptionDS ds = _consumptionBC.GetEquipmentEnergy(deviceID);
            if (ds.ElectricityConsumption.Rows.Count > 0)
            {
                //绑定数据
                EquipmentEnergyEfficiencyDS energyDS = _bc.GetEquipmentEnergyEfficiency(deviceID,
                    10,
                    ds.ElectricityConsumption[0].PreviousYear,
                    ds.ElectricityConsumption[0].YTD,
                    ds.ElectricityConsumption[0].Q1,
                    ds.ElectricityConsumption[0].Q2,
                    ds.ElectricityConsumption[0].Q3,
                    ds.ElectricityConsumption[0].Q4,
                    ds.ElectricityConsumption[0].Month1,
                    ds.ElectricityConsumption[0].Month2,
                    ds.ElectricityConsumption[0].Month3,
                    ds.ElectricityConsumption[0].Week1,
                    ds.ElectricityConsumption[0].Week2,
                    ds.ElectricityConsumption[0].Week3,
                    ds.ElectricityConsumption[0].Week4);
                gvDept.DataSource = energyDS.EquipmentEnergyEfficiency;
                gvDept.DataBind();
                //显示Chart图
                DataTable table = _bc.CreateEquipmentEnergyEfficiencyTable(energyDS);
                ecpChart.Titles["ecpTitle"].Text = lblTitle.Text;
                ecpChart.Series["ecpSeries"].ChartType = System.Web.UI.DataVisualization.Charting.SeriesChartType.Column;
                ecpChart.Series["ecpSeries"]["PointWidth"] = "0.8";
                ecpChart.Series["ecpSeries"]["BarLabelStyle"] = "Center";
                ecpChart.Series["ecpSeries"]["DrawingStyle"] = "Cylinder";
                ecpChart.Series["ecpSeries"].IsValueShownAsLabel = true;//显示坐标值
                ecpChart.ChartAreas["ecpChartArea"].AxisX.Interval = 1;//X轴数据的间距
                ecpChart.ChartAreas["ecpChartArea"].AxisX.TextOrientation = System.Web.UI.DataVisualization.Charting.TextOrientation.Horizontal;
                ecpChart.ChartAreas["ecpChartArea"].AxisX.MajorGrid.Enabled = false;//不显示竖着的分割线
                ecpChart.ChartAreas["ecpChartArea"].AxisX.MajorTickMark.Enabled = false;
                for (int i = 0; i < table.Rows.Count; i++)
                {
                    double value = Convert.ToDouble(table.Rows[i]["Total"]);
                    ecpChart.Series["ecpSeries"].Points.AddXY(table.Rows[i]["Name"] as string, value);
                    if (value >= 1)
                    {
                        ecpChart.Series["ecpSeries"].Points[i].Color = Color.Red;
                    }
                }
            }
        }

        protected void gvDept_RowCreated(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if (e.Row.RowType != DataControlRowType.Header) return;
                string[] strs = Common.GetQuarters();
                e.Row.Cells[7].Text = strs[0];
                e.Row.Cells[8].Text = strs[1];
                e.Row.Cells[9].Text = strs[2];
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
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    switch (e.Row.RowIndex)
                    {
                        case 1://第1行
                            {
                                for (int i = 1; i < e.Row.Cells.Count; i++)
                                {
                                    double value = Convert.ToDouble(e.Row.Cells[i].Text);
                                    e.Row.Cells[i].Text = string.Format("{0:p}", value);
                                }
                            }
                            break;
                        case 4://第5行
                            {
                                for (int i = 1; i < e.Row.Cells.Count; i++)
                                {
                                    double value = Convert.ToDouble(e.Row.Cells[i].Text);
                                    if (value >= 1)
                                    {
                                        e.Row.Cells[i].ForeColor = Color.Red;
                                    }
                                }
                            }
                            break;
                    }

                }
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
    }
}