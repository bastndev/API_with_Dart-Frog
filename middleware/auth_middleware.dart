import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';
// import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

import '../utils/jwt_manager.dart';

Middleware bearerAuthorizationMiddleware() {
  return (handler) {
    return (context) {
      if (context.request.uri.path == '/pets/ws/adopted') {
        return handler(context);
      }
      final headers = context.request.headers;
      if (headers['Authorization'] == null ||
          !headers['Authorization']!.startsWith('Bearer')) {
        return Response(
            statusCode: 401, body: jsonEncode({'error': 'Not authorized'}));
      }
      print(headers['Authorization']);
      final token = (headers['Authorization'])!.split('Bearer')[1];
      try {
        final jwtManager = context.read<JWTManager>();
        final jwt = jwtManager.verify(token);
        final uidMap = jwt.payload as Map<String, dynamic>;
        var {'uid': userID} = uidMap;

        return handler(context.provide<String>(() => userID as String));
      } catch (error) {
        return Response(
            statusCode: 400, body: jsonEncode({'error': 'No valid petition'}));
      }

      // return handler(context);
    };
  };
}
