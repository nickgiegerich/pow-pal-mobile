import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pow_pal_app/models/pow_pal_user.dart';
import 'package:pow_pal_app/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  // create user obj based on User (Firebase class)
  PowPalUser _powPalUserFromUser(User user) {
    return user != null ? PowPalUser(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<PowPalUser> get user {
    return _auth
        .authStateChanges()
        // .map((User user) => _powPalUserFromUser(user)); - does the same as the line below
        .map(_powPalUserFromUser);
  }

  // sign in anonymously
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _powPalUserFromUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _powPalUserFromUser(user);
    } catch (e) {
      return e;
    }
  }

  // register with email
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;

      // create a new document for the user with the uid
      await DatabaseService(uid: user.uid).updateUserData(null, null, null);

      return _powPalUserFromUser(user);
    } catch (e) {
      return e;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

