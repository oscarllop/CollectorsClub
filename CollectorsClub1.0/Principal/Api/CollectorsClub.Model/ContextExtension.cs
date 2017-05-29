using System.Data;
using System.Dynamic;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using CollectorsClub.Model.Entities;
using CollectorsClub.Model.Configurations;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;

namespace CollectorsClub.Model {
	public partial class CollectorsClubEntities : DbContext {
		public static List<dynamic> ExecuteCommand(string command, SqlParameter[] parameters, CommandType type, string connectionString) {
			List<dynamic> _filas = new List<dynamic>();
			using (SqlConnection _conexion = new SqlConnection(connectionString)) {
				_conexion.Open();
				using (SqlCommand _command = new SqlCommand(command, _conexion) { CommandType = CommandType.StoredProcedure }) {
					_command.Parameters.AddRange(parameters);
					using (SqlDataReader _reader = _command.ExecuteReader()) {
						if (_reader.Read()) {
							IEnumerable<object> cols = _reader.GetSchemaTable().Rows.OfType<DataRow>().Select(r => r["ColumnName"]);

							do {
								dynamic t = new ExpandoObject();
								foreach (string col in cols) { ((IDictionary<string, object>) t)[col] = _reader[col]; }
								_filas.Add(t);
							} while (_reader.Read());
						}
					}

				}
				_conexion.Close();
			}
			return (_filas.Count() == 0 ? null : _filas);
		}
	}
}
