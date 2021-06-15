import 'package:flutter/material.dart';
import 'package:pow_pal_app/components/primary_button.dart';
import 'package:pow_pal_app/constants/styles/constants.dart';
import 'package:pow_pal_app/screens/authenticate/register.dart';
import 'package:pow_pal_app/screens/authenticate/signin.dart';
import 'package:pow_pal_app/services/auth.dart';

import '../app.dart';

class SigninOrSignup extends StatefulWidget {
  const SigninOrSignup({Key key}) : super(key: key);

  @override
  _SigninOrSignupState createState() => _SigninOrSignupState();
}

class _SigninOrSignupState extends State<SigninOrSignup> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            children: [
              Spacer(flex: 2),
              PrimaryButton(
                text: "Sign In",
                press: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Signin(),
                  ),
                ),
              ),
              SizedBox(
                height: kDefaultPadding * 1.5,
              ),
              PrimaryButton(
                color: Theme.of(context).colorScheme.secondary,
                text: "Sign Up",
                press: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Register(),
                  ),
                ),
              ),
              Spacer(
                flex: 2,
              ),
              PrimaryButton(
                color: Theme.of(context).colorScheme.secondary,
                text: "Sign In Anon",
                press: () async {
                  dynamic result = await _auth.signInAnon();
                  if (result == null) {
                    print('Error signing in');
                  } else {
                    print('signed in');
                    print(result.uid);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
