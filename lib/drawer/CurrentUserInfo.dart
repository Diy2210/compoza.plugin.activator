import 'package:flutter/material.dart';

import 'package:activator/models/CurrentUser.dart';
import 'package:activator/icons/ActivatorApp.dart';

class CurrentUserInfo extends StatefulWidget {
  final CurrentUser user;

  CurrentUserInfo(this.user);

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<CurrentUserInfo> {
  IconData get _methodIcon {
    IconData icon = ActivatorApp.compoza;
    switch (widget.user.method) {
      case 'apple':
        icon = ActivatorApp.apple;
        break;
      case 'facebook':
        icon = ActivatorApp.facebook;
        break;
      case 'github':
        icon = ActivatorApp.github;
        break;
      case 'google':
        icon = ActivatorApp.google;
        break;
    }
    return icon;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          overflow: Overflow.visible,
          children: [
            CircleAvatar(
              backgroundImage:
              widget.user.method.isEmpty || widget.user.avatar.isEmpty
                  ? const AssetImage('assets/images/user_unknown.png')
                  : NetworkImage(widget.user.avatar),
              backgroundColor: Colors.grey[300],
              foregroundColor: Theme.of(context).primaryColor,
              radius: 60,
            ),
            Positioned(
              right: -5,
              top: -5,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Container(
                  width: 40,
                  height: 40,
                  color: Colors.white,
                  child: Icon(
                    _methodIcon,
                    size: 28,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          widget.user.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          widget.user.email,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
