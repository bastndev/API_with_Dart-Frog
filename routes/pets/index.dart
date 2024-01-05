import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  final method = context.request.method;
  if (method == HttpMethod.post) {
    final body = await context.request.json();
    if (body == null) {
      return Response(
        statusCode: 400,
        body: jsonEncode({'error': 'incorrect request'}),
      );
    }

    return Response(body: jsonEncode({'success': true}));
  }
  return Response(body: 'Bajo construction');
}
