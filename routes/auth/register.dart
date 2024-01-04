import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context) {
  final method = context.request.method;
  if (method != HttpMethod.post) {
    return Response(
      statusCode: 405,
      body: jsonEncode({'error': 'Invalid method'}),
    );
  }
  // 1-TODO: check the body

  // 2-TODO: The email doesn't exist in the data base

  // 3-TODO: Create user ID

  // 4-TODO: Enter the number in data base

  // 5-TODO: Generate the authentication token

  // 6-TODO: Enter the authentication token for the user

  // 7-TODO: sed the request

  return Response(body: 'This is a new route!');
}

bool _isBodyValid(Map<String, String> body) {
  final allowedFields = ['username', 'password', 'email'];
  for (final field in allowedFields) {
    if (body[field] == null) {
      return false;
    }
  }
  return true;
}
