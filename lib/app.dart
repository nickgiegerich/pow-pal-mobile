import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:pow_pal_app/models/station.dart';

fetchStation() async {
  final response = 
    await Dio().get('http://127.0.0.1:8000/stations/');

  if(response.statusCode == 200) { 
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return response.data;
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

TextEditingController editingController = TextEditingController();
final String url = '';
List futureStation = [];
List filteredStation = [];

@override
void initState() { 
  super.initState();
  fetchStation().then((data){
      setState(() {
        futureStation = filteredStation = data;
      });
  });
}

void _filterStations(value) { 
  setState(() {
    filteredStation = futureStation
      .where((station) => 
        station['name'].toLowerCase().contains(value.toLowerCase())).toList();
  });
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
                child: filteredStation.length > 0 ? ListView.builder(
                        itemCount: filteredStation.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(  
                            title: Text(filteredStation[index]['name']),
                            onTap: () {
                              Navigator.push( 
                                context,
                                new MaterialPageRoute(  
                                  builder: (context) =>
                                    DetailPage(filteredStation[index]['name'],
                                              filteredStation[index]['id'],
                                              filteredStation[index]['start_snow_water_eq'],
                                              filteredStation[index]['change_snow_water_eq'],
                                              filteredStation[index]['start_snow_depth'],
                                              filteredStation[index]['change_snow_depth'],
                                              )
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
      )
    );
  }
}

class DetailPage extends StatefulWidget {
  final int id;
  final String name;
  final double startSnowWaterEq;
  final double changeInSnowWaterEq;
  final double startSnowDepth;
  final double changeSnowDepth; 

  DetailPage(this.name, 
        this.id, 
        this.startSnowWaterEq, 
        this.changeInSnowWaterEq, 
        this.startSnowDepth, 
        this.changeSnowDepth);

  @override
  _DetailPageState createState() => _DetailPageState();
  
}

class _DetailPageState extends State<DetailPage> { 
  @override
  Widget build(BuildContext context) { 
    return Scaffold(  
      appBar: AppBar(  
        title: Text(widget.name),
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
                                    text: widget.name,
                                    style: TextStyle(  
                                      fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
                                      children: <TextSpan>[ 
                                        TextSpan(   
                                          text: '\n ID: ' + widget.id.toString(),
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
                              'Start of day snow water Eq\n ' + widget.startSnowWaterEq.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 22),
                              ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 5),
                            child: Text(
                              'Change in Snow Water Eq\n ' + widget.changeInSnowWaterEq.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 22, color: getColor(widget.startSnowWaterEq, widget.changeInSnowWaterEq)),
                              ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 5),
                            child: Text(
                              'Snow Depth Start of Day\n ' + widget.startSnowDepth.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 22),
                              ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 5),
                            child: Text(
                              'Change in Snow Depth\n ' + widget.changeSnowDepth.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 22, color: getColor(widget.startSnowDepth, widget.changeSnowDepth)),
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