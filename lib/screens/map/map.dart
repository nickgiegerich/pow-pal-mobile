import 'package:flutter/material.dart';
import 'dart:collection';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pow_pal_app/api_calls/fetch_all_avalanche.dart';
import 'package:pow_pal_app/models/avalanche_data.dart';
import 'package:http/http.dart' as http;

class Map extends StatefulWidget {
  @override
  State<Map> createState() => _MapPageState();
}

class _MapPageState extends State<Map> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Completer<GoogleMapController> _controller = Completer();
  List<AvalancheData> avyData;

  Set<Polygon> _polygons = HashSet<Polygon>();
  // List<LatLng> polygonLatLngs = List<LatLng>();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(42.115441, -116.915637),
    zoom: 6.5,
  );

  @override
  void initState() { 
    super.initState();
    fetchAvalancheData(http.Client()).then((avyDataList){
      setState(() {
        avyData = avyDataList;
        for(var data in avyDataList){
          List<LatLng> polygonLatLngs = List<LatLng>();
          for(var point in data.coordinates){
            LatLng newPoint = LatLng(point.lat, point.lon);
            polygonLatLngs.add(newPoint);
          }
          _setPolygon(data.name, polygonLatLngs);
        }
        for(var polyArea in _polygons){
          print(polyArea.points);
        }
      });
    });
  }

  void _setPolygon(String areaName, List<LatLng> points) {
    _polygons.add(Polygon(
      polygonId: PolygonId(areaName),
      points: points,
      strokeWidth: 2,
      strokeColor: Colors.blue,
      fillColor: Color(0xff9933).withOpacity(0.5),
    ));
  }

  @override
  Widget build(BuildContext context) { 
    return new Scaffold(
      key: _scaffoldKey,
      body: Stack(  
        children: <Widget>[
          Positioned.fill(
            child: GoogleMap( 
              mapType: MapType.terrain,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              polygons: _polygons,
            )
          )
        ],
      )
    );
  }
}