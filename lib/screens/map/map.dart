import 'package:flutter/material.dart';
import 'dart:collection';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pow_pal_app/api_calls/fetch_all_avalanche.dart';
import 'package:pow_pal_app/models/avalanche_data.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

class Map extends StatefulWidget {
  final LocationData location;
  Map({this.location});

  @override
  State<Map> createState() => _MapPageState();
}

class _MapPageState extends State<Map> {
  // Location
  LatLng _initialcameraposition = LatLng(41.9622, -114.0081);
  GoogleMapController _controller;
  Location _location = Location();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  // Completer<GoogleMapController> _controller = Completer();
  List<AvalancheData> avyData;
  List<LatLng> _allDataPoints = List<LatLng>();

  Set<Polygon> _polygons = HashSet<Polygon>();

  String _avyDialog;
  // List<LatLng> polygonLatLngs = List<LatLng>();

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
            _allDataPoints.add(newPoint);
          }
          _setPolygon(data.name, polygonLatLngs);
        }
      });
    });
  }

  void _onMapCreated(GoogleMapController _cntlr) { 
    _controller = _cntlr;

    _location.onLocationChanged.listen((l) { 
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude, l.longitude),zoom: 1),
          ),
      );
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

  bool _getAddress(LatLng latLng) {
    for(var poly in _polygons){
      if (_checkIfValidMarker(latLng, poly.points)){
        String poly_id = poly.polygonId.toString();
        setState(() {
          _avyDialog = 'This dialog was opened by tapping on the polygon!\n'
                        'Polygon ID is $poly_id';
        });
        return true;
      }
    }
    return false;
  }

  bool _checkIfValidMarker(LatLng tap, List<LatLng> vertices) {
    int intersectCount = 0;
    for (int j = 0; j < vertices.length - 1; j++) {
      if (rayCastIntersect(tap, vertices[j], vertices[j + 1])) {
        intersectCount++;
      }
    }

    return ((intersectCount % 2) == 1); // odd = inside, even = outside;
  }

  bool rayCastIntersect(LatLng tap, LatLng vertA, LatLng vertB) {
    double aY = vertA.latitude;
    double bY = vertB.latitude;
    double aX = vertA.longitude;
    double bX = vertB.longitude;
    double pY = tap.latitude;
    double pX = tap.longitude;

    if ((aY > pY && bY > pY) || (aY < pY && bY < pY) || (aX < pX && bX < pX)) {
      return false; // a and b can't both be above or below pt.y, and a or
      // b must be east of pt.x
    }

    double m = (aY - bY) / (aX - bX); // Rise over run
    double bee = (-aX) * m + aY; // y = mx + b
    double x = (pY - bee) / m; // algebra is neat!

    return x > pX;
  }

  printToConsoleYes() { 
    print('this area is inside polygon');
  }

  printToConsoleNo() { 
    print('this area is outside polygon');
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
              initialCameraPosition: CameraPosition(target: _initialcameraposition),
              onMapCreated: _onMapCreated,
              polygons: _polygons,
              myLocationEnabled: true,
              onTap: (latLng) { 
                _getAddress(latLng) ? showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Text(_avyDialog,
                        ),
                  ))
                
                : printToConsoleNo();
              },
            )
          )
        ],
      )
    );
  }
}

const darkMapStyle = r'''
[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#212121"
      }
    ]
  },
  {
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#212121"
      }
    ]
  },
  {
    "featureType": "administrative",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "administrative.country",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "administrative.locality",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#bdbdbd"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#181818"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#1b1b1b"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#2c2c2c"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#8a8a8a"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#373737"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#3c3c3c"
      }
    ]
  },
  {
    "featureType": "road.highway.controlled_access",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#4e4e4e"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "transit",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#000000"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#3d3d3d"
      }
    ]
  }
]
''';