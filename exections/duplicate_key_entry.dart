import 'dart:convert';

import 'package:dart_frog/src/_internal.dart';

import 'base_api_exeptions.dart';

class DuplicateKeyEntry implements BaseApiException {
  final String message;
  static const int statusCode = 409;
  const DuplicateKeyEntry(this.message);
  @override
  Response response() {
    return Response(
        statusCode: statusCode, body: jsonEncode({'error': message}));
  }
}
