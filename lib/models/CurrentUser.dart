import 'dart:convert';
import 'package:hive/hive.dart';

import 'SignInMethod.dart';

part 'CurrentUser.g.dart';

@HiveType(typeId: 0)
class CurrentUser {
  @HiveField(0)
  final String userId;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String email;
  @HiveField(3)
  final String avatar;
  @HiveField(4)
  final String method;

  CurrentUser({
    this.userId = '',
    this.name = 'Anonymous',
    this.email = '',
    this.avatar = '',
    this.method = SignInMethod.email,
  });
}
