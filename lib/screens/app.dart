import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pow_pal_app/constants/styles/constants.dart';
import 'package:pow_pal_app/screens/favorites/favorites.dart';
import 'stations/stations.dart';
import 'station_detail/station_detail.dart';
import 'states/states.dart';
import 'map/map.dart';
import '../models/state_snotel.dart';
import 'package:location/location.dart';
import '../constants/styles/style.dart';

const StatesRoute = '/';
const StationsRoute = '/stations';
const StationDetailRoute = '/station_detail';

class App extends StatefulWidget {
  @override
  AppState createState() => new AppState();
}

class AppState extends State<App> {
  final List<Widget> myTabs = [
    Tab(icon: Icon(Icons.wifi_tethering), text: 'stations'),
    Tab(icon: Icon(Icons.star_border), text: 'favorites'),
    Tab(icon: Icon(Icons.map), text: 'map'),
  ];
  int pageIndex = 0;
  List<Widget> screenList = <Widget>[
    StateSnotelPage(),
    Favorites(),
    Map(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screenList[pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:
            Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        selectedIconTheme:
            Theme.of(context).bottomNavigationBarTheme.selectedIconTheme,
        selectedItemColor:
            Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
        unselectedItemColor:
            Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
        currentIndex: pageIndex,
        onTap: (value) {
          setState(() {
            pageIndex = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.wifi_tethering), label: "Stations"),
          BottomNavigationBarItem(
              icon: Icon(Icons.star_border_outlined), label: "Favorites"),
          BottomNavigationBarItem(
              icon: Icon(Icons.map_outlined), label: "Avy Map"),
          BottomNavigationBarItem(
              icon: CircleAvatar(
                radius: 14,
              ),
              label: "Profile"),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: const Color(0xff03dac6),
      //   foregroundColor: Colors.black,
      //   onPressed: () {
      //     // Respond to button press
      //   },
      //   child: Icon(Icons.light_mode_rounded),
      //   isExtended: true,
      // ),
    );
  }

  RouteFactory _routes() {
    return (settings) {
      final Stations station = settings.arguments;
      final List<Stations> stateStations = settings.arguments;
      Widget screen;
      switch (settings.name) {
        case StatesRoute:
          screen = StateSnotelPage();
          break;
        case StationsRoute:
          screen = SnotelStations(stateStations);
          break;
        case StationDetailRoute:
          screen = StationDetail(station);
          break;
        default:
          return null;
      }
      return MaterialPageRoute(builder: (BuildContext context) => screen);
    };
  }
}
