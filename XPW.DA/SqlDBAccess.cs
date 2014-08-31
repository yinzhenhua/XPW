using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace XPW.DA
{
    /// <summary>
    /// Sql Server数据库访问
    /// </summary>
    public class SqlDBAccess
    {
        private static DbUtility _instance;
        private readonly static object _lock = new object();
        public static DbUtility Instance
        {
            get
            {
                lock (_lock)
                {
                    if (_instance == null)
                    {
                        _instance = new DbUtility("XPW");
                    }
                    return _instance;
                }
            }
        }
    }
}
