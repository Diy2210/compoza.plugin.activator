import 'package:activator/localization.dart';
import 'package:hive/hive.dart';
import 'package:activator/models/CurrentUser.dart';
import 'FirestoreService.dart';

class UserDataService {
  late Box<CurrentUser> _currentUser;

  ///Save user to Hive box
  void saveUser(CurrentUser user) {
    _currentUser = Hive.box<CurrentUser>('user_db');
    _currentUser.put('user', user);
  }

  ///Get user from Hive box
  CurrentUser? getUser() {
    _currentUser = Hive.box<CurrentUser>('user_db');
    return _currentUser.get('user');
  }

  Future<void> cacheUserData(String method, dynamic signedInUser) async {
    CurrentUser currentUser;
    final firestoreHelper = FirestoreService();
    final user = await firestoreHelper.getUserData(signedInUser.uid);
    if (!user.exists) {
      firestoreHelper.setUserData(
          signedInUser.uid, signedInUser.displayName, signedInUser.email);
      currentUser = CurrentUser(
          userId: signedInUser.uid,
          name: signedInUser.displayName,
          email: signedInUser.email ?? '',
          avatar: signedInUser.photoURL,
          method: method);
    } else {
      currentUser = CurrentUser(
        userId: signedInUser.uid,
        name: user.data()!['username'] ?? 'Anonymous'.i18n,
        email: signedInUser.email ?? '',
        avatar: signedInUser.photoURL,
        method: method,
      );
    }
    saveUser(currentUser);
  }

  Future<void> exit() async {
    await Hive.box<CurrentUser>('user_db').clear();
  }
}
