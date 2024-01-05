import '../database/connection/database_client.dart';
import '../models/access_token.dart';

class AuthRepository {
  final DatabaseClient db;
  const AuthRepository(this.db);

  Future<void> create(AccessToken accessToken) async {
    const sql =
        'insert into access_tokens (id, token, expiration_date, user_id) values(:id, :token, :expiration_date, :user_id)';

    await db.execute(sql, accessToken.toMap());
  }

  Future<AccessToken> getByCredentials(String email, String password) async {
    const sql =
        'SELECT a.user_id, a.id, a.expiration_date, a.token from access_tokens a inner join users u on u.id = a.user_id'
        ' where password = :password AND email = :email';

    final results =
        await db.execute(sql, {'email': email, 'password': password});
    final jsonMap = results.rows.first.typedAssoc() as Map<String, dynamic>;
    return AccessToken.fromMap(jsonMap);
  }
}
