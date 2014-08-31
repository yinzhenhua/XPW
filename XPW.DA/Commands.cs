using Microsoft.Practices.EnterpriseLibrary.Common.Properties;
using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Linq;
using System.Text;

namespace XPW.DA
{
    public class Commands
    {
        internal Commands()
        { }
        public DbCommand SelectCommand { get; set; }
        public DbCommand InsertCommand { get; set; }

        public DbCommand UpdateCommand { get; set; }
        public DbCommand DeleteCommand { get; set; }
        public DbCommand GetDbCommand(DbOperationType dbOperationType)
        {
            switch (dbOperationType)
            {
                case DbOperationType.Select:
                    return SelectCommand;
                case DbOperationType.Insert:
                    return InsertCommand;
                case DbOperationType.Update:
                    return UpdateCommand;
                case DbOperationType.Delete:
                    return DeleteCommand;
                default:
                    throw new ArgumentOutOfRangeException("无效的dbOperationType");
            }
        }
    }
}
