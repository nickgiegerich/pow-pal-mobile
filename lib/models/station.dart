import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;



class Station { 
  final Map<String, dynamic> data;
  final int id;
  final String name;
  final double startSnowWaterEq;
  final double changeInSnowWaterEq;
  final double startSnowDepth;
  final double changeSnowDepth;

  Station(
          {this.data,
          this.name, 
          this.id, 
          this.startSnowWaterEq, 
          this.changeInSnowWaterEq, 
          this.startSnowDepth, 
          this.changeSnowDepth});
  
  factory Station.fromJson(Map<String, dynamic> json) { 
    return Station(
      data: {
        'name': json['name'],
        'id': json['id'],
        'startSnowWaterEq': json['start_snow_water_eq'],
        'changeInSnowWaterEq': json['change_snow_water_eq'],
        'startSnowDepth': json['start_snow_depth'],
        'changeSnowDepth': json['change_snow_depth'],
      }
    );
  }

  // static Station fetchByID(int stationID) { 
  //   List<Station> stations = Station.fetchAll();
  //   for (var i = 0; i < stations.length; i++) { 
  //     if (stations[i].id == stationID) { 
  //       return stations[i];
  //     }
  //   }
  //     return null;
  // }

// Future<Station> fetchStation() async {
//   final response =
//       await http.get('https://jsonplaceholder.typicode.com/albums/1');

//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     return Station.fromJson(jsonDecode(response.body));
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load album');
//   }
// }
}
 



