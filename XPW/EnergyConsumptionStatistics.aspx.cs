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
    public partial class EnergyConsumptionStatistics : System.Web.UI.Page
    {
        private EquipmentEnergyBC _energyBC = new EquipmentEnergyBC();
        private ElectricityConsumptionBC _bc = new ElectricityConsumptionBC();
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    InitializeElectricity();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected void dlSite_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                if (dlSite.SelectedIndex == 0)
                {
                    dvEnergy.Visible = false;

                    dvBody.Style.Clear();
                    dvBody.Style.Add("overflow", "auto");
                    dvBody.Style.Add("width", "1118px");
                    if (rblEnergy.SelectedValue == "0")
                    {
                        dvBody.Style.Add("height", "490px");
                        ElectricityConsumptionDS ds = _bc.GetAllEquipmentElectricity();
                        gvDept.DataSource = ds.ElectricityConsumption;
                        gvDept.DataBind();
                    }
                    else if (rblEnergy.SelectedValue == "1")
                    {
                        dvBody.Style.Add("height", "225px");
                        ElectricityConsumptionDS ds = _bc.GetAllEquipmentWater();
                        gvDept.DataSource = ds.ElectricityConsumption;
                        gvDept.DataBind();
                    }
                    else if (rblEnergy.SelectedValue == "2")
                    {
                        dvBody.Style.Add("height", "225px");
                        ElectricityConsumptionDS ds = _bc.GetAllEquipmentN2();
                        gvDept.DataSource = ds.ElectricityConsumption;
                        gvDept.DataBind();
                    }
                    ViewState["EquipmentEnergyEfficiencyDS"] = null;
                }
                else
                {
                    dvEnergy.Visible = true;
                    dvBody.Style.Clear();
                    dvBody.Style.Add("overflow", "auto");
                    dvBody.Style.Add("width", "1118px");
                    dvBody.Style.Add("height", "125px");

                    string name = dlSite.SelectedItem.Text;
                    ElectricityConsumptionDS ds = null;
                    if (rblEnergy.SelectedValue == "0")
                    {
                        int deviceID = Convert.ToInt32(dlSite.SelectedValue);
                        ds = _bc.GetEquipmentElectricity(deviceID);
                        gvDept.DataSource = ds.ElectricityConsumption;
                        gvDept.DataBind();
                    }
                    else if (rblEnergy.SelectedValue == "1")
                    {
                        ds = _bc.GetEquipmentWater(name, dlSite.SelectedValue);
                        gvDept.DataSource = ds.ElectricityConsumption;
                        gvDept.DataBind();
                    }
                    else if (rblEnergy.SelectedValue == "2")
                    {
                        ds = _bc.GetEquipmentN2(name, dlSite.SelectedValue);
                        gvDept.DataSource = ds.ElectricityConsumption;
                        gvDept.DataBind();
                    }

                    lblTitle.Text = string.Format("{0} - Dept. Equipment Efficiency", name);
                    if (ds.ElectricityConsumption.Rows.Count > 0)
                    {
                        //绑定数据
                        EquipmentEnergyEfficiencyDS energyDS = _energyBC.GetEquipmentEnergyEfficiencyEx(
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
                        gvDept1.DataSource = energyDS.EquipmentEnergyEfficiency;
                        gvDept1.DataBind();
                        //显示Chart图
                        DataTable table = _energyBC.CreateEquipmentEnergyEfficiencyTable(energyDS);
                        ecpChart.Titles["ecpTitle"].Text = lblTitle.Text;
                        //Efficiency
                        ecpChart.Series["Efficiency"].ChartType = System.Web.UI.DataVisualization.Charting.SeriesChartType.Column;
                        ecpChart.Series["Efficiency"]["PointWidth"] = "0.8";
                        ecpChart.Series["Efficiency"]["BarLabelStyle"] = "Center";
                        ecpChart.Series["Efficiency"]["DrawingStyle"] = "Cylinder";
                        ecpChart.Series["Efficiency"].IsValueShownAsLabel = false;//显示坐标值
                        ecpChart.Series["Efficiency"].ToolTip = "#VALX:#VALY";
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
                    if (rblEnergy.SelectedValue == "0"
                        && e.Row.RowIndex == 11)
                    {
                        ImageButton imageBtn = e.Row.Cells[18].FindControl("btnGraph") as ImageButton;
                        if (imageBtn != null)
                        {
                            e.Row.Cells[18].Controls.Remove(imageBtn);
                        }
                    }
                    if (rblEnergy.SelectedValue == "1"
                       && e.Row.RowIndex == 3)
                    {
                        ImageButton imageBtn = e.Row.Cells[17].FindControl("btnGraph") as ImageButton;
                        if (imageBtn != null)
                        {
                            e.Row.Cells[18].Controls.Remove(imageBtn);
                        }
                    }
                    if (rblEnergy.SelectedValue == "2"
                       && e.Row.RowIndex == 3)
                    {
                        ImageButton imageBtn = e.Row.Cells[18].FindControl("btnGraph") as ImageButton;
                        if (imageBtn != null)
                        {
                            e.Row.Cells[18].Controls.Remove(imageBtn);
                        }
                    }
                }
                if (e.Row.RowType == DataControlRowType.Header)
                {
                    System.Globalization.GregorianCalendar gc = new System.Globalization.GregorianCalendar();
                    int weekOfYear = gc.GetWeekOfYear(DateTime.Now, System.Globalization.CalendarWeekRule.FirstDay, DayOfWeek.Monday);
                    string[] strs = Common.GetQuarters();
                    e.Row.Cells[2].Text = "Y" + (DateTime.Now.Year - 1).ToString();
                    e.Row.Cells[3].Text = "Y" + (DateTime.Now.Year).ToString() + " Target";
                    e.Row.Cells[4].Text = "Y" + (DateTime.Now.Year).ToString() + " YTD";
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
        protected void gvDept_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                if (e.CommandName == "Graph")
                {
                    string[] args = (e.CommandArgument as string).Split(';');
                    string url = "EquipmentEnergyEfficiencyPage.aspx?" + "type=" + rblEnergy.SelectedValue + "&name=" + args[0] + "&ids=" + args[1];
                    Response.Redirect(url);
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
                if (e.Row.RowType == DataControlRowType.Header)
                {
                    string style = "padding: 4px 2px;"
                    + " color: #fff;"
                    + " background: #424242 url(grd_head.png) repeat-x top;"
                    + "border-left: solid 1px #525252;"
                    + "font-size: 14px;"
                    + "text-align: left;";
                    e.Row.Cells[1].Attributes.Remove("style");
                    e.Row.Cells[1].Attributes.Add("style", style);
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
                    e.Row.Cells[1].Attributes.Remove("style");
                    e.Row.Cells[1].Attributes.Add("style", style);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        private void InitializeElectricity()
        {
            dvEnergy.Visible = false;
            dlSite.Items.Clear();
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
        private void InitializeWater()
        {
            dvEnergy.Visible = false;
            dlSite.Items.Clear();
            dlSite.Items.AddRange(new ListItem[] {
                    new ListItem("ALL","-1"),
                    new ListItem("Admin","310,311,312,370,374,377,380,381"),
                    new ListItem("FAC","356,375,380,381,384"),
                    new ListItem("MFG","354,362,376,378,379,386,387")
                });
            ElectricityConsumptionDS ds = _bc.GetAllEquipmentWater();
            gvDept.DataSource = ds.ElectricityConsumption;
            gvDept.DataBind();
        }
        private void InitializeN2()
        {
            dvEnergy.Visible = false;
            dlSite.Items.Clear();
            dlSite.Items.AddRange(new ListItem[] {
                    new ListItem("ALL","-1"),
                    new ListItem("BOP","366"),
                    new ListItem("FOP","367"),
                    new ListItem("KGD","368")
                });
            ElectricityConsumptionDS ds = _bc.GetAllEquipmentN2();
            gvDept.DataSource = ds.ElectricityConsumption;
            gvDept.DataBind();
        }
        protected void rblEnergy_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                dvBody.Style.Clear();
                dvBody.Style.Add("overflow", "auto");
                dvBody.Style.Add("width", "1118px");
                if (rblEnergy.SelectedValue == "0")
                {
                    dvBody.Style.Add("height", "490px");
                    InitializeElectricity();
                }
                else if (rblEnergy.SelectedValue == "1")
                {
                    dvBody.Style.Add("height", "225px");
                    InitializeWater();
                }
                else if (rblEnergy.SelectedValue == "2")
                {
                    dvBody.Style.Add("height", "225px");
                    InitializeN2();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected void gvDept1_RowCreated(object sender, GridViewRowEventArgs e)
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

        protected void gvDept1_RowDataBound(object sender, GridViewRowEventArgs e)
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
                        case 2:
                        case 3:
                            {
                                for (int i = 1; i < e.Row.Cells.Count; i++)
                                {
                                    double value = Convert.ToDouble(e.Row.Cells[i].Text);
                                    if (value >= 1000)
                                    {
                                        e.Row.Cells[i].Text = string.Format("{0:N0}", value);
                                    }
                                }
                            }
                            break;
                        case 4://第4行
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