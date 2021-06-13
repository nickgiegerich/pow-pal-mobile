import 'package:flutter/material.dart';
import 'package:pow_pal_app/constants/styles/constants.dart';
import 'package:pow_pal_app/screens/signin_signup/signin_or_signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/welcome_image.png"),
                    fit: BoxFit.cover)),
          ),
          Container(
            child: Text(
              'Pow Pal',
              style: Theme.of(context)
                  .textTheme
                  .headline3
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            padding: EdgeInsets.symmetric(vertical: 60, horizontal: 25),
          ),
          Container(
            child: Text(
              'One stop for snotel data, avalanche reports, and more...',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(fontWeight: FontWeight.w400, color: Colors.black87),
            ),
            padding: EdgeInsets.symmetric(vertical: 150, horizontal: 25),
          ),
          Positioned(
              right: 25,
              bottom: 80,
              child: FittedBox(
                child: TextButton(
                  child: Row(
                    children: [
                      Text(
                        "Let's Go!",
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
                      builder: (context) => SigninOrSignup(),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
