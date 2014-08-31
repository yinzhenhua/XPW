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
        /// 获得截止今天的当月的碳排量
        /// </summary>
        /// <returns></returns>
        public decimal GetCO2Mouth()
        {
            try
            {
                DataTable dt = new DataTable();
                SqlDBAccess.Instance.Fill(dt, "GetCO2Mouth", null);
                if (dt.Rows.Count > 0)
                {
                    return Convert.ToDecimal(dt.Rows[0][0]);
                }
                return decimal.Zero;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        /// <summary>
        /// 获得截止当天的一年的碳排量
        /// </summary>
        /// <returns></returns>
        public decimal GetCO2Year()
        {
            try
            {
                DataTable dt = new DataTable();
                SqlDBAccess.Instance.Fill(dt, "GetCO2Year", null);
                if (dt.Rows.Count > 0)
                {
                    return Convert.ToDecimal(dt.Rows[0][0]);
                }
                return decimal.Zero;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        /// <summary>
        /// 获得截止今天的全年的电水气 @TYPE 1.电，2.水，3.气.
        /// </summary>
        public decimal GetUtilities(int type)
        {
            try
            {
                DataTable dt = new DataTable();
                SqlDBAccess.Instance.Fill(dt, "GetUtilities", new object[] { type });
                if (dt.Rows.Count > 0)
                {
                    return Convert.ToDecimal(dt.Rows[0][0]);
                }
                return decimal.Zero;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        /// <summary>
        /// 获得截止去年的电水气 @TYPE 1.电，2.水，3.气.
        /// </summary>
        public decimal GetUtilitiesPrev(int type)
        {
            try
            {
                DataTable dt = new DataTable();
                SqlDBAccess.Instance.Fill(dt, "GetUtilitiesPrev", new object[] { type });
                if (dt.Rows.Count > 0)
                {
                    return Convert.ToDecimal(dt.Rows[0][0]);
                }
                return decimal.Zero;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
