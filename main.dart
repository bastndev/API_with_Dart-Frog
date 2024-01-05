import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

import 'database/connection/database_client.dart';

Future<void> init(InternetAddress ip, int port) async {
  DatabaseClient.instance?.init(20);
}

Future<HttpServer> run(Handler handler, InternetAddress ip, int port){
  return serve(handler, ip, port);
}