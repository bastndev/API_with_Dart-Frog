import 'package:mysql_client/mysql_client.dart';

class DatabaseClient {
  DatabaseClient._internal();

  static DatabaseClient? _databaseClient;

  static DatabaseClient? get instance =>
      _databaseClient ??= DatabaseClient._internal();

  // ignore: unused_field
  late MySQLConnectionPool _pool;

  void init([int connections = 10]) {
    _pool = MySQLConnectionPool(
      host: 'localhost',
      port: 3306,
      userName: 'root',
      password: 'root',
      databaseName: 'protective',
      maxConnections: connections,
    );
  }

  // ignore: inference_failure_on_function_return_type, always_declare_return_types, type_annotate_public_apis
  execute(String sql, Map<String, dynamic> map) {}

/*   Future<IResultSet> execute(String sql []) async {
    final conn = await _pool.getConnection();
    final result = conn.query(sql);
    await conn.close();
    return result;
  } */
}
