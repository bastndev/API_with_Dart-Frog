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
}
