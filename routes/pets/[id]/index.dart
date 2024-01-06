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
      try {
        final result =  await petRepository.getOne(id);
        return Response(body: jsonEncode(result));
      } catch (err) {
        if(err is BaseApiException){
          return err.response();
        }else{
          return Response(statusCode: 500, body: 'something went wrong');
        }
      }
    case HttpMethod.put:
    case HttpMethod.delete:
    default:
      return Response(
        statusCode: 405,
        body: jsonEncode(
          {'error': 'method not supported'},
        ),
      );
  }
}
