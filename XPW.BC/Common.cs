using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace XPW.BC
{
    public class Common
    {
        public static string[] GetQuarters()
        {
            string[] Months = new string[] {
            "Jan", "Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"
            };
            int monthF = ((DateTime.Now.Month - 1) / 3 + 1) * 3 - 2;
            string[] strs = new string[3];
            strs[0] = Months[monthF - 1];
            strs[1] = Months[monthF];
            strs[2] = Months[monthF + 1];
            return strs;
        }
        /// <summary>
        /// 获得当前月的第一天所在一年中的第几周
        /// </summary>
        /// <returns></returns>
        public static int GetWeekOfYear()
        {
            DateTime time = DateTime.Parse(DateTime.Now.Year.ToString() + "-01-01");
            DateTime time1 = time.AddMonths(DateTime.Now.Month);
            int weeks = (time1.DayOfYear - time.DayOfYear - (7 - (int)time.DayOfWeek) - (int)time1.DayOfWeek) / 7 + 2;
            return weeks;
        }
        public static int GetYearlyTargetID(int deviceID)
        {
            switch (deviceID)
            {
                case 390:
                    return 412;
                case 391:
                    return 420;
                case 392:
                    return 417;
                case 393:
                    return 415;
                case 394:
                    return 423;
                case 395:
                    return 414;
                case 396:
                    return 418;
                case 397:
                    return 421;
                case 398:
                    return 422;
                case 399:
                    return 419;
                case 400:
                    return 416;
                default:
                    return 413;
            }
        }
    }
}