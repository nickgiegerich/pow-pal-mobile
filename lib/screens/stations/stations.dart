import 'package:flutter/material.dart';
import '../../app.dart';
import '../../models/station.dart';

class Stations extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final stations = Station.fetchAll();


    return Scaffold(
      appBar: AppBar(  
        title: Text('Stations'),
      ),
      body: ListView(  
        children: stations.map((station) => GestureDetector(
          child: Text(station.name),
          onTap: () => _onLocationTap(context, station.id),
          ))
          .toList(),
      )
    );
  }

  _onLocationTap(BuildContext context, stationID) {
    Navigator.pushNamed(context, StationDetailRoute, arguments: {'id': stationID});
  }
}