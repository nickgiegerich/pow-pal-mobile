import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pow_pal_app/constants/styles/constants.dart';
import 'package:pow_pal_app/models/pow_pal_user.dart';
import 'package:pow_pal_app/screens/authenticate/register.dart';
import 'package:pow_pal_app/services/auth.dart';

import '../app.dart';

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
        actions: [],
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: kDefaultPadding * 3,
                ),
                TextFormField(
                  validator: (val) => val.isEmpty ? 'Enter an email' : null,
                  onChanged: (val) {
                    setState(() {
                      email = val;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'example@blob.com',
                    labelText: 'Email',
                  ),
                ),
                SizedBox(
                  height: kDefaultPadding * 1.5,
                ),
                TextFormField(
                  validator: (val) => val.length < 6
                      ? 'Password must be at least 6 chars long'
                      : null,
                  obscureText: true,
                  onChanged: (val) {
                    setState(() {
                      password = val;
                    });
                  },
                  decoration: const InputDecoration(
                      hintText: 'must contain at least 10 characters',
                      labelText: 'Password'),
                ),
                SizedBox(
                  height: kDefaultPadding * 1.5,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      dynamic result = await _auth.signInWithEmailAndPassword(
                          email, password);

                      if (result.runtimeType == FirebaseAuthException) {
                        setState(() {
                          error = result.toString();
                        });
                      } else if (result.runtimeType == PowPalUser) {
                        return Navigator.pushReplacement(
                          context,
                          new MaterialPageRoute(
                            builder: (BuildContext context) => App(),
                          ),
                        );
                      }
                    }
                  },
                  child: Text("Sign In"),
                ),
                SizedBox(
                  height: kDefaultPadding * 1.5,
                ),
                FittedBox(
                  child: TextButton(
                    child: Row(
                      children: [
                        Text(
                          "Don't have an account? Register",
                          style: TextStyle(color: Colors.black),
                        ),
                        SizedBox(width: kDefaultPadding),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Colors.black,
                        )
                      ],
                    ),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Register(),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: kDefaultPadding * 1.5,
                ),
                Text(
                  error,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                      fontSize: 14.0),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
