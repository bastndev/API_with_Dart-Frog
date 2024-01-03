import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context) {
  return Response(
    body: jsonEncode({
      'Hello': 'World',
    }),
    headers: {
      'Content-Type': 'application/json',
    },
  );
}
