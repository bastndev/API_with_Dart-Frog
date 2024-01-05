import 'dart:convert';

import 'package:crypto/crypto.dart' as crypto;
import 'package:dart_frog/dart_frog.dart';
// import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

// import '../../database/connection/database_client.dart';
import '../../repositories/auth_repository.dart';
import '../../utils/jwt_manager.dart';

Future<Response> onRequest(RequestContext context) async {
  final method = context.request.method;
  if (method != HttpMethod.post) {
    return Response(
      statusCode: 405,
      body: jsonEncode({'error': 'Invalid method'}),
    );
  }

  //1-TODO: get the body
  final body = await context.request.json() as Map<String, String>;

  //2-TODO: verify the body
  if (!_isBodyValid(body)) {
    return Response(
        statusCode: 400, body: jsonEncode({'error': 'Invalid body'}));
  }

  //3-TODO: getByCredentials
  final authRepo = context.read<AuthRepository>();
  final digest = crypto.sha1.convert(body['password'].toString().codeUnits);
  final accessToken = await authRepo.getByCredentials(
      body['email'] as String, body['password'] as String);
  body['password'] = digest.toString();

  //4-TODO: check token validity
  if (accessToken.expiration.isBefore(DateTime.now())) {
    final jwtManager = context.read<JWTManager>();
    final payload = {'uid': accessToken.userId};
    final jwtData =jwtManager.sing(payload);
    accessToken
      ..token = jwtData.token
      ..expirationDate = jwtData.expirationDate;
    await authRepo.renew(accessToken);
  }

  //5-TODO: return response

  return Response(body: accessToken.toJson());
}

bool _isBodyValid(Map<String, String> body) {
  final allowedFields = ['email', 'password'];
  for (final field in allowedFields) {
    if (body[field] == null) {
      return false;
    }
  }
  return true;
}
