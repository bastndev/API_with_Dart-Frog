// ignore_for_file: avoid_dynamic_calls
import '../database/connection/database_client.dart';
import '../models/user.dart';

class UserRepository {
  final DatabaseClient db;
  const UserRepository(this.db);

  Future<void> create(User user) async {
    const sql =
        'insert into users(id, name, email, password) values(:id, :name, :email, :password)';

    await db.execute(sql, user.toMap());
  }

  Future<bool> checkIfEmailExists(String email) async {
    final sql =
        'SELECT COUNT(email) as`count` from users where email = "$email"';
    final result = await db.execute(sql, {'email': email});
    final count = result.rows.first.typedAssoc()['acount'] as int;
    return count > 0;
  }
}
