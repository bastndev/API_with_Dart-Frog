import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';

import 'base_api_exeptions.dart';

class ServerException implements BaseApiException {
  final String message;
  static const int statusCode = 500;
  const ServerException(this.message);

  @override
  Response response() {
    return Response(
        statusCode: statusCode, body: jsonEncode({'error': message}));
  }
}
