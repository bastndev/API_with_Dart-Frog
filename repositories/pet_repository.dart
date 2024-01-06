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

  // ignore: strict_raw_type
  Future search(String sql) async {
    final results = await db.execute(sql, <String, String>{});
    // ignore: inference_failure_on_untyped_parameter, avoid_dynamic_calls
    return results.rows.map((e) => e.typedAssoc()).toList();
  }

  // ignore: inference_failure_on_function_return_type

  // ignore: inference_failure_on_function_return_type
  getOne(String id) {}
  // update(Map<String, dynamic> body, String id) {}

  // Future<Map<String, dynamic>> getOne(String id) async {
  //   final sql = 'SELECT * FROM pets'
  //       'WHERE id =  "$id"';
  //   final result = await db.execute(sql);
  //   if (result.rows.isEmpty) {
  //     throw NotFoundsException('$id not found');
  //   }
  //   return result.rows.first.typedAssoc();
  // }

  Future<void> update(Map<String, dynamic> body, String id) async {
    var {'name': name, 'age': age, 'type': type, 'id': id} = body;
    final sql = 'UPDATE pets'
        'SET name = "$name",'
        'age = "$age", type = "$type", id = "$id"';

    await db.execute(sql, <String, String>{});
  }

  Future<void> deleteOne(String id) async {
    final sql = 'DELETE FROM pets WHERE id = "$id"';
    await db.execute(sql, <String, String>{});
  }
}
