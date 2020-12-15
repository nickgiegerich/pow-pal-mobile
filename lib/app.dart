import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:pow_pal_app/models/station.dart';
import 'api_calls/fetch_all_stations.dart';
import 'models/station.dart';

class App extends StatefulWidget { 
  @override
  AppState createState() => new AppState();
}

class AppState extends State<App> {

TextEditingController editingController = TextEditingController();
List<Station> futureStation = [];
List<Station> filteredStation = [];

@override
void initState() { 
  super.initState();
  fetchAllStations().then((data){
      setState(() {
        futureStation = filteredStation = data;
      });
  });
}

void _filterStations(value) { 
  setState(() {
    filteredStation = futureStation
      .where((station) => 
        station.name.toLowerCase().contains(value.toLowerCase())).toList();
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
                            title: Text(filteredStation[index].name),
                            onTap: () {
                              Navigator.push( 
                                context,
                                new MaterialPageRoute(  
                                  builder: (context) =>
                                    DetailPage(filteredStation[index])
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