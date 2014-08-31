using Microsoft.Practices.EnterpriseLibrary.Data;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Text;

namespace XPW.DA
{
    /// <summary>
    /// 事务处理
    /// </summary>
    public class Transaction : IDisposable
    {
        public Database Database { get; private set; }
        public DbTransaction DbTransaction { get; private set; }
        public Transaction(Database database, IsolationLevel isolationLevel)
        {
            DbConnection dbConnection = database.CreateConnection();
            dbConnection.Open();
            this.DbTransaction = dbConnection.BeginTransaction(isolationLevel);
        }
        public Transaction(Database database)
            : this(database, IsolationLevel.ReadCommitted)
        { }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        protected virtual void Dispose(bool disposing)
        {
            if (disposing)
            {
                DbConnection dbConnection = this.DbTransaction.Connection;
                this.DbTransaction.Commit();
                dbConnection.Close();
            }
        }

    }
}
