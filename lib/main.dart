import 'package:flutter/material.dart';
import 'package:pow_pal_app/constants/styles/theme.dart';
import 'package:pow_pal_app/screens/welcome/welcome_screen.dart';
import 'screens/app.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Pow Pal",
      debugShowCheckedModeBanner: false,
      theme: lightThemeData(context),
      darkTheme: darkThemeData(context),
      home: WelcomeScreen(),
    );
  }
}
