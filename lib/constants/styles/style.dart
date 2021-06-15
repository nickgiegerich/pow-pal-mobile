import 'package:flutter/material.dart';

const LargeTextSize = 26.0;
const MediumTextSize = 20.0;
const ChartTitleSize = 23.0;

const String FontNameDefualt = 'Montserrat';
const Color ButtonColor = Color(0xFF3BBA9C);

const AppBarTextStyle = TextStyle(
  fontFamily: FontNameDefualt,
  fontWeight: FontWeight.w600,
  fontSize: LargeTextSize,
  color: Colors.white,
);

const TileTextStyle = TextStyle(
  fontFamily: FontNameDefualt,
  fontWeight: FontWeight.w300,
  fontSize: MediumTextSize,
  color: Colors.white,
);

const ChartTitleTextStyle = TextStyle(
  fontFamily: FontNameDefualt,
  fontWeight: FontWeight.w500,
  fontSize: ChartTitleSize,
  color: Colors.white,
);

ThemeData theme() {
  return ThemeData(
      brightness: Brightness.dark,
      primaryColor: Color(0xFF43455C),
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: Color(0xFF2E3047));
}

TabBarTheme tabBarDarkTheme() {
  return TabBarTheme(
    labelColor: Colors.black,
    unselectedLabelColor: Color(0xE6FFFFFF),
    indicator: ShapeDecoration(
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(35),
        ),
      ),
      // borderRadius: BorderRadius.circular(30),
      color: const Color(0xFF3BBA9C),
    ),
  );
}

ListTileTheme listTileTheme() {
  return ListTileTheme(
    tileColor: Color(0xFF3C3F58),
    iconColor: Color(0xFF3BBA9C),
    contentPadding: EdgeInsets.all(20),
    // shape: BorderRadius.all(),
    child: null,
  );
}
