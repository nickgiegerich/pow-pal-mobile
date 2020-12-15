import 'package:flutter/material.dart';
import 'package:pow_pal_app/models/station.dart';
import 'models/station.dart';
import 'screens/stations/stations.dart';
import 'screens/station_detail/station_detail.dart';

const StationsRoute = '/';
const StationDetailRoute = '/station_detail';

class App extends StatefulWidget { 
  @override
  AppState createState() => new AppState();
}

class AppState extends State<App> {

  @override
  Widget build(BuildContext context) { 
    return MaterialApp(  
      title: 'Snotel Stations',
      theme: _theme(),
      onGenerateRoute: _routes(),
    );
  }

  RouteFactory _routes() {
    return(settings) {
      final Station station = settings.arguments;
      List<Station> stations = [];
      Widget screen;
      switch(settings.name) { 
        case StationsRoute:
          screen = Stations(stations);
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

  ThemeData _theme() { 
    return ThemeData(  
      brightness: Brightness.dark,
      primaryColor: Colors.blueGrey,
      primarySwatch: Colors.blue,
    );
  }
}