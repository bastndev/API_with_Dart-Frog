import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';

Future <Response> onRequest(RequestContext context) async{
  final method = context.request.method;
  if (method != HttpMethod.post) {
    return Response(
      statusCode: 405,
      body: jsonEncode({'error': 'Invalid method'}),
    );
  }

  //1- get the body 
  final body = context.request.json() as Map<String, String>;
  //2- verify the body 

  //3- getByCredentials 

  //4- check token validity 

  //5- return response

  return Response(body: 'This is a new route!');
}

bool _isBodyValid(Map<String, String> body) {
  final allowedFields = ['email','password'];
  for (final field in allowedFields) {
    if (body[field] == null) {
      return false;
    }
  }
  return true;
}
