import 'package:flutter/material.dart';
import 'package:pow_pal_app/constants/styles/constants.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightThemeData(BuildContext context) {
  return ThemeData.light().copyWith(
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: kScaffoldBackgroundLightTheme,
    appBarTheme: AppBarTheme(
      centerTitle: false,
      elevation: 5,
      color: kAppBarLightTheme,
      titleTextStyle: TextStyle(color: Colors.black87),
    ),
    iconTheme: IconThemeData(color: kContentColorLightTheme),
    textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme)
        .apply(bodyColor: kContentColorLightTheme),
    colorScheme: ColorScheme.light(
        primary: kPrimaryColor,
        secondary: kSecondaryColor,
        error: kErrorColor,
        onBackground: kOnBackgroundLightThemeColor),
    cardTheme: CardTheme(
      color: kContentColorDarkTheme,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          bottomLeft: Radius.circular(50),
          topRight: Radius.circular(0),
          bottomRight: Radius.circular(0),
        ),
        side: BorderSide(width: 0, color: kPrimaryColor),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: kAppBarLightTheme,
        selectedItemColor: kContentColorLightTheme.withOpacity(0.7),
        unselectedItemColor: kContentColorLightTheme.withOpacity(0.32),
        selectedIconTheme: IconThemeData(color: kPrimaryColor),
        showSelectedLabels: true),
  );
}

ThemeData darkThemeData(BuildContext context) {
  // Bydefault flutter provie us light and dark theme
  // we just modify it as our need
  return ThemeData.dark().copyWith(
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: kScaffoldBackgroundDarkTheme,
    appBarTheme: AppBarTheme(
      centerTitle: false,
      elevation: 5,
      color: kAppBarDarkTheme,
      iconTheme: IconThemeData(color: kIconColorDarkTheme),
    ),
    iconTheme: IconThemeData(color: kContentColorDarkTheme.withOpacity(0.5)),
    textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme)
        .apply(bodyColor: kContentColorDarkTheme),
    colorScheme: ColorScheme.dark().copyWith(
        primary: kPrimaryColor,
        primaryVariant: kAppBarDarkTheme,
        secondary: kSecondaryColor,
        error: kErrorColor,
        onBackground: kOnBackgroundDarkThemeColor,
        background: kScaffoldBackgroundDarkTheme),
    cardTheme: CardTheme(
      color: kContentColorLightTheme,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(0),
          bottomLeft: Radius.circular(0),
          topRight: Radius.circular(0),
          bottomRight: Radius.circular(0),
        ),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: kScaffoldBackgroundDarkTheme,
      selectedItemColor: Colors.white,
      unselectedItemColor: kContentColorDarkTheme.withOpacity(0.32),
      selectedIconTheme: IconThemeData(color: kIconColorDarkTheme),
      showUnselectedLabels: true,
    ),
  );
}

final appBarTheme = AppBarTheme(centerTitle: false, elevation: 3);
