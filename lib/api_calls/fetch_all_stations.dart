import 'package:dio/dio.dart';
import 'package:pow_pal_app/models/station.dart';

Future fetchAllStations() async {
  final response = 
    await Dio().get('http://127.0.0.1:8000/stations/');

  if(response.statusCode == 200) { 
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var ret = response.data;

    // some magic going on here but I will try to explain:
    // the response.data call turns the the data into list
    // of JSON objects by the are of type <dynamic> so we have
    // to convert each one on the list to type <Station> and then
    // send that back as a list
    return (ret as Iterable<dynamic> ?? const <dynamic> [])
      .map((dynamic jsonObject) =>
        Station(
          jsonObject["name"] as String,
          jsonObject["id"] as int,
          jsonObject["start_snow_water_eq"] as double,
          jsonObject["change_snow_water_eq"] as double,
          jsonObject["start_snow_depth"] as double,
          jsonObject["change_snow_depth"] as double,
        )
      ).toList();
  }else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load stations');
  }
}