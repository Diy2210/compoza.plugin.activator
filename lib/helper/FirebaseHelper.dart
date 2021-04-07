import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';

class FirebaseHelper {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  UserCredential _userCredentials;
  String _signinMethod;

  Stream<User> get authState => _firebaseAuth.authStateChanges();
  User get currentUser => _firebaseAuth.currentUser;

  set signInMethod(String method) => _signinMethod = method;
  String get signInMethod => _signinMethod;

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
    if (loginResult.errorMessage != null) {
      throw Exception(loginResult.errorMessage);
    }
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
    if (userSignInMethods.first == 'twitter.com') {
      if ((_userCredentials = await signInWithTwitter()) != null) {
        return await _userCredentials.user.linkWithCredential(credential);
      }
    }

    return null;
  }
}