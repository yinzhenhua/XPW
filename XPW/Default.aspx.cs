using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace XPW
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DataTable dt = CreatData();

            #region 折线图
            Chart1.DataSource = dt;//绑定数据
            Chart1.Series["Series1"].ChartType = System.Web.UI.DataVisualization.Charting.SeriesChartType.Column;//设置图表类型
            Chart1.Series[0].XValueMember = "Language";//X轴数据成员列
            Chart1.Series[0].YValueMembers = "Count";//Y轴数据成员列
            Chart1.ChartAreas["ChartArea1"].AxisX.Title = "语言";//X轴标题
            Chart1.ChartAreas["ChartArea1"].AxisX.TitleAlignment = StringAlignment.Far;//设置Y轴标题的名称所在位置位远
            Chart1.ChartAreas["ChartArea1"].AxisY.Title = "统计";//X轴标题
            Chart1.ChartAreas["ChartArea1"].AxisY.TitleAlignment = StringAlignment.Far;//设置Y轴标题的名称所在位置位远
            Chart1.ChartAreas["ChartArea1"].AxisX.Interval = 1;//X轴数据的间距
            Chart1.ChartAreas["ChartArea1"].AxisX.MajorGrid.Enabled = false;//不显示竖着的分割线
            Chart1.Series[0].IsValueShownAsLabel = true;//显示坐标值
            #endregion
        }

        /// <summary>
        /// 创建一张二维数据表
        /// </summary>
        /// <returns>Datatable类型的数据表</returns>
        DataTable CreatData()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("Language", System.Type.GetType("System.String"));
            dt.Columns.Add("Count", System.Type.GetType("System.Double"));

            string[] n = new string[] { "C#", "Java", "Object-C", "C", "C++", "VB" };
            double[] c = new double[] { 10000000, 20000000, 30000000, 40000000, 50000000, 60000000 };

            for (int i = 0; i < 6; i++)
            {
                DataRow dr = dt.NewRow();
                dr["Language"] = n[i];
                dr["Count"] = c[i];
                dt.Rows.Add(dr);
            }
            return dt;
        }
    }
}