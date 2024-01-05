import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:uuid/uuid.dart';

import '../../database/connection/database_client.dart';
import '../../exections/base_api_exeptions.dart';
import '../../models/access_token.dart';
import '../../models/user.dart';
import '../../repositories/auth_repository.dart';
import '../../repositories/user_repository.dart';
import '../../utils/jwt_manager.dart';
// import '../../repositories/user_repository.dart';

Future<Response> onRequest(RequestContext context) async {
  final method = context.request.method;
  if (method != HttpMethod.post) {
    return Response(
      statusCode: 405,
      body: jsonEncode({'error': 'Invalid method'}),
    );
  }
  // 1-TODO: check the body
  final body = await context.request.json() as Map<String, String>;
  if (!_isBodyValid(body)) {
    return Response(
      statusCode: 400,
      body: jsonEncode({'error': 'Invalid body'}),
    );
  }

  // 2-TODO: Create user ID
  final userID = const Uuid().v4();
  body['id'] = userID;
  final user = User.create(body);

  // 3-TODO: The email doesn't exist in the data base
  final authRepo = context.read<AuthRepository>();

  final userRepository = context.read<UserRepository>();
  final existEmail = await userRepository.checkIfEmailExists(user.email);
  if (existEmail) {
    return Response(
      statusCode: 409,
      body: jsonEncode({'error': ' Email Register already exists'}),
    );
  }

  // 4-TODO: Enter the number in data base
  try {
    await userRepository.create(user);
  } catch (error) {
    if (error is BaseApiException ){
      return error.response();
    }
  }

  // 5-TODO: Generate the authentication token
  final jwtManager = context.read<JWTManager>();
    final payload = {'uid': userID};
    final jwtData =jwtManager.sing(payload);

  final accessToken = AccessToken(
    id: const Uuid().v4(),
    token: jwtData.token,
    expiration: jwtData.expirationDate,
    userId: userID,
  );

  // 6-TODO: Enter the authentication token for the user
  final authRepository = AuthRepository(DatabaseClient.instance!);
  await authRepository.create(accessToken);

  // 7-TODO: sed the request
  return Response(body: accessToken.toJson());
}

bool _isBodyValid(Map<String, String> body) {
  final allowedFields = ['username', 'password', 'email'];
  for (final field in allowedFields) {
    if (body[field] == null) {
      return false;
    }
  }
  return true;
}
