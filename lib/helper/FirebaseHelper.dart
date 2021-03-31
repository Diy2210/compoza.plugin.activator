import 'package:activator/models/CurrentUser.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:activator/helper/FirestoreHelper.dart';

class FirebaseHelper {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  UserCredential _userCredentials;
  String _signinMethod;

  Stream<User> get authState => _firebaseAuth.authStateChanges();
  User get currentUser => _firebaseAuth.currentUser;

  set signInMethod(String method) => _signinMethod = method;
  String get signInMethod => _signinMethod;

  //Register new user
  Future<void> createNewUser(String email, username, password, emailVerified) async {
    _userCredentials = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password
    );
    FirestoreHelper().setUserData(_userCredentials.user.uid, username, email, emailVerified);
    await verifiedEmail(_userCredentials);
  }

  //Check verified email
  Future<void> verifiedEmail(UserCredential userCredential) async {
    await userCredential.user.sendEmailVerification();
    return userCredential.user.uid;
  }

  //Reset password
  @override
  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  //Email SignIn
  Future<UserCredential> signInWithEmail(String email, String password) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> resetUserData(CurrentUser currentUser) async {
    await _firebaseAuth.currentUser.reload();
  }

  //Google SignIn
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  //Facebook SignIn
  Future<UserCredential> signInWithFacebook() async {
    final AccessToken accessToken = await FacebookAuth.instance.login();
    final FacebookAuthCredential facebookAuthCredential =
    FacebookAuthProvider.credential(accessToken.token);

    return await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  //Twitter SignIn
  Future<UserCredential> signInWithTwitter() async {
    final TwitterLogin twitterLogin = new TwitterLogin(
      consumerKey: 'Hvf8HA3OI9J4haDnHEY6Cpxmv',
      consumerSecret: 'Ecb0BqgFaw5diPR48VlmixiE3llNUOZgGQrZRs3my50Gk6uZuD',
    );

    final TwitterLoginResult loginResult = await twitterLogin.authorize();
    final TwitterSession twitterSession = loginResult.session;
    final AuthCredential twitterAuthCredential =
    TwitterAuthProvider.credential(accessToken: twitterSession.token, secret: twitterSession.secret);

    return await FirebaseAuth.instance.signInWithCredential(twitterAuthCredential);
  }

  Future<UserCredential> tryToLink(
      BuildContext context,
      String email,
      String password,
      AuthCredential credential,
      ) async {
    List<String> userSignInMethods =
    await _firebaseAuth.fetchSignInMethodsForEmail(email);
    if (userSignInMethods.first == 'password') {
      if ((_userCredentials = await signInWithEmail(email, password)) != null) {
        return await _userCredentials.user.linkWithCredential(credential);
      }
    }
    if (userSignInMethods.first == 'google.com') {
      if ((_userCredentials = await signInWithGoogle()) != null) {
        return await _userCredentials.user.linkWithCredential(credential);
      }
    }
    if (userSignInMethods.first == 'facebook.com') {
      if ((_userCredentials = await signInWithFacebook()) != null) {
        return await _userCredentials.user.linkWithCredential(credential);
      }
    }

    return null;
  }
}