import 'package:flutter/material.dart';
import 'package:pow_pal_app/api_calls/fetch_all_stations.dart';
import 'package:pow_pal_app/models/station.dart';
import '../../models/state.dart';
import '../stations/stations.dart';
import '../../api_calls/fetch_all_states.dart';

class States extends StatefulWidget {

  @override
  _StatesPageState createState() => _StatesPageState();
}




class _StatesPageState extends State<States> {
  List<StationState> listOfStates = [];
  List<Station> stations = [];

  @override
  void initState() { 
    super.initState();
    fetchAllStations().then((value){
      setState(() {
        stations = value;
        listOfStates = fetchAllStates(stations);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      appBar: AppBar(  
          title: Text('pick a state'),
        ),
      body: Container(  
        child: Column(  
          children: [
            Expanded(  
              child: ListView.builder(
                itemCount: listOfStates.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(  
                    child: ListTile(  
                      title: Text(listOfStates[index].name),
                      onTap: () {
                        Navigator.push( 
                          context,
                          new MaterialPageRoute(  
                                  builder: (context) =>
                                    Stations(listOfStates[index].stateStations)
                                  ),
                                );
                              },
                    ),
                  );
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}

