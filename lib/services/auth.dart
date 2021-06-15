import 'package:firebase_auth/firebase_auth.dart';
import 'package:pow_pal_app/models/pow_pal_user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

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

  // register with email
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;

      return _powPalUserFromUser(user);
    } catch (e) {
      print('This is the error: ' + e.toString());
      print(e.runtimeType);
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
