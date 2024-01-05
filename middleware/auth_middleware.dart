import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';
// import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

import '../utils/jwt_manager.dart';

Middleware bearerAutorizationMiddleware() {
  return (handler) {
    return (context) {
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
        final uidMap = jwt.payload;
        print(uidMap);
      } catch (error) {
        return Response(
            statusCode: 400, body: jsonEncode({'error': 'No valid petition'}));
      }

      return handler(context);
    };
  };
}
