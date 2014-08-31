﻿using Microsoft.Practices.EnterpriseLibrary.Logging;
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
        public decimal GetUtilities(int deviceID)
        {
            try
            {
                DataTable dt = new DataTable();
                SqlDBAccess.Instance.Fill(dt, "GetUtilities", new object[] { deviceID });
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
        public decimal GetUtilitiesPrev(int deviceID)
        {
            try
            {
                DataTable dt = new DataTable();
                SqlDBAccess.Instance.Fill(dt, "GetUtilitiesPrev", new object[] { deviceID });
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
        /// 获得去年每个月的能源明细 DataTable返回12列 1-12代表每月数据
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
    }
}
