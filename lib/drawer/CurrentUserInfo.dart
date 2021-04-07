import 'package:flutter/material.dart';

import 'package:activator/models/CurrentUser.dart';

class CurrentUserInfo extends StatelessWidget {
  final CurrentUser user;

  CurrentUserInfo(this.user);

    String setIcon() {
      String image = 'assets/images/activator_logo.png';
       if(user.method == 'Facebook') {
        image = 'assets/images/facebook.png';
      } else if (user.method == 'Twitter') {
         image = 'assets/images/twitter_logo.png';
      } else if (user.method == 'Google') {
        image = 'assets/images/google_logo.png';
      }
      return image;
    }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            user.method.isEmpty || user.avatar == null
                ? CircleAvatar(
              backgroundImage:
              AssetImage('assets/images/user_unknown.png'),
              backgroundColor: Colors.grey[300],
              foregroundColor: Theme.of(context).primaryColor,
              radius: 60,
            )
                : ClipRRect(
              borderRadius: BorderRadius.circular(120),
              child: Container(
                width: 120,
                height: 120,
                color: Colors.white54,
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/user_unknown.png',
                  image: user.avatar,
                  fit: BoxFit.fill,
                ),
              ),
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
