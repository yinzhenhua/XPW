using Microsoft.Practices.EnterpriseLibrary.Common.Configuration;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;

namespace XPW.DA
{
    /// <summary>
    /// 数据库单元
    /// </summary>
    public class DbUtility
    {
        /// <summary>
        /// Database
        /// </summary>
        private readonly Database _database;
        /// <summary>
        /// 数据库名称
        /// </summary>
        private readonly string _databaseName = string.Empty;
        /// <summary>
        /// 参数Cache
        /// </summary>
        private static readonly ParameterCache _parameterCache = new ParameterCache();
        public DbUtility()
            : this(string.Empty)
        {
        }
        public DbUtility(string databaseName)
        {
            _databaseName = databaseName;

            _database = string.IsNullOrEmpty(databaseName)
                                ? DatabaseFactory.CreateDatabase()
                                : DatabaseFactory.CreateDatabase(databaseName);

        }
        public Database Database
        {
            get
            {
                return _database;
            }
        }
        public IDataReader ExecuteReader(string procedureName, params object[] parameters)
        {
            DbCommand command = this._database.GetStoredProcCommand(procedureName, parameters);
            return this.ExecuteReader(command);
        }
        public IDataReader ExecuteReader(string procedureName, IDictionary<string, object> parameters)
        {
            DbCommand command = this._database.GetStoredProcCommand(procedureName);
            this.AssignParameterValues(command, parameters);
            return this.ExecuteReader(command);
        }
        public IDataReader ExecuteReader(DbCommand command, DbTransaction transaction)
        {
            return this._database.ExecuteReader(command, transaction);
        }
        public IDataReader ExecuteReader(DbCommand command)
        {
            return this._database.ExecuteReader(command);
        }
        public object ExecuteScalar(DbCommand dbCommand)
        {
            return _database.ExecuteScalar(dbCommand);
        }
        public object ExecuteScalar(DbCommand dbCommand, DbTransaction transaction)
        {
            return _database.ExecuteScalar(dbCommand, transaction);
        }
        public object ExecuteScalar(string storedProcedureName, params object[] parameterValues)
        {
            DbCommand dbCommand = BuildDbCommand(storedProcedureName);
            AssignParameterValues(dbCommand, parameterValues);

            return ExecuteScalar(dbCommand);
        }
        public T ExecuteScalar<T>(string storedProcedureName, params object[] parameterValues)
        {
            object returnValue = ExecuteScalar(storedProcedureName, parameterValues);

            return (returnValue == null || returnValue == DBNull.Value) ? default(T) : (T)returnValue;
        }
        public int ExecuteNonQuery(string storedProcedureName, params object[] parameterValues)
        {
            DbCommand dbCommand = BuildDbCommand(storedProcedureName);
            AssignParameterValues(dbCommand, parameterValues);

            return ExecuteNonQuery(dbCommand);
        }
        public int ExecuteNonQuery(DbCommand dbCommand)
        {
            return _database.ExecuteNonQuery(dbCommand);
        }
        public int ExecuteNonQuery(DbCommand dbCommand, DbTransaction transaction)
        {
            return _database.ExecuteNonQuery(dbCommand, transaction);
        }
        public DbCommand BuildDbCommand(string storedProcedureName)
        {
            DbCommand dbCommand = _database.GetStoredProcCommand(storedProcedureName);
            _parameterCache.SetParameters(dbCommand, _database);
            return dbCommand;
        }
        public void AssignParameterValues(DbCommand dbCommand, params object[] parameterValues)
        {
            AssignParameterValues(_database, dbCommand, parameterValues);
        }
        public void Fill(DataSet dataSet, CommandList commandList)
        {
            if (dataSet == null)
            {
                throw new ArgumentNullException("dataSet");
            }

            bool isEnforceConstraints = dataSet.EnforceConstraints;
            dataSet.EnforceConstraints = false;

            foreach (DataTable dataTable in dataSet.Tables)
            {
                Fill(dataTable, commandList[dataTable.TableName].SelectCommand);
            }

            dataSet.EnforceConstraints = isEnforceConstraints;
        }
        public void Fill(DataTable dataTable, DbCommand dbCommand)
        {
            if (dataTable == null)
            {
                throw new ArgumentNullException("dataTable");
            }
            if (dataTable.DataSet == null)
            {
                new DataSet().Tables.Add(dataTable);
            }

            _database.LoadDataSet(dbCommand, dataTable.DataSet, dataTable.TableName);

            if (dataTable.DataSet == null)
            {
                dataTable.DataSet.Tables.Remove(dataTable);
            }
        }
        public void Fill(DataTable dataTable, DbCommand dbCommand, DbTransaction transaction)
        {
            if (dataTable == null)
            {
                throw new ArgumentNullException("dataTable");
            }
            if (dataTable.DataSet == null)
            {
                new DataSet().Tables.Add(dataTable);
            }
            _database.LoadDataSet(dbCommand, dataTable.DataSet, dataTable.TableName, transaction);
            if (dataTable.DataSet == null)
            {
                dataTable.DataSet.Tables.Remove(dataTable);
            }
        }
        public void Fill(DataSet dataSet, string[] tableNames, string storedProcedureName, params object[] parameterValues)
        {
            if (dataSet == null)
            {
                throw new ArgumentNullException("dataSet");
            }

            DbCommand dbCommand = BuildDbCommand(storedProcedureName);
            AssignParameterValues(dbCommand, parameterValues);

            Fill(dataSet, tableNames, dbCommand);
        }
        public void Fill(DataSet dataSet, string[] tableNames, DbCommand dbCommand)
        {
            if (dataSet == null)
            {
                throw new ArgumentNullException("dataSet");
            }
            _database.LoadDataSet(dbCommand, dataSet, tableNames);
        }
        public void Fill(DataSet dataSet, string[] tableNames, DbCommand dbCommand, DbTransaction transaction)
        {
            if (dataSet == null)
            {
                throw new ArgumentNullException("dataSet");
            }
            _database.LoadDataSet(dbCommand, dataSet, tableNames, transaction);
        }
        public void Fill(DataTable dataTable, string storedProcedureName, params object[] parameterValues)
        {
            if (dataTable == null)
            {
                throw new ArgumentNullException("dataTable");
            }

            DbCommand dbCommand = BuildDbCommand(storedProcedureName);
            AssignParameterValues(dbCommand, parameterValues);

            Fill(dataTable, dbCommand);
        }
        public static void AssignParameterValues(Database database, DbCommand command, params object[] parameters)
        {
            if (parameters == null)
            {
                return;
            }
            int index = 0;
            for (int i = 0; i < command.Parameters.Count; i++)
            {
                var parameter = command.Parameters[i];
                switch (parameter.Direction)
                {
                    case ParameterDirection.Input:
                        {
                            parameter.Value = parameters[index++];
                            break;
                        }
                    case ParameterDirection.ReturnValue:
                        {
                            break;
                        }
                    case ParameterDirection.Output:
                        {
                            parameter.Value = null;
                            break;
                        }
                    case ParameterDirection.InputOutput:
                        {
                            parameter.Value = DBNull.Value;
                            break;
                        }
                }
            }
        }
    }
}
