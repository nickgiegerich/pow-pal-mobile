import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pow_pal_app/models/pow_pal_user.dart';

import 'auth.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // user reference
  final AuthService _auth = AuthService();

  // collection reference
  final CollectionReference stationCollection =
      FirebaseFirestore.instance.collection('stations');

  Future updateUserData(
      String stationName, String stationsState, int stationId) async {
    return await stationCollection.doc(uid).set({
      'stationName': stationName,
      'stationsState': stationsState,
      'stationId': stationId
    });
  }

  // get station favorites stream
  Stream<QuerySnapshot> get stations {
    return stationCollection.snapshots();
  }

  Future<void> getUserData(PowPalUser user) async {
     await stationCollection.doc(user.uid).get().then(
          (value) => print(
            value.data(),
          ),
        );
  }
}
