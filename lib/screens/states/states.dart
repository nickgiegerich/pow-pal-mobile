import 'package:flutter/material.dart';
import 'package:pow_pal_app/api_calls/fetch_all_stations.dart';
import '../stations/stations.dart';
import '../../models/state_snotel.dart';
import 'package:http/http.dart' as http;

class StateSnotelPage extends StatelessWidget {

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
              child: FutureBuilder<List<StateSnotel>>(
                future: fetchStateSnotels(http.Client()),
                builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);

                  return snapshot.hasData ? StateList(states: snapshot.data) : Center(child: CircularProgressIndicator());
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class StateList extends StatelessWidget {
  final List<StateSnotel> states;

  StateList({ Key key, this.states}) : super(key: key);

  @override
  Widget build(BuildContext context) { 
    return ListView.builder(
      itemCount: states.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(  
          child: ListTile(  
            title: Text(states[index].state),
            onTap: () {
              Navigator.push( 
                context,
                new MaterialPageRoute(  
                  builder: (context) =>
                    SnotelStations(states[index].stations)
                )
              );
            },
          ),
        );
      },
    );
  }
}

