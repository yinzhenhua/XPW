using System;
using System.Collections.Generic;
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
            int Benchmark,
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
            double Week4
            )
        {
            try
            {
                EquipmentEnergyEfficiencyDS ds = new EquipmentEnergyEfficiencyDS();
                SqlDBAccess.Instance.Fill(ds.EquipmentEnergyEfficiency, "GetEquipmentEnergyEfficiency", new object[]{
                    DeviceID,
                    Benchmark,
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
                    Week4
                });
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
