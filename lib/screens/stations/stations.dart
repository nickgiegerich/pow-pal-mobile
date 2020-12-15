import 'package:flutter/material.dart';
import '../../api_calls/fetch_all_stations.dart';
import '../../models/station.dart';
import '../station_detail/station_detail.dart';

// ignore: must_be_immutable
class Stations extends StatefulWidget { 
  List<Station> stations;

  Stations(this.stations);

  @override
  _StationsPageState createState() => _StationsPageState();

}

class _StationsPageState extends State<Stations> { 
  TextEditingController editingController = TextEditingController();
  List<Station> filteredStation;
  @override
  void initState() { 
    super.initState();
    fetchAllStations().then((data){
        setState(() {
          widget.stations = filteredStation = data;
        });
    });
  }

  @override
  Widget build(BuildContext context) { 
    return Scaffold(  
        appBar: AppBar(  
          title: Text('Snotel Stations'),
        ),
        body: Container(  
          child: Column(  
            children: <Widget>[
              Padding(  
                padding: const EdgeInsets.all(8.0),
                child: TextField(  
                  onChanged: (value) {
                    _filterStations(value);
                  },
                  controller: editingController,
                  decoration: InputDecoration(  
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(  
                      borderRadius: BorderRadius.all(Radius.circular(25.0))
                    )
                  ),
                )
              ),
              Expanded(  
                child: widget.stations.length > 0 ? ListView.builder(
                        itemCount: widget.stations.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(  
                            title: Text(widget.stations[index].name),
                            onTap: () {
                              Navigator.push( 
                                context,
                                new MaterialPageRoute(  
                                  builder: (context) =>
                                    StationDetail(widget.stations[index])
                                )
                              );
                            },
                          );
                        }):Center(
                          child: CircularProgressIndicator(),
                        ) 
              )
            ],
          )
        )
      );
  }

  void _filterStations(value) { 
    setState(() {
      widget.stations = filteredStation
      .where((station) => 
        station.name.toLowerCase().contains(value.toLowerCase())).toList();
    });
  }
}