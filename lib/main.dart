import 'package:flutter/material.dart';
import 'package:pow_pal_app/constants/styles/theme.dart';
import 'package:pow_pal_app/models/pow_pal_user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pow_pal_app/screens/welcome/wrapper.dart';
import 'package:pow_pal_app/services/auth.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<PowPalUser>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        title: "Pow Pal",
        debugShowCheckedModeBanner: false,
        theme: lightThemeData(context),
        darkTheme: darkThemeData(context),
        home: Wrapper(),
      ),
    );
  }
}
