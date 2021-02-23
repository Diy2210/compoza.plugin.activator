import 'dart:convert';

class CurrentUser {
  final String name;
  final String email;
  final String avatar;
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
