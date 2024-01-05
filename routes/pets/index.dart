import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

import '../../database/connection/database_client.dart';
import '../../repositories/auth_repository.dart';


Future<Response> onRequest(RequestContext context) async {
  final headers = context.request.headers;
  if (headers['Authorization'] == null) {
    return Response(
        statusCode: 401, body: jsonEncode({'error': 'Not authorized'}));
  }
  final authoRepo = AuthRepository(DatabaseClient.instance!);
  print(headers['Authorization']);
  final token = (headers['Authorization'] as String).split('Bearer')[1];
  final  jwt =JWT.verify(token, SecretKey('dart'));
  final uidMap = jwt.payload;
  print(uidMap);

  final accessToken = await authoRepo.getAccessByToken(token);

  return Response(body: 'This is a new route!');
}
