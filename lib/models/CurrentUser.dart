import 'dart:convert';
import 'package:hive/hive.dart';

class CurrentUser {
  @HiveType(typeId: 0)
  final String name;
  @HiveType(typeId: 1)
  final String email;
  @HiveType(typeId: 2)
  final String avatar;
  @HiveType(typeId: 3)
  final String method;

  CurrentUser({
    this.name = 'Anonimous',
    this.email = '',
    this.avatar = '',
    this.method = '',
  });

  static CurrentUser fromString(String userData) {
    final Map<String, dynamic> _user = json.decode(userData);
    return CurrentUser(
      name: _user['name'] ?? 'Anonimous',
      email: _user['email'] ?? '',
      avatar: _user['avatar'] ?? '',
      method: _user['method'] ?? '',
    );
  }

  @override
  String toString() {
    return json.encode({
      'name': name,
      'email': email,
      'avatar': avatar,
      'method': method,
    });
  }
}
