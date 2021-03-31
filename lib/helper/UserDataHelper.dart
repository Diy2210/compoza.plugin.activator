import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:activator/models/CurrentUser.dart';

import 'FirestoreHelper.dart';

class UserDataHelper {
  Box<CurrentUser> _currentUser;

  //Save user to Hive box
  void saveUser(CurrentUser user) {
    _currentUser = Hive.box<CurrentUser>('user_db');
    _currentUser.put('user', user);
  }

  //Get user from Hive box
  CurrentUser getUser() {
    _currentUser = Hive.box<CurrentUser>('user_db');
    return _currentUser.get('user');
  }

  Future<void> cacheUserData(String method, User signedInUser) async {
    CurrentUser currentUser;
    final firestoreHelper = FirestoreHelper();
    final user = await firestoreHelper.getUserData(signedInUser.uid);
    if (!user.exists) {
      firestoreHelper.setUserData(
          signedInUser.uid,
          signedInUser.displayName,
          signedInUser.email,
          signedInUser.emailVerified);
    } else {
      currentUser = CurrentUser(
        userId: signedInUser.uid,
        name: user.data()['username'],
        email: signedInUser.email,
        avatar: signedInUser.photoURL,
        method: method,
        emailVerified: signedInUser.emailVerified.toString()
      );
    }
    saveUser(currentUser);
  }

  Future<void> exit() async {
    await Hive.box<CurrentUser>('user_db').clear();
  }
}