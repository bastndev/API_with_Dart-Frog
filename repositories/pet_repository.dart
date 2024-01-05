// ignore_for_file: lines_longer_than_80_chars
import 'package:mysql_client/exception.dart';

import '../database/connection/database_client.dart';
import '../exections/duplicate_key_entry.dart';
import '../exections/server_exception.dart';

class PetRepository {
  const PetRepository(this.db);
  final DatabaseClient db;

  Future<void> create(Map<String, dynamic> params) async {
    const sql =
        'insert into users(id, name, age, type, base64image) values(:id, :name, :age, :type, :base64image)';
    try {
      await db.execute(sql, params);
    } on MySQLServerException catch (err) {
      if (err.errorCode == 1062) {
        throw const DuplicateKeyEntry('User name exists in the database');
      }
    } catch (_) {
      throw const ServerException('Something has gone wrong');
    }
  }
}
