import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  switch (context.request.method) {
    case HttpMethod.delete:
      final headers = context.request.headers;
      print('Headers $headers ');
      final body = context.request.json();
      print('Body of request $body');
      return Response(statusCode: 201);

    case HttpMethod.get:
      return Response(
        body: jsonEncode({
          'Hello': 'World 2023',
        }),
        headers: {'Content-Type': 'application/json'},
      );

    case HttpMethod.post:
      final headers = context.request.headers;
      print('Headers $headers ');
      final body = context.request.json();
      print('Body of request $body');
      return Response(
          body: jsonEncode({'DateTime': DateTime.now().toIso8601String()}));

    case HttpMethod.put:
      final headers = context.request.headers;
      print('Headers $headers ');
      final body = context.request.json();
      print('Body of request $body');
      return Response(
          statusCode: 204,
          body:
              jsonEncode({'DateTime - PUT': DateTime.now().toIso8601String()}));
    default:
      return Response(
        statusCode: 405,
        body: jsonEncode({
          'error': 'Method not allowed',
        }),
      );
  }
}
