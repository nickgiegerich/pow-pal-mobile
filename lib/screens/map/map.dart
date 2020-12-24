import 'package:flutter/material.dart';
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
  Completer<GoogleMapController> _controller = Completer();
  Future<List<AvalancheData>> avyData;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  void initState() { 
    super.initState();
    avyData = fetchAvalancheData(http.Client());
    print(avyData);
  }

  @override
  Widget build(BuildContext context) { 
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.terrain,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}