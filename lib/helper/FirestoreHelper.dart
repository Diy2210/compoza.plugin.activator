import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:activator/models/Server.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreHelper {

  UserCredential userCredential;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  //Get user
  Future<DocumentSnapshot> getUserData(String userId) async {
    return await _firebaseFirestore
        .collection('users')
        .doc(userId)
        .get();
  }

  //Save user to db
  Future<void> setUserData(String userID, username, email, emailVerified) async {
    return await _firebaseFirestore.collection('users').doc(userID).set(
      {
        'username': username,
        'email': email,
        'emailVerified': emailVerified
      },
    );
  }

  // //Register new user
  // Future<void> createNewUser(String email, username, password) async {
  //   userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
  //       email: email,
  //       password: password
  //   );
  //   setUserData(userCredential.user.uid, username, email);
  // }
  //
  // //Check email
  //
  //
  // //Reset password
  // @override
  // Future<void> resetPassword(String email) async {
  //   await _firebaseAuth.sendPasswordResetEmail(email: email);
  // }

  //Get all servers
  Stream<QuerySnapshot> getServers() {
    return FirebaseFirestore.instance
        .collection('servers')
        .where('userID', isEqualTo: _firebaseAuth.currentUser.uid)
        .snapshots();
  }

  //Add new server
  static void addServer(Server server) {
    FirebaseFirestore.instance.collection('servers').add({
      'title': server.title,
      'url': server.url,
      'token': server.token,
      'userID': FirebaseAuth.instance.currentUser.uid,
      'createdAt': DateTime.now().toIso8601String(),
    });
  }

  //Edit server
  static void editServer(Server server) {
    FirebaseFirestore.instance
        .collection('servers')
        .doc(server.serverID)
        .update({
      'title': server.title,
      'url': server.url,
      'token': server.token,
    });
  }

  //Delete server
  static void deleteServer(Server server) {
    FirebaseFirestore.instance
        .collection('servers')
        .doc(server.serverID)
        .delete();
  }
}
