using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using XPW.BE;
using XPW.DA;

namespace XPW.BC
{
    public class EquipmentEnergyBC
    {
        /// <summary>
        /// 获得EquipmentEnergyEfficiency,参数从ElectricityConsumptionPage每一行传过来
        /// </summary>
        /// <returns></returns>
        public EquipmentEnergyEfficiencyDS GetEquipmentEnergyEfficiency(int DeviceID,
            double PreviousYear,
            double YTD,
            double Q1,
            double Q2,
            double Q3,
            double Q4,
            double Month1,
            double Month2,
            double Month3,
            double Week1,
            double Week2,
            double Week3,
            double Week4,
            double Week5,
            double Week6
            )
        {
            try
            {
                EquipmentEnergyEfficiencyDS ds = new EquipmentEnergyEfficiencyDS();
                SqlDBAccess.Instance.Fill(ds.EquipmentEnergyEfficiency, "GetEquipmentEnergyEfficiency", new object[]{
                    DeviceID,
                    PreviousYear,
                    YTD,
                    Q1,
                    Q2,
                    Q3,
                    Q4,
                    Month1,
                    Month2,
                    Month3,
                    Week1,
                    Week2,
                    Week3,
                    Week4,
                    Week5,
                    Week6
                });
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        /// <summary>
        /// 获得ChillerEnergyEfficiency
        /// </summary>
        /// <returns></returns>
        public ChillerEnergyEfficiencyDS GetChillerEnergyEfficiency()
        {
            try
            {
                ChillerEnergyEfficiencyDS ds = new ChillerEnergyEfficiencyDS();
                SqlDBAccess.Instance.Fill(ds.ChillerEnergyEfficiency, "GetChillerEnergyEfficiency", null);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public DataTable CreateChillerEnergyEfficiencyTable(ChillerEnergyEfficiencyDS ds)
        {
            try
            {
                //倒数第二个
                ChillerEnergyEfficiencyDS.ChillerEnergyEfficiencyRow row = ds.ChillerEnergyEfficiency[ds.ChillerEnergyEfficiency.Rows.Count - 2];
                DataTable table = new DataTable();
                table.Columns.Add("Total", typeof(double));
                table.Columns.Add("Name", typeof(string));
                table.Columns.Add("BaseLine", typeof(double));
                ////Chiller 1#
                //DataRow newRow1 = table.NewRow();
                //newRow1[0] = 0.3;
                //newRow1[1] = "Chiller 1#";
                //newRow1[2] = 1;
                //table.Rows.Add(newRow1);
                ////Chiller 2#
                //DataRow newRow2 = table.NewRow();
                //newRow2[0] = 1.1;
                //newRow2[1] = "Chiller 2#";
                //newRow2[2] = 1;
                //table.Rows.Add(newRow2);
                ////Chiller 3#
                //DataRow newRow3 = table.NewRow();
                //newRow3[0] = 1.0;
                //newRow3[1] = "Chiller 3#";
                //newRow3[2] = 1;
                //table.Rows.Add(newRow3);
                ////Chiller 4#
                //DataRow newRow4 = table.NewRow();
                //newRow4[0] = 0.6;
                //newRow4[1] = "Chiller 4#";
                //newRow4[2] = 1;
                //table.Rows.Add(newRow4);
                ////Chiller 5#
                //DataRow newRow5 = table.NewRow();
                //newRow5[0] = 0.87;
                //newRow5[1] = "Chiller 5#";
                //newRow5[2] = 1;
                //table.Rows.Add(newRow5);
                //Chiller 1#
                DataRow newRow1 = table.NewRow();
                newRow1[0] = row.Chiller1;
                newRow1[1] = "Chiller 1#";
                newRow1[2] = 1;
                table.Rows.Add(newRow1);
                //Chiller 2#
                DataRow newRow2 = table.NewRow();
                newRow2[0] = row.Chiller2;
                newRow2[1] = "Chiller 2#";
                newRow2[2] = 1;
                table.Rows.Add(newRow2);
                //Chiller 3#
                DataRow newRow3 = table.NewRow();
                newRow3[0] = row.Chiller3;
                newRow3[1] = "Chiller 3#";
                newRow3[2] = 1;
                table.Rows.Add(newRow3);
                //Chiller 4#
                DataRow newRow4 = table.NewRow();
                newRow4[0] = row.Chiller4;
                newRow4[1] = "Chiller 4#";
                newRow4[2] = 1;
                table.Rows.Add(newRow4);
                //Chiller 5#
                DataRow newRow5 = table.NewRow();
                newRow5[0] = row.Chiller5;
                newRow5[1] = "Chiller 5#";
                newRow5[2] = 1;
                table.Rows.Add(newRow5);

                return table;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public DataTable CreateEquipmentEnergyEfficiencyTable(EquipmentEnergyEfficiencyDS ds)
        {
            //最后一行
            EquipmentEnergyEfficiencyDS.EquipmentEnergyEfficiencyRow efficiencyRow = ds.EquipmentEnergyEfficiency[ds.EquipmentEnergyEfficiency.Rows.Count - 1];
            DataTable table = new DataTable();
            table.Columns.Add("Total", typeof(double));
            table.Columns.Add("Name", typeof(string));
            table.Columns.Add("BaseLine", typeof(double));
            //PreviousYear
            DataRow newRow1 = table.NewRow();
            newRow1[0] = efficiencyRow.PreviousYear;
            newRow1[1] = "Previous Year";
            newRow1[2] = 1.0;
            table.Rows.Add(newRow1);
            //YTD
            DataRow newRow2 = table.NewRow();
            newRow2[0] = efficiencyRow.YTD;
            newRow2[1] = "YTD";
            newRow2[2] = 1.0;
            table.Rows.Add(newRow2);
            //Q1
            DataRow newRow3 = table.NewRow();
            newRow3[0] = efficiencyRow.Q1;
            newRow3[1] = "Q1";
            newRow3[2] = 1.0;
            table.Rows.Add(newRow3);
            //Q2
            DataRow newRow4 = table.NewRow();
            newRow4[0] = efficiencyRow.Q2;
            newRow4[1] = "Q2";
            newRow4[2] = 1.0;
            table.Rows.Add(newRow4);
            //Q3
            DataRow newRow5 = table.NewRow();
            newRow5[0] = efficiencyRow.Q3;
            newRow5[1] = "Q3";
            newRow5[2] = 1.0;
            table.Rows.Add(newRow5);
            //Q4
            DataRow newRow6 = table.NewRow();
            newRow6[0] = efficiencyRow.Q4;
            newRow6[1] = "Q4";
            newRow6[2] = 1.0;
            table.Rows.Add(newRow6);
            string[] strs = Common.GetQuarters();
            //Month1
            DataRow newRow7 = table.NewRow();
            newRow7[0] = efficiencyRow.Month1;
            newRow7[1] = strs[0];
            newRow7[2] = 1.0;
            table.Rows.Add(newRow7);
            //Month2
            DataRow newRow8 = table.NewRow();
            newRow8[0] = efficiencyRow.Month2;
            newRow8[1] = strs[1];
            newRow8[2] = 1.0;
            table.Rows.Add(newRow8);
            //Month3
            DataRow newRow9 = table.NewRow();
            newRow9[0] = efficiencyRow.Month3;
            newRow9[1] = strs[2];
            newRow9[2] = 1.0;
            table.Rows.Add(newRow9);
            //Week1
            DataRow newRow10 = table.NewRow();
            newRow10[0] = efficiencyRow.Week1;
            newRow10[1] = "Week-1";
            newRow10[2] = 1.0;
            table.Rows.Add(newRow10);
            //Week2
            DataRow newRow11 = table.NewRow();
            newRow11[0] = efficiencyRow.Week2;
            newRow11[1] = "Week-2";
            newRow11[2] = 1.0;
            table.Rows.Add(newRow11);
            //Week3
            DataRow newRow12 = table.NewRow();
            newRow12[0] = efficiencyRow.Week3;
            newRow12[1] = "Week-3";
            newRow12[2] = 1.0;
            table.Rows.Add(newRow12);
            //Week4
            DataRow newRow13 = table.NewRow();
            newRow13[0] = efficiencyRow.Week3;
            newRow13[1] = "Week-4";
            newRow13[2] = 1.0;
            table.Rows.Add(newRow13);

            return table;
        }
    }
}
