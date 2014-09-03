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
}