import 'package:mysql_client/mysql_client.dart';

class DatabaseClient {
  DatabaseClient._internal();

  static DatabaseClient? _databaseClient;

  static DatabaseClient? get instance =>
      _databaseClient ??= DatabaseClient._internal();

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

  // Future<IResultSet> execute()
}
