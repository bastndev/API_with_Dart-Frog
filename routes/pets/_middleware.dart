import 'package:dart_frog/dart_frog.dart';

import '../../database/connection/database_client.dart';
import '../../middleware/auth_middleware.dart';
import '../../repositories/pet_repository.dart';

Handler middleware(Handler handler) {
  return handler.use(bearerAuthorizationMiddleware()).use(
        provider<PetRepository>(
          (context) => PetRepository(DatabaseClient.instance!),
        ),
      );
}
