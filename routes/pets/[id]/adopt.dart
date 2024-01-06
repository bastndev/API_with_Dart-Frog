import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';

import '../../../exections/base_api_exeptions.dart';
import '../../../repositories/pet_repository.dart';

Future<Response> onRequest(
  RequestContext context,
  String id,
) async {
  final userID = context.read<String>();
  final petResponsitory = context.read<PetRepository>();

  try {
    await petResponsitory.adopt(id, userID);
    return Response(body: jsonEncode({'success': true}));
  } catch (err) {
    if (err is BaseApiException) {
      return err.response();
    }
    return Response(statusCode: 500, body: 'This is NOT rout');
  }
}
