import 'package:flutter/material.dart';
import 'package:pow_pal_app/api_calls/fetch_state_stations.dart';
import 'package:pow_pal_app/models/station_model.dart';
import 'package:http/http.dart' as http;

class StationListScreen extends StatefulWidget {
  String stateShortName;

  StationListScreen(this.stateShortName);

  @override
  _StationListScreenState createState() => _StationListScreenState();
}

class _StationListScreenState extends State<StationListScreen> {
  TextEditingController editingController = TextEditingController();
  List<StationModel> filteredStations;
  List<StationModel> stations;
  bool showSearchBar = false;

  void initState() {
    super.initState();
    fetchStateStations(http.Client(), widget.stateShortName)
        .then((stationList) {
      if (this.mounted) {
        setState(() {
          filteredStations = stationList;
          stations = stationList;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: buildAppBar(context),
      body: Container(
        child: Column(
          children: <Widget>[
            Visibility(
              child: Padding(
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
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0)))),
                ),
              ),
              visible: showSearchBar,
              replacement: const SizedBox.shrink(),
            ),
            Expanded(
              child: stations != null
                  ? ListView.builder(
                      itemCount: stations.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: ListTile(
                            title: Text(stations[index].name.toString()),
                          ),
                        );
                      })
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            )
          ],
        ),
      ),
    );
  }

  void _filterStations(value) {
    setState(() {
      stations = filteredStations
          .where((station) =>
              station.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  AppBar buildAppBar(context) {
    return AppBar(
      automaticallyImplyLeading: true,
      elevation: 3.0,
      title: Text(
        'Station Finder',
        style: Theme.of(context).appBarTheme.titleTextStyle,
      ),
      foregroundColor: Colors.black,
      actions: [
        RawMaterialButton(
          onPressed: () {
            setState(() {
              showSearchBar = !showSearchBar;
            });
          },
          elevation: 3.0,
          fillColor: Theme.of(context).scaffoldBackgroundColor,
          child: Icon(
            Icons.search_outlined,
            color: Theme.of(context).colorScheme.onBackground,
          ),
          shape: CircleBorder(
            side: BorderSide(
                width: 1.0, color: Theme.of(context).colorScheme.background),
          ),
        )
      ],
      leadingWidth: 26,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0),
            topLeft: Radius.circular(0),
            bottomRight: Radius.circular(5000)),
      ),
    );
  }
}
