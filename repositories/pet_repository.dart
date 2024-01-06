// ignore_for_file: lines_longer_than_80_chars

import '../database/connection/database_client.dart';
import '../exections/server_exception.dart';

class PetRepository {
  const PetRepository(this.db);
  final DatabaseClient db;

  Future<void> create(Map<String, dynamic> params) async {
    const sql =
        'insert into pets (id, name, age, type, base64image) values(:id, :name, :age, :type, :base64image)';
    try {
      await db.execute(sql, params);
    } catch (_) {
      throw const ServerException('Something has gone wrong');
    }
  }

  Future search(String sql)async {
    final results = await db.execute(sql,<String, String>{});
    return results.rows.map((e)=>  e.typedAssoc()).toList();
  }
}
