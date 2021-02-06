import 'dart:ui';

import 'package:flutter/material.dart';
import 'screens/stations/stations.dart';
import 'screens/station_detail/station_detail.dart';
import 'screens/states/states.dart';
import 'screens/map/map.dart';
import 'models/state_snotel.dart';
import 'package:location/location.dart';
import 'style.dart';

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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: _routes(),
      home: DefaultTabController(
          length: 3,
          child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              title: Text(
                'POW PAL',
                style: AppBarTextStyle,
              ),
              toolbarOpacity: 1.0,
              bottomOpacity: 1.0,
              backgroundColor: Colors.transparent,
              actions: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Icon(Icons.info_outline),
                  
                ),
                
              ],
            
              // backgroundColor: Colors.white,
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(35),
                ),
              ),
              bottom: TabBar(
                labelColor: tabBarDarkTheme().labelColor,
                unselectedLabelColor: tabBarDarkTheme().unselectedLabelColor,
                indicator: tabBarDarkTheme().indicator,
                tabs: myTabs,
                indicatorPadding:
                    EdgeInsets.only(left: 15.0, right: 100.0, top: 100),
              ),
            ),
            // floatingActionButton: FloatingActionButton(
            //   backgroundColor: const Color(0xff03dac6),
            //   foregroundColor: Colors.black,
            //   onPressed: () {
            //     // Respond to button press
            //   },
            //   child: Icon(Icons.add),
            //   isExtended: true,
            // ),
            body: TabBarView(
              children: [
                StateSnotelPage(),
                Icon(Icons.star_border),
                Map(),
              ],
            ),
          )),
      title: 'Snotel Stations',
      theme: theme(),
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
