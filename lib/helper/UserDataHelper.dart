import 'package:hive/hive.dart';
import 'package:activator/models/CurrentUser.dart';

class UserDataHelper {
  Box<CurrentUser> _currentUser;

  void saveUser(CurrentUser user) {
    _currentUser = Hive.box<CurrentUser>('user_db');
    _currentUser.put('user', user);
  }

  CurrentUser getUser() {
    _currentUser = Hive.box<CurrentUser>('user_db');
    return _currentUser.get('user');
  }
}