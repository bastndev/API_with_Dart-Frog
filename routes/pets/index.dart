import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';
import 'package:uuid/uuid.dart';

import '../../repositories/pet_repository.dart';

Future<Response> onRequest(RequestContext context) async {
  final method = context.request.method;
  print(context.request.uri.queryParameters);
  if (method == HttpMethod.post) {
    return _posPet(context);
  } else if (method == HttpMethod.get) {
    print(_getSearchQuery(context.request.uri.queryParameters));
    //Lo normal sea hacer una paginacion
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

String _getSearchQuery(Map<String, String> params) {
  final allowedParamas = [
    'name',
    'age',
    'type',
  ];

  final addedParams = <String>[];

  for (final param in params.keys) {
    if (allowedParamas.contains(param)) {
      addedParams.add(param);
    }
  }

  var sql = 'SELECT * FROM  pets';
  if (addedParams.isNotEmpty) {
    sql = '$sql WHERE';
  }

  for (var i = 0; i < addedParams.length; i++) {
    final param = addedParams[i];
    final value = params[param];
    if (i == addedParams.length - 1) {
      sql = '$sql $param LIKE "%$value%"';
    } else {
      sql = '$sql $param LIKE "%$value%" OR ';
    }
  }
  return sql;
}
