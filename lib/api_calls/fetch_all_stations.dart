import 'package:dio/dio.dart';
import 'package:pow_pal_app/models/state.dart';
import 'package:pow_pal_app/models/station.dart';

Future fetchAllStations() async {
  final response = 
    await Dio().get('http://127.0.0.1:8000/stations/');

  final stateResponse = await Dio().get('http://127.0.0.1:8000/states/');

  if(response.statusCode == 200) { 
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var ret = response.data;

    var state_ret = stateResponse.data;

    print(state_ret);

    List<StationState> listOfStates = (state_ret as Iterable<dynamic> ?? const <dynamic> [])
    .map((dynamic jsonObject) => 
      StationState(
      jsonObject["state"] as String, 
      jsonObject["state_id"] as String, 
      jsonObject["stations"] as List<Station>
      )
    ).toList();

    print(listOfStates);

    List<Station> listOfStations = (ret as Iterable<dynamic> ?? const <dynamic> [])
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



    // some magic going on here but I will try to explain:
    // the response.data call turns the the data into list
    // of JSON objects by the are of type <dynamic> so we have
    // to convert each one on the list to type <Station> and then
    // send that back as a list
    return listOfStations;

  }else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load stations');
  }
}