import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pow_pal_app/models/station.dart';

Future<List<Station>> fetchStation() async {
  final response = 
    await http.get(Uri.encodeFull('http://127.0.0.1:8000/stations/'), headers:{"Accept":"application/json"});

  if(response.statusCode == 200) { 
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return userFromJson(response.body);
  }else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load stations');
  }
}

List<Station> userFromJson(String str) => List<Station>.from(json.decode(str).map((x) => Station.fromJson(x)));
String userToJson(List<Station> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class Station {
  final int id;
  final String name;
  final double startSnowWaterEq;
  final double changeInSnowWaterEq;
  final double startSnowDepth;
  final double changeSnowDepth;

  Station(
        {this.name, 
        this.id, 
        this.startSnowWaterEq, 
        this.changeInSnowWaterEq, 
        this.startSnowDepth, 
        this.changeSnowDepth});
  
  factory Station.fromJson(Map<String, dynamic> json) => Station( 
      id : json['id'], 
      name : json['name'],
      startSnowWaterEq : json['start_snow_water_eq'], 
      changeInSnowWaterEq : json['change_snow_water_eq'],
      startSnowDepth : json['start_snow_depth'],
      changeSnowDepth : json['change_snow_depth'],
  );

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'startSnowWaterEq' : startSnowWaterEq,
    'changeInSnowWaterEq' : changeInSnowWaterEq,
    'startSnowDepth' : startSnowDepth,
    'changeSnowDepth' : changeSnowDepth,
  };
}

class App extends StatefulWidget { 
  @override
  AppState createState() => new AppState();
}

class AppState extends State<App> { 

final String url = '';
Future<List<Station>> futureStation;

@override
void initState() { 
  super.initState();
  futureStation = fetchStation();
}


  @override
  Widget build(BuildContext context) { 
    return MaterialApp(  
      title: 'Snow Stations',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blueGrey,
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(  
        appBar: AppBar(  
          title: Text('Snow Stations'),
        ),
        body: Center(  
          child: FutureBuilder<List<Station>>(  
            future: futureStation,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) { 
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(  
                      title: Text(snapshot.data[index].name),
                      onTap: () {
                        Navigator.push( 
                          context,
                          new MaterialPageRoute(  
                            builder: (context) =>
                              DetailPage(snapshot.data[index])
                          )
                        );
                      },
                    );
                  }
                );
              } else if (snapshot.hasError) { 
                return Text("${snapshot.error}");
              }

              // by default show a loading spinner.
              return CircularProgressIndicator();
            }
          )
        )
      )
    );
  }
}

class DetailPage extends StatefulWidget {
  final Station station;

  DetailPage(this.station);

  @override
  _DetailPageState createState() => _DetailPageState();

}

class _DetailPageState extends State<DetailPage> { 
  @override
  Widget build(BuildContext context) { 
    return Scaffold(  
      appBar: AppBar(  
        title: Text(widget.station.name),
      ),
      body: Container( 
        padding: EdgeInsets.fromLTRB(10,10,10,0),
        height: 400,
        width: double.maxFinite,
        child: Card( 
          elevation: 5,
          child: Padding(
          padding: EdgeInsets.all(7),
          child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.centerRight,
              child: Stack(
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.only(left: 10, top: 5),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: RichText(  
                                  text: TextSpan(   
                                    text: widget.station.name,
                                    style: TextStyle(  
                                      fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
                                      children: <TextSpan>[ 
                                        TextSpan(   
                                          text: '\n ID: ' + widget.station.id.toString(),
                                          style: TextStyle(  
                                            color: Colors.grey,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold
                                          )
                                        )
                                      ]
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 5),
                            child: Text(
                              'Start of day snow water Eq\n ' + widget.station.startSnowWaterEq.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 22),
                              ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 5),
                            child: Text(
                              'Change in Snow Water Eq\n ' + widget.station.changeInSnowWaterEq.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 22, color: getColor(widget.station.startSnowWaterEq, widget.station.changeInSnowWaterEq)),
                              ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 5),
                            child: Text(
                              'Snow Depth Start of Day\n ' + widget.station.startSnowDepth.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 22),
                              ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 5),
                            child: Text(
                              'Change in Snow Depth\n ' + widget.station.changeSnowDepth.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 22, color: getColor(widget.station.startSnowDepth, widget.station.changeSnowDepth)),
                              ),
                          ),
                        ],
                      ))
                ],
              ),
            )
          ]),
          ),
        ),
      ),
    );
  }

  Color getColor(double startOfDay, double endOfDay) {
    if(startOfDay < endOfDay){
      return Color.fromRGBO(0, 255, 0, 1);
    }else { 
      return Color.fromRGBO(255, 0, 0, 1);
    }
  }
}