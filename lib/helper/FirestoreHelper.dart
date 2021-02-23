import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:activator/models/Server.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreHelper {

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<DocumentSnapshot> getUserData(String userId) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get();
  }

  Future<void> setUserData(
      String userId,
      String username,
      String email,
      ) async {
    return await FirebaseFirestore.instance.collection('users').doc(userId).set(
      {
        'username': username,
        'email': email,
      },
    );
  }

  Stream<QuerySnapshot> getServers() {
    return firestore
        .collection('servers')
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser.uid)
        .snapshots();
  }

  static void addServer(Server server) {
    FirebaseFirestore.instance.collection('servers').add({
      'title': server.title,
      'url': server.url,
      'token': server.token,
      'serverID': server.serverID,
    });
  }

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

  static void deleteServer(Server server) {
    FirebaseFirestore.instance
        .collection('servers')
        .doc(server.serverID)
        .delete();
  }
}
