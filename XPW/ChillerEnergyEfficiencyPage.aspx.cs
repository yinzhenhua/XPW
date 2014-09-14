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
    public partial class ChillerEnergyEfficiencyPage : System.Web.UI.Page
    {
        private EquipmentEnergyBC _bc = new EquipmentEnergyBC();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Initialize();
            }
        }

        private void Initialize()
        {
            //绑定数据源
            ChillerEnergyEfficiencyDS ds = _bc.GetChillerEnergyEfficiency();
            gvDept.DataSource = ds.ChillerEnergyEfficiency;
            gvDept.DataBind();
            //显示Chart图
            DataTable table = _bc.CreateChillerEnergyEfficiencyTable(ds);
            //Series - 0
            ecpChart.Series["Actual VS Nominal COP"].ChartType = System.Web.UI.DataVisualization.Charting.SeriesChartType.Column;
            ecpChart.Series["Actual VS Nominal COP"]["PointWidth"] = "0.8";
            ecpChart.Series["Actual VS Nominal COP"]["BarLabelStyle"] = "Center";
            ecpChart.Series["Actual VS Nominal COP"]["DrawingStyle"] = "Cylinder";
            ecpChart.Series["Actual VS Nominal COP"].IsValueShownAsLabel = false;//显示坐标值
            ecpChart.Series["Actual VS Nominal COP"].ToolTip = "#VALX:#VALY";
            //Series - 1
            ecpChart.Series["BaseLine"].ChartType = System.Web.UI.DataVisualization.Charting.SeriesChartType.Line;
            ecpChart.Series["BaseLine"]["PointWidth"] = "2";
            ecpChart.Series["BaseLine"]["BarLabelStyle"] = "Center";
            ecpChart.Series["BaseLine"]["DrawingStyle"] = "Cylinder";
            ecpChart.Series["BaseLine"].IsValueShownAsLabel = false;//显示坐标值
            //
            ecpChart.ChartAreas["ecpChartArea"].AxisY.Maximum = 1.2;
            ecpChart.ChartAreas["ecpChartArea"].AxisY.Minimum = 0;
            ecpChart.ChartAreas["ecpChartArea"].AxisY.Interval = 0.2;
            ecpChart.ChartAreas["ecpChartArea"].AxisY.LabelStyle.ForeColor = Color.FromArgb(146, 208, 79);
            ecpChart.ChartAreas["ecpChartArea"].AxisY.LabelStyle.Font = new Font("Microsoft Sans Serif", 12, FontStyle.Bold);
            ecpChart.ChartAreas["ecpChartArea"].AxisY.IsMarginVisible = true;
            ecpChart.ChartAreas["ecpChartArea"].AxisY.TextOrientation = System.Web.UI.DataVisualization.Charting.TextOrientation.Horizontal;
            ecpChart.ChartAreas["ecpChartArea"].AxisY.MajorTickMark.TickMarkStyle = System.Web.UI.DataVisualization.Charting.TickMarkStyle.None;
            ecpChart.ChartAreas["ecpChartArea"].AxisX.LabelStyle.ForeColor = Color.FromArgb(146, 208, 79);
            ecpChart.ChartAreas["ecpChartArea"].AxisX.LabelStyle.Font = new Font("Microsoft Sans Serif", 12);
            ecpChart.ChartAreas["ecpChartArea"].AxisX.TextOrientation = System.Web.UI.DataVisualization.Charting.TextOrientation.Horizontal;
            ecpChart.ChartAreas["ecpChartArea"].AxisX.MajorGrid.Enabled = false;//不显示竖着的分割线
            ecpChart.ChartAreas["ecpChartArea"].AxisX.MajorTickMark.Enabled = false;
            for (int i = 0; i < table.Rows.Count; i++)
            {
                double value1 = Convert.ToDouble(table.Rows[i]["Total"]);
                double value2 = Convert.ToDouble(table.Rows[i]["BaseLine"]);
                ecpChart.Series["Actual VS Nominal COP"].Points.AddXY(table.Rows[i]["Name"] as string, value1);
                ecpChart.Series["BaseLine"].Points.AddXY(table.Rows[i]["Name"] as string, value2);
                if (value1 >= 1)
                {
                    ecpChart.Series["Actual VS Nominal COP"].Points[i].Color = Color.FromArgb(0, 176, 80);
                }
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
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}