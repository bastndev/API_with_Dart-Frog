import '../database/connection/database_client.dart';
// import '../exections/not_foun_exceptions.dart';
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

  Future<void> renew(AccessToken accessToken) async {
    final sql = 'UPDATE access_token set token = "${accessToken.token}",'
        'expiration_date = "${accessToken.expirationDate.toIso8601String()}"'
        'where id = "${accessToken.id}"';
    await db.execute(sql, <String, dynamic>{});
  }

  // ignore: inference_failure_on_function_return_type
  getAccessByToken(String token) async {
    final sql = 'select * from access_tokens where'
        'token  = "${token}"limit 1';
    // ignore: unused_local_variable
    final results = await db.execute(sql,<String, dynamic>{});
    
  }

  // Future<AccessToken> getAccessByToken(String token) async {
  //   final sql = 'select * from access_tokens where'
  //       'token  = "${token}"limit 1';
  //   final results = await db.execute(String, sql);
  //   if (results.rows.isEmpty) {
  //     throw const NotFoundException('Missing access token');
  //   }
  //   return AccessToken.fromMap(results.rows.first.typedAssoc());
  // }
}
