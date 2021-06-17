import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pow_pal_app/models/pow_pal_user.dart';
import 'package:pow_pal_app/services/auth.dart';
import 'package:pow_pal_app/services/database.dart';
import 'package:provider/provider.dart';

import 'components/station_list.dart';

class Favorites extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<PowPalUser>(context);
    print(user.uid);
    DatabaseService(uid: user.uid).getUserData(user);
    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseService().stations,
      initialData: null,
      child: Scaffold(
        appBar: AppBar(
          title: Text(user.uid.toString()),
        ),
        body: StationList(),
      ),
    );
  }
}
