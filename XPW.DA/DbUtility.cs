using Microsoft.Practices.EnterpriseLibrary.Common.Configuration;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Data;

namespace XPW.DA
{
    public class DbUtility
    {
        private DbUtility()
        {

        }

        Database _database = EnterpriseLibraryContainer.Current.GetInstance<Database>();
        private static object _asyncObject = new object();
        private static DbUtility _instance;
        
        public static DbUtility Instance
        {
            get
            {
                lock(_asyncObject)
                {
                    if(null==_instance)
                    {
                        _instance = new DbUtility();
                    }
                }

                return _instance;
            }
        }

        public void FillDataSet(string procName, DataSet ds, string tableName)
        {
            using (var command = _database.GetStoredProcCommand(procName))
            {
                _database.LoadDataSet(command, ds, tableName);
            }
        }

        public void FillDataSet(string procName, DataSet ds, string tableName, object[] parameters)
        {
            using (var command = _database.GetStoredProcCommand(procName, parameters))
            {
                _database.LoadDataSet(command, ds, tableName);
            }
        }

        public object LoadScalar(string procName)
        {
            using (var command = _database.GetStoredProcCommand(procName))
            {
                return _database.ExecuteScalar(command);
            }
        }
    }
}
