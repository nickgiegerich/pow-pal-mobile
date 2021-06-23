import 'package:flutter/material.dart';
import 'package:pow_pal_app/constants/styles/style.dart';
import '../../api_calls/fetch_all_stations.dart';
import '../station_detail/station_detail.dart';
import '../../screens/states/states.dart';
import '../../models/state_snotel.dart';
import '../../globals/global_favorites.dart' as global_fav;

// ignore: must_be_immutable
class SnotelStations extends StatefulWidget {
  List<Stations> stations;

  SnotelStations(this.stations);

  @override
  _StationsPageState createState() => _StationsPageState();
}

class _StationsPageState extends State<SnotelStations> {
  TextEditingController editingController = TextEditingController();
  List<Stations> filteredStation;
  // List<Stations> favoriteStations;
  bool favorite;
  // List<Station> stations = [];
  @override
  void initState() {
    super.initState();
    setState(() {
      filteredStation = widget.stations;
      // favoriteStations = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Snotel Stations',
          // style: AppBarTextStyle,
        ),
        toolbarHeight: 65,
        // backgroundColor: Colors.transparent,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
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
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            Expanded(
              child: widget.stations.length > 0
                  ? ListView.builder(
                      itemCount: widget.stations.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: ListTile(
                            // tileColor: listTileTheme().tileColor,
                            isThreeLine: true,
                            subtitle:
                                widget.stations[index].hourlyData.length != 0
                                    ? Text(
                                        "Current Snow Depth: " +
                                            widget
                                                .stations[index]
                                                .hourlyData[widget
                                                        .stations[index]
                                                        .hourlyData
                                                        .length -
                                                    1]
                                                .snowDepth
                                                .toString() +
                                            '\n' +
                                            "Current Temperature: " +
                                            widget
                                                .stations[index]
                                                .hourlyData[widget
                                                        .stations[index]
                                                        .hourlyData
                                                        .length -
                                                    1]
                                                .observedAirTemp
                                                .toString() +
                                            '\n' +
                                            "Current Temperature: " +
                                            widget
                                                .stations[index]
                                                .hourlyData[widget
                                                        .stations[index]
                                                        .hourlyData
                                                        .length -
                                                    1]
                                                .dateTime
                                                .toString(),
                                      )
                                    : Text("Current Snow Depth: N/A" +
                                        "\n" +
                                        "Current Temperature: N/A"),
                            contentPadding: listTileTheme().contentPadding,
                            title: Text(widget.stations[index].name),
                            trailing: IconButton(
                              icon: global_fav.favorites
                                      .contains(widget.stations[index])
                                  ? Icon(Icons.star)
                                  : Icon(Icons.star_border),
                              color: listTileTheme().iconColor,
                              onPressed: () {
                                setState(() {
                                  if (global_fav.favorites
                                      .contains(widget.stations[index])) {
                                    global_fav.favorites
                                        .remove(widget.stations[index]);
                                  } else {
                                    global_fav.favorites
                                        .add(widget.stations[index]);
                                  }
                                });
                              },
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) =>
                                        StationDetail(widget.stations[index])),
                              );
                            },
                          ),
                        );
                      })
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _filterStations(value) {
    setState(() {
      widget.stations = filteredStation
          .where((station) =>
              station.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }
}
