import 'dart:convert';
import 'package:crypto/crypto.dart' as crypto;
// import 'package:mysql_client/mysql_protocol.dart' as mysql;

class User {
  String id;
  String username;
  String email;
  String password;
  User({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
    };
  }

  factory User.create(Map<String, dynamic> map) {
    final digest = crypto.sha1.convert((map['password'] as String).codeUnits);
    map['password'] = digest.toString();
    return User.fromMap(map);
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      username: map['username'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, username: $username, email: $email, password: $password)';
  }
}
