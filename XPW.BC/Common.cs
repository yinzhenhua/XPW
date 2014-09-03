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
    }
}