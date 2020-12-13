import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'style.dart';
import 'screens/stations/stations.dart';
import 'package:pow_pal_app/screens/station_detail/station_detail.dart';

const StationsRoute = '/';
const StationDetailRoute = '/station_detail';

class App extends StatelessWidget {
  @override
    Widget build(BuildContext context) { 
    // _fetchStations();
    return MaterialApp(
      onGenerateRoute: _routes(),
      theme: _theme(),
    );
  }

  RouteFactory _routes() { 
    return (settings) { 
      final Map<String, dynamic> arguments = settings.arguments;
      Widget screen;
      switch (settings.name) { 
        case StationsRoute:
          screen = Stations();
          break;
        case StationDetailRoute:
          screen = StationDetail(arguments['id']);
          break;
        default:
          return null;
      }
      return MaterialPageRoute(builder: (BuildContext context) => screen);
    };
  }

  ThemeData _theme() { 
    return ThemeData(
      appBarTheme: AppBarTheme(  
        textTheme: TextTheme(headline6: AppBarTextStyle),
        ),
        textTheme: TextTheme(
          headline6: TitleTextStyle,
          bodyText2: Body1TextStyle,
        ),
      );
    }

  // Future<http.Response> _fetchStations() {
  //   print(http.get('http://127.0.0.1:8000/station/').toString());
  //   return http.get('http://127.0.0.1:8000/station/');
  // }


}