import 'package:flutter/material.dart';
import 'package:pow_pal_app/constants/styles/constants.dart';
import 'package:pow_pal_app/screens/authenticate/register.dart';
import 'package:pow_pal_app/services/auth.dart';

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final AuthService _auth = AuthService();

  String email = '';
  String password = '';

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
          child: Column(
            children: [
              SizedBox(
                height: kDefaultPadding * 3,
              ),
              TextFormField(
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
                  print(email);
                  print(password);
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
            ],
          ),
        ),
      ),
    );
  }
}
