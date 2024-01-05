import 'dart:io';
import 'dart:js';

import 'package:dart_frog/dart_frog.dart';

import 'database/connection/database_client.dart';
import 'utils/jwt_manager.dart';

Future<void> init(InternetAddress ip, int port) async {
  DatabaseClient.instance?.init(20);
}

Future<HttpServer> run(Handler handler, InternetAddress ip, int port) {
  return serve(
    handler.use(provider<JWTManager>((context) => const JWTManager('dart'))),
    ip,
    port,
  );
}
