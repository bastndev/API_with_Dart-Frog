import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context) {
  final method = context.request.method;
  if (method != HttpMethod.post) {
    return Response(
      statusCode: 405,
      body: jsonEncode({'error': 'Invalid method'}),
    );
  }

  //1- get the body 

  //2- verify the body 

  //3- getByCredentials 

  //4- check token validity 

  //5- return response
  
  return Response(body: 'This is a new route!');
}
