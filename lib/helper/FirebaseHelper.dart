import 'dart:convert';
import 'dart:math';
import 'package:activator/localization.dart';
import 'package:activator/models/SignInMethod.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:twitter_login/twitter_login.dart';

class FirebaseHelper {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  UserCredential? _userCredentials;
  String _signinMethod = '';

  Stream<User?> get authState => _firebaseAuth.authStateChanges();
  User? get currentUser => _firebaseAuth.currentUser;

  set signInMethod(String method) => _signinMethod = method;
  String get signInMethod => _signinMethod;

  ///Google SignIn
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  ///Facebook SignIn
  Future<UserCredential?> signInWithFacebook() async {
    dynamic result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      final AccessToken accessToken = result.accessToken;
      final OAuthCredential? facebookAuthCredential =
          FacebookAuthProvider.credential(accessToken.token);
      return await _firebaseAuth.signInWithCredential(facebookAuthCredential!);
    }
    return null;
  }

  ///New Twitter SignIn
  Future<UserCredential?> signInWithNewTwitter() async {
    final twitterLogin = TwitterLogin(
      apiKey: 'Hvf8HA3OI9J4haDnHEY6Cpxmv',
      apiSecretKey: 'Ecb0BqgFaw5diPR48VlmixiE3llNUOZgGQrZRs3my50Gk6uZuD',
      redirectURI: 'https://compozanet-activator.firebaseapp.com/__/auth/handler',
    );

    dynamic authResult = await twitterLogin.login();
    switch (authResult.status) {

    ///Success login
      case TwitterLoginStatus.loggedIn:
        OAuthCredential twitterAuthCredential = TwitterAuthProvider.credential(
            accessToken: authResult.authToken, secret: authResult.authTokenSecret);

        return await FirebaseAuth.instance.signInWithCredential(twitterAuthCredential);

    ///Canceled by user
      case TwitterLoginStatus.cancelledByUser:
        throw Exception('Cancelled by user');

    ///Error twitter app settings
      case TwitterLoginStatus.error:
        throw Exception('Check Twitter App Settings');
    }
    return _userCredentials;
  }


  ///Apple SignIn
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

  Future<UserCredential?> tryToLink(
    BuildContext context,
    String email,
    String password,
    AuthCredential credential,
  ) async {
    List<String> userSignInMethods =
        await _firebaseAuth.fetchSignInMethodsForEmail(email);
    if (userSignInMethods.first == 'google.com') {
      if ((_userCredentials = await signInWithGoogle()) != null) {
        return await _userCredentials?.user?.linkWithCredential(credential);
      }
    } else if (userSignInMethods.first == 'facebook.com') {
      if ((_userCredentials = await signInWithFacebook()) != null) {
        return await _userCredentials?.user?.linkWithCredential(credential);
      }
    } else if (userSignInMethods.first == 'twitter.com') {
      if ((_userCredentials = await signInWithNewTwitter()) != null) {
        return await _userCredentials?.user?.linkWithCredential(credential);
      }
    } else if (userSignInMethods.first == 'apple.com') {
      if ((_userCredentials = await signInWithApple()) != null) {
        return await _userCredentials?.user?.linkWithCredential(credential);
      }
    } else {
      throw Exception('Unsupported auth method'.i18n);
    }

    return null;
  }

  signOut() async {
    await _firebaseAuth.signOut();
    /// logout external provider
    if (_signinMethod == SignInMethod.facebook) {
      await FacebookAuth.instance.logOut();
    }
  }
}
