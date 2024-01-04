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
  return Response(body: 'This is a new route!');
}
