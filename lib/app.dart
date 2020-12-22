import 'package:flutter/material.dart';
import 'package:pow_pal_app/models/station.dart';
import 'models/station.dart';
import 'screens/stations/stations.dart';
import 'screens/station_detail/station_detail.dart';
import 'screens/states/states.dart';

const StatesRoute = '/';
const StationsRoute = '/stations';
const StationDetailRoute = '/station_detail';

class App extends StatefulWidget { 
  @override
  AppState createState() => new AppState();
}

class AppState extends State<App> {

  @override
  Widget build(BuildContext context) { 
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: _routes(),
      home: DefaultTabController(  
        length: 3,
        child: Scaffold ( 
          appBar: AppBar(  
            bottom: TabBar(  
              tabs: [
                Tab(icon: Icon(Icons.wifi_tethering), 
                    text: 'stations',),
                Tab(icon: Icon(Icons.map), text: 'avy map'),
                Tab(icon: Icon(Icons.star_border), text: 'favorites',),
              ],
            ), 
            title: Text('PowPal'),
          ),
          body: TabBarView(  
            children: [
              States(),
              Icon(Icons.map),
              Icon(Icons.star_border),
            ],
          ),
        )
      ),
      title: 'Snotel Stations',
      theme: _theme(),
    );
  }

  RouteFactory _routes() {
    return(settings) {
      final Station station = settings.arguments;
      final List<Station> stateStations = settings.arguments;
      Widget screen;
      switch(settings.name) { 
        case StatesRoute:
          screen = States();
          break;
        case StationsRoute:
          screen = Stations(stateStations);
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