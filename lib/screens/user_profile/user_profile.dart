import 'package:flutter/material.dart';
import 'package:pow_pal_app/services/auth.dart';

class UserProfile extends StatelessWidget {

final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Profile"),
        actions: [
          RawMaterialButton(
            onPressed: () async {
              await _auth.signOut();
            },
            elevation: 3.0,
            fillColor: Theme.of(context).scaffoldBackgroundColor,
            child: Icon(
              Icons.logout_outlined,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            shape: CircleBorder(
              side: BorderSide(
                  width: 1.0, color: Theme.of(context).appBarTheme.color),
            ),
          ),
        ],
      ),
    );
  }
}
