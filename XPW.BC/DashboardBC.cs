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
        public double GetCO2Mouth()
        {
            try
            {
                DataTable dt = new DataTable();
                SqlDBAccess.Instance.Fill(dt, "GetCO2Mouth", null);
                if (dt.Rows.Count > 0)
                {
                    return Convert.ToDouble(dt.Rows[0][0]);
                }
                return 0;
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
        public double GetCO2Year()
        {
            try
            {
                DataTable dt = new DataTable();
                SqlDBAccess.Instance.Fill(dt, "GetCO2Year", null);
                if (dt.Rows.Count > 0)
                {
                    return Convert.ToDouble(dt.Rows[0][0]);
                }
                return 0;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        /// <summary>
        /// 获得截止今天的全年的电水气 @TYPE 1.电，2.水，3.气.
        /// </summary>
        public double GetUtilities(int deviceID)
        {
            try
            {
                DataTable dt = new DataTable();
                SqlDBAccess.Instance.Fill(dt, "GetUtilities", new object[] { deviceID });
                if (dt.Rows.Count > 0)
                {
                    return Convert.ToDouble(dt.Rows[0][0]);
                }
                return 0;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        /// <summary>
        /// 获得截止去年的电水气 @TYPE 1.电，2.水，3.气.
        /// </summary>
        public double GetUtilitiesPrev(int deviceID)
        {
            try
            {
                DataTable dt = new DataTable();
                SqlDBAccess.Instance.Fill(dt, "GetUtilitiesPrev", new object[] { deviceID });
                if (dt.Rows.Count > 0)
                {
                    return Convert.ToDouble(dt.Rows[0][0]);
                }
                return 0;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        /// <summary>
        /// 获得能源明细
        /// </summary>
        /// <param name="deviceID"></param>
        /// <returns></returns>
        public DataTable GetUtilitiesEnergy(int deviceID)
        {
            try
            {
                DataTable dt = new DataTable();
                SqlDBAccess.Instance.Fill(dt, "GetUtilitiesEnergy", new object[] { deviceID });
                return dt;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        /// <summary>
        /// 获得去年每个月的能源明细 DataTable返回12行分别对应每个月数据
        /// </summary>
        /// <returns></returns>
        public DataTable GetUtilitiesPrevMonths(int deviceID)
        {
            try
            {
                DataTable dt = new DataTable();
                SqlDBAccess.Instance.Fill(dt, "GetUtilitiesPrevMonths", new object[] { deviceID });
                return dt;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        /// <summary>
        /// 获得去年指定月份的30或31天的能源明细
        /// </summary>
        /// <param name="deviceID"></param>
        /// <param name="month"></param>
        /// <returns></returns>
        public DataTable GetUtilitiesPrevDays(int deviceID, int month)
        {
            try
            {
                DataTable dt = new DataTable();
                SqlDBAccess.Instance.Fill(dt, "GetUtilitiesPrevDays", new object[] { deviceID, month });
                return dt;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        /// <summary>
        /// 获得去年指定月份指定某一天的的24小时能源明细
        /// </summary>
        /// <returns></returns>
        public DataTable GetUtilitiesPrevHours(int deviceID, int month, int day)
        {
            try
            {
                DataTable dt = new DataTable();
                SqlDBAccess.Instance.Fill(dt, "GetUtilitiesPrevHours", new object[] { deviceID, month, day });
                return dt;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        /// <summary>
        /// 获得今年每个月的能源明细 DataTable返回12行分别对应每个月数据
        /// </summary>
        /// <returns></returns>
        public DataTable GetUtilitiesMonths(int deviceID)
        {
            try
            {
                DataTable dt = new DataTable();
                SqlDBAccess.Instance.Fill(dt, "GetUtilitiesMonths", new object[] { deviceID });
                return dt;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        /// <summary>
        /// 获得今年指定月份的30或31天的能源明细
        /// </summary>
        /// <param name="deviceID"></param>
        /// <param name="month"></param>
        /// <returns></returns>
        public DataTable GetUtilitiesDays(int deviceID, int month)
        {
            try
            {
                DataTable dt = new DataTable();
                SqlDBAccess.Instance.Fill(dt, "GetUtilitiesDays", new object[] { deviceID, month });
                return dt;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        /// <summary>
        /// 获得今年指定月份指定某一天的的24小时能源明细
        /// </summary>
        /// <returns></returns>
        public DataTable GetUtilitiesHours(int deviceID, int month, int day)
        {
            try
            {
                DataTable dt = new DataTable();
                SqlDBAccess.Instance.Fill(dt, "GetUtilitiesHours", new object[] { deviceID, month, day });
                return dt;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
