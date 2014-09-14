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
            int deviceID = Convert.ToInt32(Request.QueryString["DeviceID"]);
            string name = Request.QueryString["Name"];
            lblTitle.Text = string.Format("{0} - Dept. Equipment Efficiency", name);
            //Chart图
            ElectricityConsumptionDS ds = _consumptionBC.GetEquipmentEnergy(deviceID);
            if (ds.ElectricityConsumption.Rows.Count > 0)
            {
                //绑定数据
                EquipmentEnergyEfficiencyDS energyDS = _bc.GetEquipmentEnergyEfficiency(deviceID,
                    108,//Todo
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
                    ds.ElectricityConsumption[0].Week4,
                    ds.ElectricityConsumption[0].Week5,
                    ds.ElectricityConsumption[0].Week6);
                gvDept.DataSource = energyDS.EquipmentEnergyEfficiency;
                gvDept.DataBind();
                //显示Chart图
                DataTable table = _bc.CreateEquipmentEnergyEfficiencyTable(energyDS);
                ecpChart.Titles["ecpTitle"].Text = lblTitle.Text;
                //Efficiency
                ecpChart.Series["Efficiency"].ChartType = System.Web.UI.DataVisualization.Charting.SeriesChartType.Column;
                ecpChart.Series["Efficiency"]["PointWidth"] = "0.8";
                ecpChart.Series["Efficiency"]["BarLabelStyle"] = "Center";
                ecpChart.Series["Efficiency"]["DrawingStyle"] = "Cylinder";
                ecpChart.Series["Efficiency"].IsValueShownAsLabel = false;//显示坐标值
                //BaseLine
                ecpChart.Series["Baseline"].ChartType = System.Web.UI.DataVisualization.Charting.SeriesChartType.Line;
                ecpChart.Series["Baseline"]["PointWidth"] = "2";
                ecpChart.Series["Baseline"]["BarLabelStyle"] = "Center";
                ecpChart.Series["Baseline"]["DrawingStyle"] = "Cylinder";
                ecpChart.Series["Baseline"].IsValueShownAsLabel = false;//显示坐标值
                //
                ecpChart.ChartAreas["ecpChartArea"].AxisY.Maximum = 1.2;
                ecpChart.ChartAreas["ecpChartArea"].AxisY.Minimum = 0;
                ecpChart.ChartAreas["ecpChartArea"].AxisY.Interval = 0.2;
                ecpChart.ChartAreas["ecpChartArea"].AxisY.LabelStyle.ForeColor = Color.FromArgb(0, 176, 80);
                ecpChart.ChartAreas["ecpChartArea"].AxisY.LabelStyle.Font = new Font("Microsoft Sans Serif", 10, FontStyle.Bold);
                ecpChart.ChartAreas["ecpChartArea"].AxisY.MajorTickMark.TickMarkStyle = System.Web.UI.DataVisualization.Charting.TickMarkStyle.None;
                ecpChart.ChartAreas["ecpChartArea"].AxisX.TextOrientation = System.Web.UI.DataVisualization.Charting.TextOrientation.Horizontal;
                ecpChart.ChartAreas["ecpChartArea"].AxisX.LabelStyle.ForeColor = Color.FromArgb(0, 176, 80);
                ecpChart.ChartAreas["ecpChartArea"].AxisX.LabelStyle.Font = new Font("Microsoft Sans Serif", 10, FontStyle.Bold);
                ecpChart.ChartAreas["ecpChartArea"].AxisX.Interval = 1;
                ecpChart.ChartAreas["ecpChartArea"].AxisX.MajorGrid.Enabled = false;//不显示竖着的分割线
                ecpChart.ChartAreas["ecpChartArea"].AxisX.MajorTickMark.Enabled = false;
                for (int i = 0; i < table.Rows.Count; i++)
                {
                    double value1 = Convert.ToDouble(table.Rows[i]["Total"]);
                    double value2 = Convert.ToDouble(table.Rows[i]["BaseLine"]);
                    ecpChart.Series["Efficiency"].Points.AddXY(table.Rows[i]["Name"] as string, value1);
                    ecpChart.Series["Baseline"].Points.AddXY(table.Rows[i]["Name"] as string, value2);
                    if (value1 >= 1)
                    {
                        ecpChart.Series["Efficiency"].Points[i].Color = Color.Red;
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
                if (e.Row.RowType == DataControlRowType.Header)
                {
                    string style = "padding: 4px 2px;"
                     + " color: #fff;"
                     + " background: #424242 url(grd_head.png) repeat-x top;"
                     + "border-left: solid 1px #525252;"
                     + "font-size: 14px;"
                     + "text-align: left;";
                    e.Row.Cells[0].Attributes.Remove("style");
                    e.Row.Cells[0].Attributes.Add("style", style);
                }
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    string style = " padding: 4px;"
                    + "border: solid 1px #92d050;"
                    + "color: #92D050;"
                    + "text-align: left;"
                    + "font-family: \"Microsoft YaHei\";"
                    + "font-size: 13px;"
                    + "font-weight: 700;"
                    + "height: 25px;";
                    e.Row.Cells[0].Attributes.Remove("style");
                    e.Row.Cells[0].Attributes.Add("style", style);

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