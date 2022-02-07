import 'package:flutter/material.dart';
import 'package:activator/models/CurrentUser.dart';

class CurrentUserInfo extends StatelessWidget {
  final CurrentUser? user;

  CurrentUserInfo(this.user);

  String setIcon() {
    String image = 'assets/images/activator_logo.png';
    if (user?.method == 'Facebook') {
      image = 'assets/images/facebook_logo.png';
    } else if (user?.method == 'Twitter') {
      image = 'assets/images/twitter_logo.png';
    } else if (user?.method == 'Apple') {
      image = 'assets/images/apple_logo.png';
    } else if (user?.method == 'Google') {
      image = 'assets/images/google_logo.png';
    }
    return image;
  }

  @override
  Widget build(BuildContext context) {
    var userAvatar, userName, userEmail;

    if(user?.avatar != null) {
      userAvatar = user?.avatar;
    }
    if(user?.name != null) {
      userName = user?.name;
    }
    if(user?.email != null) {
      userEmail = user?.email;
    }

    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            user?.method == null || user?.avatar == null
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
                        image: userAvatar,
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
                    width: 36,
                    height: 36,
                    color: Colors.white,
                    child: Image(image: AssetImage(setIcon()))),
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
                userName,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                userEmail,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
