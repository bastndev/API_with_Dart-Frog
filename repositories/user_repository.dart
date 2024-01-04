// ignore_for_file: avoid_dynamic_calls
// import 'dart:convert';

// import 'package:dart_frog/dart_frog.dart';
import 'package:mysql_client/exception.dart';

import '../database/connection/database_client.dart';
import '../exections/duplicate_key_entry.dart';
import '../exections/server_exception.dart';
import '../models/user.dart';

class UserRepository {
  final DatabaseClient db;
  const UserRepository(this.db);

  Future<void> create(User user) async {
    const sql =
        'insert into users(id, name, email, password) values(:id, :name, :email, :password)';
    try {
      await db.execute(sql, user.toMap());
    }
    on MySQLServerException catch(err){
      if(err.errorCode == 1062){
        throw const DuplicateKeyEntry('User name exists in the database');
      }
    } 
    catch (_) {
      throw const ServerException('Something has gone wrong');
    }
  }

  Future<bool> checkIfEmailExists(String email) async {
    final sql =
        'SELECT COUNT(email) as`count` from users where email = "$email"';
    final result = await db.execute(sql, {'email': email});
    final count = result.rows.first.typedAssoc()['acount'] as int;
    return count > 0;
  }
}
