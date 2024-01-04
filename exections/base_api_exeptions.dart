import 'package:dart_frog/dart_frog.dart';

abstract interface class BaseApiException implements Exception{
  Response response();
}
