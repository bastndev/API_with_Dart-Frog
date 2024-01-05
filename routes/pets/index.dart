import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';
import 'package:uuid/uuid.dart';

import '../../repositories/pet_repository.dart';

Future<Response> onRequest(RequestContext context) async {
  final method = context.request.method;
  if (method == HttpMethod.post) {
    return _posPet(context);
  }
  return Response(body: 'Bajo construction');
}

Future<Response> _posPet(RequestContext context) async {
  final body = await context.request.json();
  if (body == null) {
    return Response(
      statusCode: 400,
      body: jsonEncode({'error': 'incorrect request'}),
    );
  }

  if (!_onPostPetValidation(body as Map<String, dynamic>)) {
    return Response(
      statusCode: 400,
      body: jsonEncode({'error': 'Body petition incorrect'}),
    );
  }

  final id = const Uuid().v4();
  body['id'] = id;

  final petRepository = context.read<PetRepository>();
  await petRepository.create(body);
  return Response(body: jsonEncode({'success': true}));
}

bool _onPostPetValidation(Map<String, dynamic> body) {
  final allowedFields = ['name', 'age', 'type', 'base64image'];

  for (final field in allowedFields) {
    final value = body[field];
    if (value == null) {
      return false;
    }
    if (field == 'base64image' &&
        value is String &&
        !value.startsWith('data:image')) {
      return false;
    }
  }
  return true;
}
