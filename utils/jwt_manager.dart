import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class JWTData {
  final String token;
  final DateTime expirationDate;

  const JWTData(this.token, this.expirationDate);
}

class JWTManager {
  final String key;

  const JWTManager(this.key);

  JWTData sing(Map<String, dynamic> playload) {
    final jwt = JWT(playload);
    const duration = Duration(hours: 12);
    final token = jwt.sign(SecretKey(key), expiresIn: duration);

    final jwtData = JWTData(token, DateTime.now().add(duration));
    return jwtData;
  }
}
