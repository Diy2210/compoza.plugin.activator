import 'package:flutter/material.dart';

import 'package:activator/models/CurrentUser.dart';

class CurrentUserInfo extends StatelessWidget {
  final CurrentUser user;

  CurrentUserInfo(this.user);

    String setIcon() {
      String image = 'assets/images/activator_logo.png';
      switch (user.method) {
        case 'apple':
          image = 'assets/images/apple_logo.png';
          break;
        case 'facebook':
          image = 'assets/images/facebook.png';
          break;
        case 'google':
          image = 'assets/images/google_logo.png';
          break;
      }
      return image;
    }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none
          , children: [
            CircleAvatar(
              backgroundImage:
              user.method.isEmpty || user.avatar == null
                  ? const AssetImage('assets/images/user_unknown.png')
                  : NetworkImage(user.avatar),
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
                  width: 35,
                  height: 35,
                  color: Colors.white,
                  // child: Icon(
                  //   _methodIcon,
                  //   size: 28,
                  //   color: Theme.of(context).accentColor,
                  // ),
                  // child: new AssetImage(setIcon()),
                  // child: new Image.asset('assets/images/activator_logo.png')
                  // child: new Image(image: AssetImage(image))
                  child: Image(image: AssetImage(setIcon()))
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          constraints: BoxConstraints(maxWidth: 200),
          child: Column(
            children: [
              Text(
                user.name,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                user.email,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
