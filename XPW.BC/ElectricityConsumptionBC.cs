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
                ElectricityConsumptionDS ds = new ElectricityConsumptionDS();
                SqlDBAccess.Instance.Fill(ds.ElectricityConsumption, "GetEquipmentEnergy", new object[] { deviceID });
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
            //Month1
            DataRow newRow8 = table.NewRow();
            newRow8[0] = ds.ElectricityConsumption[0].Month1;
            newRow8[1] = "Month1";
            table.Rows.Add(newRow8);
            //Month2
            DataRow newRow9 = table.NewRow();
            newRow9[0] = ds.ElectricityConsumption[0].Month2;
            newRow9[1] = "Month2";
            table.Rows.Add(newRow9);
            //Month3
            DataRow newRow10 = table.NewRow();
            newRow10[0] = ds.ElectricityConsumption[0].Month3;
            newRow10[1] = "Month3";
            table.Rows.Add(newRow10);
            //Week1
            DataRow newRow11 = table.NewRow();
            newRow11[0] = ds.ElectricityConsumption[0].Week1;
            newRow11[1] = "Week-1";
            table.Rows.Add(newRow11);
            //Week2
            DataRow newRow12 = table.NewRow();
            newRow12[0] = ds.ElectricityConsumption[0].Week2;
            newRow12[1] = "Week-2";
            table.Rows.Add(newRow12);
            //Week3
            DataRow newRow13 = table.NewRow();
            newRow13[0] = ds.ElectricityConsumption[0].Week3;
            newRow13[1] = "Week-3";
            table.Rows.Add(newRow13);
            //Week4
            DataRow newRow14 = table.NewRow();
            newRow14[0] = ds.ElectricityConsumption[0].Week3;
            newRow14[1] = "Week-4";
            table.Rows.Add(newRow14);

            return table;
        }
    }
}
