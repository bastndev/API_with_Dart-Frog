import 'dart:convert';

class AccessToken {
  String id;
  String token;
  DateTime expiration;
  String userId;
  
  DateTime get expirationDate => expiration;
  
  AccessToken({
    required this.id,
    required this.token,
    required this.expiration,
    required this.userId,
  });


  set expirationDate(DateTime expirationDate) {}

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'token': token,
      'expiration_date': expiration.toIso8601String(),
      'user_id': userId,
    };
  }

  factory AccessToken.fromMap(Map<String, dynamic> map) {
    return AccessToken(
      id: map['id'] as String,
      token: map['token'] as String,
      expiration: DateTime.parse(map['expiration_date'] as String),
      userId: map['user_id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AccessToken.fromJson(String source) =>
      AccessToken.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AccessToken(id: $id, token: $token, expiration: $expiration, userId: $userId)';
  }
}
