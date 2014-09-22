using Microsoft.Practices.EnterpriseLibrary.Logging;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using XPW.BE;
using XPW.DA;

namespace XPW.BC
{
    /// <summary>
    /// Dept. Electricity Consumption Statistics业务
    /// </summary>
    public class ElectricityConsumptionBC
    {
        /// <summary>
        /// 获得所有部门的能源明细
        /// </summary>
        /// <returns></returns>
        public ElectricityConsumptionDS GetAllEquipmentEnergy()
        {
            try
            {
                ElectricityConsumptionDS ds = new ElectricityConsumptionDS();
                SqlDBAccess.Instance.Fill(ds.ElectricityConsumption, "GetAllEquipmentEnergy", null);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        /// <summary>
        /// 获得特定部门的能源明细
        /// </summary>
        /// <param name="deviceID"></param>
        /// <returns></returns>
        public ElectricityConsumptionDS GetEquipmentEnergy(int deviceID)
        {
            try
            {
                int deviceID1 = Common.GetYearlyTargetID(deviceID);
                ElectricityConsumptionDS ds = new ElectricityConsumptionDS();
                SqlDBAccess.Instance.Fill(ds.ElectricityConsumption, "GetEquipmentEnergy", new object[] { deviceID, deviceID1 });
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        /// <summary>
        /// 获得Electricity的明细
        /// </summary>
        /// <returns></returns>
        public ElectricityConsumptionDS GetAllEquipmentElectricity()
        {
            try
            {
                ElectricityConsumptionDS ds = new ElectricityConsumptionDS();
                SqlDBAccess.Instance.Fill(ds.ElectricityConsumption, "GetAllEquipmentElectricity", null);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        /// <summary>
        /// 获得特定部门的能源明细
        /// </summary>
        /// <param name="deviceID"></param>
        /// <returns></returns>
        public ElectricityConsumptionDS GetEquipmentElectricity(int deviceID)
        {
            try
            {
                int deviceID1 = Common.GetYearlyTargetID(deviceID);
                ElectricityConsumptionDS ds = new ElectricityConsumptionDS();
                SqlDBAccess.Instance.Fill(ds.ElectricityConsumption, "GetEquipmentElectricity", new object[] { deviceID, deviceID1 });
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        /// <summary>
        /// 获得Water的明细
        /// </summary>
        /// <returns></returns>
        public ElectricityConsumptionDS GetAllEquipmentWater()
        {
            try
            {
                ElectricityConsumptionDS ds = new ElectricityConsumptionDS();
                SqlDBAccess.Instance.Fill(ds.ElectricityConsumption, "GetAllEquipmentWater", null);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        /// <summary>
        /// 获得指定Water的明细
        /// </summary>
        /// <returns></returns>
        public ElectricityConsumptionDS GetEquipmentWater(string name, string ids)
        {
            try
            {
                ElectricityConsumptionDS ds = new ElectricityConsumptionDS();
                SqlDBAccess.Instance.Fill(ds.ElectricityConsumption, "GetEquipmentWater", new object[] { name, ids });
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        /// <summary>
        /// 获得N2的明细
        /// </summary>
        /// <returns></returns>
        public ElectricityConsumptionDS GetAllEquipmentN2()
        {
            try
            {
                ElectricityConsumptionDS ds = new ElectricityConsumptionDS();
                SqlDBAccess.Instance.Fill(ds.ElectricityConsumption, "GetAllEquipmentN2", null);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        /// <summary>
        /// 获得指定N2的明细
        /// </summary>
        /// <returns></returns>
        public ElectricityConsumptionDS GetEquipmentN2(string name, string ids)
        {
            try
            {
                ElectricityConsumptionDS ds = new ElectricityConsumptionDS();
                SqlDBAccess.Instance.Fill(ds.ElectricityConsumption, "GetEquipmentN2", new object[] { name, ids });
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        /// <summary>
        /// 创件EquipmentEnergy
        /// </summary>
        /// <returns></returns>
        public DataTable CreateEquipmentEnergyTable(ElectricityConsumptionDS ds)
        {
            DataTable table = new DataTable();
            table.Columns.Add("Total", typeof(double));
            table.Columns.Add("Name", typeof(string));
            //PreviousYear
            DataRow newRow1 = table.NewRow();
            newRow1[0] = ds.ElectricityConsumption[0].PreviousYear;
            newRow1[1] = "Previous Year";
            table.Rows.Add(newRow1);
            //YearlyTarget
            DataRow newRow2 = table.NewRow();
            newRow2[0] = ds.ElectricityConsumption[0].YearlyTarget;
            newRow2[1] = "Yearly Target";
            table.Rows.Add(newRow2);
            //YTD
            DataRow newRow3 = table.NewRow();
            newRow3[0] = ds.ElectricityConsumption[0].YTD;
            newRow3[1] = "YTD";
            table.Rows.Add(newRow3);
            //Q1
            DataRow newRow4 = table.NewRow();
            newRow4[0] = ds.ElectricityConsumption[0].Q1;
            newRow4[1] = "Q1";
            table.Rows.Add(newRow4);
            //Q2
            DataRow newRow5 = table.NewRow();
            newRow5[0] = ds.ElectricityConsumption[0].Q2;
            newRow5[1] = "Q2";
            table.Rows.Add(newRow5);
            //Q3
            DataRow newRow6 = table.NewRow();
            newRow6[0] = ds.ElectricityConsumption[0].Q3;
            newRow6[1] = "Q3";
            table.Rows.Add(newRow6);
            //Q4
            DataRow newRow7 = table.NewRow();
            newRow7[0] = ds.ElectricityConsumption[0].Q4;
            newRow7[1] = "Q4";
            table.Rows.Add(newRow7);
            string[] strs = Common.GetQuarters();
            //Month1
            DataRow newRow8 = table.NewRow();
            newRow8[0] = ds.ElectricityConsumption[0].Month1;
            newRow8[1] = strs[0];
            table.Rows.Add(newRow8);
            //Month2
            DataRow newRow9 = table.NewRow();
            newRow9[0] = ds.ElectricityConsumption[0].Month2;
            newRow9[1] = strs[1];
            table.Rows.Add(newRow9);
            //Month3
            DataRow newRow10 = table.NewRow();
            newRow10[0] = ds.ElectricityConsumption[0].Month3;
            newRow10[1] = strs[2];
            table.Rows.Add(newRow10);
            //Week1
            DataRow newRow11 = table.NewRow();
            newRow11[0] = ds.ElectricityConsumption[0].Week1;
            newRow11[1] = "Week35";
            table.Rows.Add(newRow11);
            //Week2
            DataRow newRow12 = table.NewRow();
            newRow12[0] = ds.ElectricityConsumption[0].Week2;
            newRow12[1] = "Week36";
            table.Rows.Add(newRow12);
            //Week3
            DataRow newRow13 = table.NewRow();
            newRow13[0] = ds.ElectricityConsumption[0].Week3;
            newRow13[1] = "Week37";
            table.Rows.Add(newRow13);
            //Week4
            DataRow newRow14 = table.NewRow();
            newRow14[0] = ds.ElectricityConsumption[0].Week4;
            newRow14[1] = "Week38";
            table.Rows.Add(newRow14);
            //Week5
            DataRow newRow15 = table.NewRow();
            newRow15[0] = ds.ElectricityConsumption[0].Week5;
            newRow15[1] = "Week39";
            table.Rows.Add(newRow15);

            return table;
        }

        /// <summary>
        /// 创件EquipmentEnergy
        /// </summary>
        /// <returns></returns>
        public DataTable[] CreateEquipmentEnergyTableEx(ElectricityConsumptionDS ds)
        {
            DataTable[] tables = new DataTable[2];
            DataTable table1 = new DataTable();
            DataTable table2 = new DataTable();
            tables[0] = table1;
            tables[1] = table2;

            table1.Columns.Add("Total", typeof(double));
            table1.Columns.Add("Name", typeof(string));

            table2.Columns.Add("Total", typeof(double));
            table2.Columns.Add("Name", typeof(string));

            //PreviousYear
            DataRow newRow1 = table1.NewRow();
            newRow1[0] = ds.ElectricityConsumption[0].PreviousYear;
            newRow1[1] = "Previous Year";
            table1.Rows.Add(newRow1);
            //YearlyTarget
            DataRow newRow2 = table1.NewRow();
            newRow2[0] = ds.ElectricityConsumption[0].YearlyTarget;
            newRow2[1] = "Yearly Target";
            table1.Rows.Add(newRow2);
            //YTD
            DataRow newRow3 = table1.NewRow();
            newRow3[0] = ds.ElectricityConsumption[0].YTD;
            newRow3[1] = "YTD";
            table1.Rows.Add(newRow3);
            //Q1
            DataRow newRow4 = table1.NewRow();
            newRow4[0] = ds.ElectricityConsumption[0].Q1;
            newRow4[1] = "Q1";
            table1.Rows.Add(newRow4);
            //Q2
            DataRow newRow5 = table1.NewRow();
            newRow5[0] = ds.ElectricityConsumption[0].Q2;
            newRow5[1] = "Q2";
            table1.Rows.Add(newRow5);
            //Q3
            DataRow newRow6 = table1.NewRow();
            newRow6[0] = ds.ElectricityConsumption[0].Q3;
            newRow6[1] = "Q3";
            table1.Rows.Add(newRow6);
            //Q4
            DataRow newRow7 = table1.NewRow();
            newRow7[0] = ds.ElectricityConsumption[0].Q4;
            newRow7[1] = "Q4";
            table1.Rows.Add(newRow7);

            string[] strs = Common.GetQuarters();
            //Month1
            DataRow newRow8 = table2.NewRow();
            newRow8[0] = ds.ElectricityConsumption[0].Month1;
            newRow8[1] = strs[0];
            table2.Rows.Add(newRow8);
            //Month2
            DataRow newRow9 = table2.NewRow();
            newRow9[0] = ds.ElectricityConsumption[0].Month2;
            newRow9[1] = strs[1];
            table2.Rows.Add(newRow9);
            //Month3
            DataRow newRow10 = table2.NewRow();
            newRow10[0] = ds.ElectricityConsumption[0].Month3;
            newRow10[1] = strs[2];
            table2.Rows.Add(newRow10);
            //Week1
            DataRow newRow11 = table2.NewRow();
            newRow11[0] = ds.ElectricityConsumption[0].Week1;
            newRow11[1] = "Week35";
            table2.Rows.Add(newRow11);
            //Week2
            DataRow newRow12 = table2.NewRow();
            newRow12[0] = ds.ElectricityConsumption[0].Week2;
            newRow12[1] = "Week36";
            table2.Rows.Add(newRow12);
            //Week3
            DataRow newRow13 = table2.NewRow();
            newRow13[0] = ds.ElectricityConsumption[0].Week3;
            newRow13[1] = "Week37";
            table2.Rows.Add(newRow13);
            //Week4
            DataRow newRow14 = table2.NewRow();
            newRow14[0] = ds.ElectricityConsumption[0].Week4;
            newRow14[1] = "Week38";
            table2.Rows.Add(newRow14);
            //Week5
            DataRow newRow15 = table2.NewRow();
            newRow15[0] = ds.ElectricityConsumption[0].Week5;
            newRow15[1] = "Week39";
            table2.Rows.Add(newRow15);

            return tables;
        }
    }
}
