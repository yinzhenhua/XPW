using System;
using System.Drawing;
using System.Globalization;
using System.Web.UI.DataVisualization.Charting;
using System.Web.UI.WebControls;
using XPW.BC;

namespace XPW
{
    public partial class DashboardPage : XPWPageBase
    {
        readonly DashboardBC _bc = new DashboardBC();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                ShowEnergyWaste(388);
                LoadEnergy();
            }
        }

        /// <summary>
        /// 获取Co2信息
        /// </summary>
        public int Co2
        {
            get
            {
                return (int)(_bc.GetCO2Year() * 0.001);
            }
        }

        /// <summary>
        /// 获取对应的Tree信息
        /// </summary>
        public int Trees
        {
            get
            {
                return (int)(_bc.GetCO2Year() / 111);
            }
        }

        public int MonthCo2
        {
            get { return Convert.ToInt32(_bc.GetCO2Mouth() * 0.001); }
        }

        public int MonthTrees
        {
            get { return (int)(_bc.GetCO2Mouth() / 111); }
        }
        /// <summary>
        /// 点击水、电、煤链接，加载相应的数据
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void OnLinkClick(object sender, EventArgs e)
        {
            var linkButton = sender as LinkButton;
            if (linkButton == null) return;
            var argument = Convert.ToInt32(linkButton.CommandArgument);
            ShowEnergyWaste(argument);
        }

        /// <summary>
        /// 显示点击选中的柱状图
        /// </summary>
        /// <param name="deviceId"></param>
        protected void ShowEnergyWaste(int deviceId)
        {
            var ytd = _bc.GetUtilities(deviceId);// 获取今年的水、电、煤
            var previousTarget = _bc.GetUtilitiesPrev(deviceId);//获取往年的水、电、煤
            var yearsTarget = _bc.GetUtilities(413);

            // 显示绘图区域
            DrawChart(new object[] { "Previous Year", "Yearly Target", "YTD" }, new[] { previousTarget, yearsTarget, ytd }, deviceId);
        }

        /// <summary>
        /// 将数据绘制到chart中
        /// </summary>
        /// <param name="xvalues"></param>
        /// <param name="yvalues"></param>
        /// <param name="deviceId"></param>
        protected void DrawChart(object[] xvalues, double[] yvalues, int deviceId)
        {
            chartEnerge.Series.Clear();
            // 绑定图表数据区域
            var series = CreateSeries();
            series.Points.DataBindXY(xvalues, yvalues);

            for (var i = 0; i < xvalues.Length; i++)
            {
                series.Points[i].Color = ColorSupplyer.GenColor();
                series.Points[i].PostBackValue = string.Format("{0}_{1}", deviceId.ToString(CultureInfo.InvariantCulture), (int)ChartDataType.Year);
            }
            chartEnerge.Series.Add(series);
        }

        /// <summary>
        /// 绘制月度数据
        /// </summary>
        /// <param name="deviceId"></param>
        /// <param name="dtype"></param>
        protected void DrawMonthChart(int deviceId, ChartDataType dtype)
        {
            chartEnerge.Series.Clear();
            // 绑定图表数据区域
            var series = CreateSeries();
            var dt = _bc.GetUtilitiesMonths(deviceId);
            var rowCount = dt.Rows.Count;
            var xvalues = new string[rowCount];
            var yvalues = new double[rowCount];
            for (var i = 0; i < rowCount; i++)
            {
                xvalues[i] = (i + 1).ToString(CultureInfo.InvariantCulture);
                yvalues[i] = Convert.ToDouble(dt.Rows[i][0]);
            }
            series.Points.DataBindXY(xvalues, yvalues);
            for (var i = 0; i < rowCount; i++)
            {
                series.Points[i].Color = ColorSupplyer.GenColor();
                series.Points[i].PostBackValue = string.Format("{0}_{1}_{2}",
                    deviceId.ToString(CultureInfo.InvariantCulture), (int)dtype, xvalues[i]);
            }

            chartEnerge.Series.Add(series);
        }
        /// <summary>
        /// 绘制指定月份的数据
        /// </summary>
        /// <param name="deviceId"></param>
        /// <param name="month"></param>
        protected void DrawDayChart(int deviceId, int month)
        {
            chartEnerge.Series.Clear();
            var series = CreateSeries();
            series.ChartType = SeriesChartType.Stock;
            series.IsValueShownAsLabel = false;
            var dt = _bc.GetUtilitiesDays(deviceId, month);
            var rowCount = dt.Rows.Count;
            var xvalues = new string[rowCount];
            var yvalues = new double[rowCount];
            for (var i = 0; i < rowCount; i++)
            {
                xvalues[i] = (i + 1).ToString(CultureInfo.InvariantCulture);
                yvalues[i] = Convert.ToDouble(dt.Rows[i][0]);
            }
            series.Points.DataBindXY(xvalues, yvalues);
            for (var i = 0; i < rowCount; i++)
            {
                series.Points[i].Color = ColorSupplyer.GenColor();
                series.Points[i].PostBackValue = string.Format("{0}_{1}_{2}_{3}",
                    deviceId.ToString(CultureInfo.InvariantCulture), (int)ChartDataType.Day, month, xvalues[i]);
            }

            chartEnerge.Series.Add(series);
        }
        /// <summary>
        /// 绘制指定日期的24小时数据
        /// </summary>
        /// <param name="deviceId"></param>
        /// <param name="month"></param>
        /// <param name="day"></param>
        protected void DrawHourChart(int deviceId, int month, int day)
        {
            chartEnerge.Series.Clear();
            var series = CreateSeries();
            series.ChartType = SeriesChartType.Stock;
            series.IsValueShownAsLabel = false;
            var dt = _bc.GetUtilitiesHours(deviceId, month, day);
            var rowCount = dt.Rows.Count;
            var xvalues = new string[rowCount];
            var yvalues = new double[rowCount];
            for (var i = 0; i < rowCount; i++)
            {
                xvalues[i] = (i + 1).ToString(CultureInfo.InvariantCulture);
                yvalues[i] = Convert.ToDouble(dt.Rows[i][0]);
            }
            series.Points.DataBindXY(xvalues, yvalues);
            for (var i = 0; i < rowCount; i++)
            {
                series.Points[i].Color = ColorSupplyer.GenColor();
                series.Points[i].PostBackValue = string.Format("{0}_{1}_{2}",
                    deviceId.ToString(CultureInfo.InvariantCulture), (int)ChartDataType.Minute, xvalues[i]);
            }

            chartEnerge.Series.Add(series);
        }

        /// <summary>
        /// 创建绘图区域
        /// </summary>
        /// <returns></returns>
        protected Series CreateSeries()
        {
            var series = new Series("Spline") { ChartType = SeriesChartType.Column };
            series["PointWidth"] = "1.0";
            series["BarLabelStyle"] = "Center";
            series["DrawingStyle"] = "Cylinder";
            series.BorderWidth = 3;
            series.ShadowOffset = 2;
            series.IsValueShownAsLabel = false;
            series.ToolTip = "#VALX:#VALY";
            series.Font = new Font("宋体", 8.0f);


            return series;
        }

        protected void OnChartClick(object sender, ImageMapEventArgs e)
        {
            var argument = e.PostBackValue;
            if (string.IsNullOrEmpty(argument))
            { return; }

            var deviceId = Convert.ToInt32(argument.Split('_')[0]);
            var dType = (ChartDataType)Convert.ToInt32(argument.Split('_')[1]);

            switch (dType)
            {
                case ChartDataType.Year:
                    DrawMonthChart(deviceId, ChartDataType.Month);
                    break;
                case ChartDataType.Month:
                    DrawDayChart(deviceId, Convert.ToInt32(argument.Split('_')[2]));
                    break;
                case ChartDataType.Day:
                    DrawHourChart(deviceId, Convert.ToInt32(argument.Split('_')[2]), Convert.ToInt32(argument.Split('_')[3]));
                    break;
                default:
                    ShowEnergyWaste(deviceId);
                    break;
            }
        }

        protected void LoadEnergy()
        {
            var electricity = _bc.GetUtilitiesEnergy(388);
            lbl_Energy_today.Text = electricity.Rows[0][0].ToString();
            lbl_Energy_cost_today.Text = Convert.ToInt32((Convert.ToDouble(electricity.Rows[0][0]) * 0.7463)).ToString(CultureInfo.InvariantCulture);
            lbl_Energy_wtd.Text = electricity.Rows[0][1].ToString();
            lbl_Energy_cost_wtd.Text = Convert.ToInt32((Convert.ToDouble(electricity.Rows[0][1]) * 0.7463)).ToString(CultureInfo.InvariantCulture);
            lbl_Energy_mtd.Text = electricity.Rows[0][2].ToString();
            lbl_Energy_cost_mtd.Text = Convert.ToInt32((Convert.ToDouble(electricity.Rows[0][2]) * 0.7463)).ToString(CultureInfo.InvariantCulture);
            lbl_Energy_ytd.Text = electricity.Rows[0][3].ToString();
            lbl_Energy_cost_ytd.Text = Convert.ToInt32((Convert.ToDouble(electricity.Rows[0][3]) * 0.7463)).ToString(CultureInfo.InvariantCulture);

            var water = _bc.GetUtilitiesEnergy(373);
            lbl_water_today.Text = water.Rows[0][0].ToString();
            lbl_water_cost_today.Text = Convert.ToInt32((Convert.ToDouble(water.Rows[0][0]) * 4.996)).ToString(CultureInfo.InvariantCulture);
            lbl_water_wtd.Text = water.Rows[0][1].ToString();
            lbl_water_cost_wtd.Text = Convert.ToInt32((Convert.ToDouble(water.Rows[0][1]) * 4.996)).ToString(CultureInfo.InvariantCulture);
            lbl_water_mtd.Text = water.Rows[0][2].ToString();
            lbl_water_cost_mtd.Text = Convert.ToInt32((Convert.ToDouble(water.Rows[0][2]) * 4.996)).ToString(CultureInfo.InvariantCulture);
            lbl_water_ytd.Text = water.Rows[0][3].ToString();
            lbl_water_cost_ytd.Text = Convert.ToInt32((Convert.ToDouble(water.Rows[0][3]) * 4.996)).ToString(CultureInfo.InvariantCulture);

            var gas = _bc.GetUtilitiesEnergy(358);
            lbl_gas_today.Text = gas.Rows[0][0].ToString();
            lbl_gas_cost_today.Text = Convert.ToInt32((Convert.ToDouble(gas.Rows[0][0]) * 2)).ToString(CultureInfo.InvariantCulture);
            lbl_gas_wtd.Text = gas.Rows[0][1].ToString();
            lbl_gas_cost_wtd.Text = Convert.ToInt32((Convert.ToDouble(gas.Rows[0][1]) * 2)).ToString(CultureInfo.InvariantCulture);
            lbl_gas_mtd.Text = gas.Rows[0][2].ToString();
            lbl_gas_cost_mtd.Text = Convert.ToInt32((Convert.ToDouble(gas.Rows[0][2]) * 2)).ToString(CultureInfo.InvariantCulture);
            lbl_gas_ytd.Text = gas.Rows[0][3].ToString();
            lbl_gas_cost_ytd.Text = Convert.ToInt32((Convert.ToDouble(gas.Rows[0][3]) * 2)).ToString(CultureInfo.InvariantCulture);

            var ln = _bc.GetUtilitiesEnergy(361);
            lbl_ln_today.Text = ln.Rows[0][0].ToString();
            lbl_ln_cost_today.Text = Convert.ToInt32((Convert.ToDouble(ln.Rows[0][0]) * 5)).ToString(CultureInfo.InvariantCulture);
            lbl_ln_wtd.Text = ln.Rows[0][1].ToString();
            lbl_ln_cost_wtd.Text = Convert.ToInt32((Convert.ToDouble(ln.Rows[0][1]) * 5)).ToString(CultureInfo.InvariantCulture);
            lbl_ln_mtd.Text = ln.Rows[0][2].ToString();
            lbl_ln_cost_mtd.Text = Convert.ToInt32((Convert.ToDouble(ln.Rows[0][2]) * 5)).ToString(CultureInfo.InvariantCulture);
            lbl_ln_ytd.Text = ln.Rows[0][3].ToString();
            lbl_ln_cost_ytd.Text = Convert.ToInt32((Convert.ToDouble(ln.Rows[0][3]) * 5)).ToString(CultureInfo.InvariantCulture);

        }
    }
}