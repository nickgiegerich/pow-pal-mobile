import 'package:flutter/material.dart';
import 'package:pow_pal_app/screens/favorites/favorites.dart';
import 'package:pow_pal_app/screens/geo_location_tag/geo_locator.dart';
import 'package:pow_pal_app/screens/user_profile/user_profile.dart';
import 'package:spincircle_bottom_bar/modals.dart';
import 'stations/stations.dart';
import 'station_detail/station_detail.dart';
import 'states/states.dart';
import 'map/map.dart';
import '../models/state_snotel.dart';
import 'package:spincircle_bottom_bar/spincircle_bottom_bar.dart';

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
    UserProfile(),
    GeoLocator()
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SpinCircleBottomBarHolder(
        bottomNavigationBar: buildBottomNavigationBar(context),
        child: screenList[pageIndex],
      ),
    );
  }

  SCBottomBarDetails buildBottomNavigationBar(BuildContext context) {
    return SCBottomBarDetails(
      elevation: 5,
      backgroundColor:
          Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      activeIconTheme:
          Theme.of(context).bottomNavigationBarTheme.selectedIconTheme,
      iconTheme: Theme.of(context).iconTheme,
      actionButtonDetails: SCActionButtonDetails(
        color: Theme.of(context).colorScheme.primaryVariant,
        elevation: null,
        icon: Icon(Icons.handyman),
      ),
      activeTitleStyle: TextStyle(
        color: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
      ),
      titleStyle: TextStyle(
        color: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
      ),
      circleColors: [
        Theme.of(context).colorScheme.primary,
        Theme.of(context).colorScheme.secondary,
        Theme.of(context).colorScheme.primaryVariant
      ],
      items: <SCBottomBarItem>[
        SCBottomBarItem(
            icon: Icons.wifi_tethering,
            title: "Stations",
            onPressed: () {
              setState(() {
                pageIndex = 0;
              });
            }),
        SCBottomBarItem(
            icon: Icons.star_border_outlined,
            title: "Favorites",
            onPressed: () {
              setState(() {
                pageIndex = 1;
              });
            }),
        SCBottomBarItem(
            icon: Icons.map_outlined,
            title: "Avy Map",
            onPressed: () {
              setState(() {
                pageIndex = 2;
              });
            }),
        SCBottomBarItem(
            icon: Icons.person,
            title: "Profile",
            onPressed: () {
              setState(() {
                pageIndex = 3;
              });
            }),
      ],
      circleItems: <SCItem>[
        SCItem(
            icon: Icon(Icons.gps_fixed_outlined),
            onPressed: () {
              setState(() {
                pageIndex = 4;
              });
            }),
        SCItem(
            icon: Icon(Icons.play_circle_outline_sharp),
            onPressed: () {
              setState(() {
                pageIndex = 3;
              });
            }),
        // SCItem(icon: Icon(Icons.person_add), onPressed: () {}),
      ],
    );
  }
}
