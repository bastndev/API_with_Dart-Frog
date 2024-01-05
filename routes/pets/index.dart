import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';


Future<Response> onRequest(RequestContext context) async {
  final method = context.request.method;
  if(method == HttpMethod.post){
    return Response(body: jsonEncode({'success': true}));
  }
  return Response(body: 'Bajo construction');
}
