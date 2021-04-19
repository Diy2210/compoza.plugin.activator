import 'dart:convert';
import 'dart:ffi';
import 'dart:math';

import 'package:activator/localization.dart';
import 'package:activator/models/SignInMethod.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

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
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  //Facebook SignIn
  Future<UserCredential> signInWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      final AccessToken accessToken = result.accessToken;
      final FacebookAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(accessToken.token);
      return await _firebaseAuth.signInWithCredential(facebookAuthCredential);
    }
    return null;
  }

  //Twitter SignIn
  Future<UserCredential> signInWithTwitter() async {
    final TwitterLogin twitterLogin = new TwitterLogin(
      consumerKey: 'Hvf8HA3OI9J4haDnHEY6Cpxmv',
      consumerSecret: 'Ecb0BqgFaw5diPR48VlmixiE3llNUOZgGQrZRs3my50Gk6uZuD',
    );

    final TwitterLoginResult loginResult = await twitterLogin.authorize();
    switch (loginResult.status) {
      case TwitterLoginStatus.loggedIn:
        var twitterSession = loginResult.session;
        final AuthCredential twitterAuthCredential =
            TwitterAuthProvider.credential(
          accessToken: twitterSession.token,
          secret: twitterSession.secret,
        );
        return await FirebaseAuth.instance
            .signInWithCredential(twitterAuthCredential);
        break;
      case TwitterLoginStatus.cancelledByUser:
        throw Exception('Cancelled by user'.i18n);
        break;
      case TwitterLoginStatus.error:
        throw Exception('Check Twitter App Settings'.i18n);
        break;
    }
  }

  //Apple SignIn
  String generateNonce([int length = 32]) {
    final charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<UserCredential> signInWithApple() async {
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
  }

  Future<UserCredential> tryToLink(
    BuildContext context,
    String email,
    String password,
    AuthCredential credential,
  ) async {
    List<String> userSignInMethods =
        await _firebaseAuth.fetchSignInMethodsForEmail(email);
    // remove unsupported auth method
    // if (Platform.isIOS) {
    //   if (userSignInMethods.contains('twitter.com')) {
    //     userSignInMethods.remove('twitter.com');
    //   }
    // }
    if (userSignInMethods.first == 'google.com') {
      if ((_userCredentials = await signInWithGoogle()) != null) {
        return await _userCredentials.user.linkWithCredential(credential);
      }
    } else if (userSignInMethods.first == 'facebook.com') {
      if ((_userCredentials = await signInWithFacebook()) != null) {
        return await _userCredentials.user.linkWithCredential(credential);
      }
    } else if (userSignInMethods.first == 'twitter.com') {
      if ((_userCredentials = await signInWithTwitter()) != null) {
        return await _userCredentials.user.linkWithCredential(credential);
      }
    } else if (userSignInMethods.first == 'apple.com') {
      if ((_userCredentials = await signInWithApple()) != null) {
        return await _userCredentials.user.linkWithCredential(credential);
      }
    } else {
      throw Exception('Unsupported auth method'.i18n);
    }

    return null;
  }

  Future<Void> signOut() async {
    await _firebaseAuth.signOut();
    // logout external provider
    if (_signinMethod == SignInMethod.facebook) {
      await FacebookAuth.instance.logOut();
    }
  }
}
