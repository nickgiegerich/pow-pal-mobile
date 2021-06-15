import 'package:flutter/material.dart';
import 'package:pow_pal_app/models/pow_pal_user.dart';
import 'package:pow_pal_app/screens/authenticate/register.dart';
import 'package:pow_pal_app/screens/authenticate/signin.dart';
import 'package:pow_pal_app/screens/authenticate/signin_or_signup_screen.dart';
import 'package:pow_pal_app/screens/welcome/welcome_screen.dart';
import 'package:provider/provider.dart';

import '../app.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<PowPalUser>(context);
    print(user);


    if (user == null) {
      return Register();
    } else {
      return App();
    }
  }
}
