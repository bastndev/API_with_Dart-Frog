import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';

import '../../../exections/base_api_exeptions.dart';
import '../../../repositories/pet_repository.dart';

Future<Response> onRequest(
  RequestContext context,
  String id,
) async {
  final method = context.request.method;
  final petRepository = context.read<PetRepository>();
  switch (method) {
    case HttpMethod.get:
      return _getHandler(context, petRepository, id);
    case HttpMethod.put:
      final body = await context.request.json();
      if (body == null) {
        return Response(
          statusCode: 400,
          body: jsonEncode({'error': 'Bad request'}),
        );
      }
      if (!_checkPutBody(body as Map<String, dynamic>)) {
        return Response(
          statusCode: 400,
          body: jsonEncode({'error': 'Bad request'}),
        );
      }
      await petRepository.update(body, id);
      return Response(statusCode: 200, body: jsonEncode({'success': true}));
    case HttpMethod.delete:
      try {
        await petRepository.deleteOne(id);
        return Response(body: jsonEncode({'success': true}));
      } catch (err) {
        if(err is BaseApiException){
          return err.response();
        }
        return Response(statusCode: 500, body: 'Algo salio mal');
      }
    default:
      return Response(
        statusCode: 405,
        body: jsonEncode(
          {'error': 'method not supported'},
        ),
      );
  }
}

Future<Response> _getHandler(
  RequestContext context,
  PetRepository petRepository,
  String id,
) async {
  try {
    final result = await petRepository.getOne(id);
    return Response(body: jsonEncode(result));
  } catch (err) {
    if (err is BaseApiException) {
      return err.response();
    } else {
      return Response(statusCode: 500, body: 'something went wrong');
    }
  }
}

bool _checkPutBody(Map<String, dynamic> body) {
  final allowedFields = ['name', 'age', 'type'];

  for (final field in allowedFields) {
    if (body[field] == null) {
      return false;
    }
  }
  return true;
}
