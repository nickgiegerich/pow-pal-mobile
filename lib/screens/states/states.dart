import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pow_pal_app/api_calls/fetch_all_stations.dart';
import 'package:pow_pal_app/constants/styles/constants.dart';
import 'package:pow_pal_app/constants/styles/style.dart';
import '../stations/stations.dart';
import '../../models/state_snotel.dart';
import 'package:http/http.dart' as http;

class StateSnotelPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: buildAppBar(context),
      body: Container(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<StateSnotel>>(
                future: fetchStateSnotels(http.Client()),
                builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);

                  return snapshot.hasData
                      ? StateList(states: snapshot.data)
                      : Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
      // backgroundColor: kContentColorLightTheme.withOpacity(0.9),
    );
  }
}

class StateList extends StatelessWidget {
  final List<StateSnotel> states;

  StateList({Key key, this.states}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: states.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          // shadowColor: Color(0xFF5b5b10).withOpacity(1.0),
          color: Theme.of(context).cardTheme.color,
          shape: Theme.of(context).cardTheme.shape,
          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
          elevation: 5,
          child: ListTile(
            // tileColor: listTileTheme().tileColor,
            shape: listTileTheme().shape,
            contentPadding: listTileTheme().contentPadding,
            title: Text(
              states[index].state.toString(),
              style: TextStyle(
                  // color: kContentColorDarkTheme,
                  fontSize: 21.0,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onBackground),
            ),
            subtitle: Text(states[index].stations.length.toString() + " stations"),
            trailing: Icon(
              Icons.arrow_forward_ios_sharp,
              color: Theme.of(context).colorScheme.secondary,
            ),
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => SnotelStations(states[index].stations),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

AppBar buildAppBar(context) {
  return AppBar(
    automaticallyImplyLeading: false,
    elevation: 3.0,
    title: Text(
      'Station Finder',
      style: Theme.of(context).appBarTheme.titleTextStyle,
    ),
    foregroundColor: Colors.black,
    actions: [
      RawMaterialButton(
        onPressed: () {},
        elevation: 3.0,
        fillColor: Theme.of(context).scaffoldBackgroundColor,
        child: Icon(
          Icons.search_outlined,
          color: Theme.of(context).colorScheme.onBackground,
        ),
        shape: CircleBorder(
          side: BorderSide(
              width: 1.0, color: Theme.of(context).appBarTheme.color),
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
