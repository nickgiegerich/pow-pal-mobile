import 'dart:ffi';

import 'package:flutter/material.dart';
import '../../app.dart';
import '../../models/station.dart';

class Stations extends StatelessWidget {
  Map<String, dynamic> station;

  Stations(this.station);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(  
        shrinkWrap: true,
        itemCount: station.length,
        itemBuilder: (context, index) {
          String key = station.keys.elementAt(index);

          return Row(  
            children: <Widget>[
              Padding(  
                padding: EdgeInsets.all(15.0),
              ),
              Text('$key : '),
              Text(station[key].toString())
            ],
          );
        }),
      );
  }

  // _onLocationTap(BuildContext context, stationID) {
  //   Navigator.pushNamed(context, StationDetailRoute, arguments: {'id': stationID});
  // }
}