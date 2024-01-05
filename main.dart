import 'dart:io';
// backend use SQL

import 'package:dart_frog/dart_frog.dart';

import 'database/connection/database_client.dart';
import 'repositories/auth_repository.dart';
import 'repositories/user_repository.dart';
import 'utils/jwt_manager.dart';

Future<void> init(InternetAddress ip, int port) async {
  DatabaseClient.instance?.init(20);
}

Future<HttpServer> run(Handler handler, InternetAddress ip, int port) {
  return serve(
    handler
        .use(
          provider<JWTManager>(
            (context) => const JWTManager('dart'),
          ),
        )
        .use(
          provider<AuthRepository>(
            (context) => AuthRepository(DatabaseClient.instance!),
          ),
        )
        .use(
          provider<UserRepository>(
            (context) => UserRepository(DatabaseClient.instance!),
          ),
        ),
    ip,
    port,
  );
}
