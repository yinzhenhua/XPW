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
    }
}
