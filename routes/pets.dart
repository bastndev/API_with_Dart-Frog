import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';

import '../database/connection/database_client.dart';
import '../repositories/auth_repository.dart';

Future <Response> onRequest(RequestContext context) async {
  final headers = context.request.headers;
  if (headers['Authorization'] == null) {
    return Response(
        statusCode: 401, body: jsonEncode({'error': 'Not authorized'}));
  }
  final authoRepo = AuthRepository(DatabaseClient.instance!);
  print(headers['Authorization']);
  final accessToken = await authoRepo.getAccessByToken();
  return Response(body: 'This is a new route!');
}
