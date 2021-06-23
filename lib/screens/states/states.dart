import 'package:flutter/material.dart';
import 'package:pow_pal_app/api_calls/fetch_all_stations.dart';
import 'package:pow_pal_app/api_calls/fetch_states.dart';
import 'package:pow_pal_app/constants/styles/style.dart';
import 'package:pow_pal_app/models/state_model.dart';
import 'package:pow_pal_app/screens/stations/station_list_screen.dart';
import '../stations/stations.dart';
import '../../models/state_snotel.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
              child: FutureBuilder<List<StateModel>>(
                future: fetchStates(http.Client()),
                builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);

                  return snapshot.hasData
                      ? StateList(states: snapshot.data)
                      : Center(
                          child: SpinKitFoldingCube(
                            color: Theme.of(context).colorScheme.onBackground,
                            duration: const Duration(milliseconds: 1700),
                          ),
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StateList extends StatelessWidget {
  final List<StateModel> states;

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
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.white.withOpacity(0.3), width: 3.0),
              ),
            ),
            child: ListTile(
              // tileColor: listTileTheme().tileColor,
              shape: listTileTheme().shape,
              contentPadding: listTileTheme().contentPadding,
              title: Text(
                states[index].fullName.toString(),
                style: TextStyle(
                    // color: kContentColorDarkTheme,
                    fontSize: 21.0,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle:
                  Text(states[index].stationCount.toString() + " stations"),
              trailing: Icon(
                Icons.arrow_forward_ios_sharp,
                color: Theme.of(context).colorScheme.secondary,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (context) =>
                        StationListScreen(states[index].shortName.toString()),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

AppBar buildAppBar(context) {
  return AppBar(
    automaticallyImplyLeading: false,
    elevation: 0.0,
    title: Text(
      'Station Finder',
      style: Theme.of(context).appBarTheme.titleTextStyle,
    ),
    foregroundColor: Colors.black,
    actions: [
      MaterialButton(
        onPressed: () {},
        elevation: 3.0,
        color: Theme.of(context).appBarTheme.iconTheme.color,
        child: Icon(
          Icons.search_outlined,
          color: Theme.of(context).colorScheme.onBackground,
        ),
        shape: CircleBorder(
          side: BorderSide(
              width: 6.0, color: Theme.of(context).colorScheme.background),
        ),
      )
    ],
    leadingWidth: 26,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(0),
        topLeft: Radius.circular(0),
        bottomRight: Radius.circular(5000),
      ),
    ),
  );
}
