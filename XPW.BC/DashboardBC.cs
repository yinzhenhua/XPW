using Microsoft.Practices.EnterpriseLibrary.Logging;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using XPW.DA;

namespace XPW.BC
{
    /// <summary>
    /// Dashboard业务处理类
    /// </summary>
    public class DashboardBC
    {
        /// <summary>
        /// 获得当月的碳排量
        /// </summary>
        /// <returns></returns>
        public float GetMonthCO2Total()
        {
            try
            {
                DataTable dt = new DataTable();
                SqlDBAccess.Instance.Fill(dt, "GetMonthCO2Total", null);
                return 0.0F;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return 0.0F;
        }
    }
}
