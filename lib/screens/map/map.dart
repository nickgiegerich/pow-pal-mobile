import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pow_pal_app/api_calls/fetch_all_avalanche.dart';
import 'package:pow_pal_app/models/avalanche_data.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/foundation.dart';

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

  String _alertTitle;
  String _alertBody;
  String _alertLink;
  Color _alertColor;
  // List<LatLng> polygonLatLngs = List<LatLng>();

  @override
  void initState() {
    super.initState();

    fetchAvalancheData(http.Client()).then((avyDataList) {
      if (this.mounted) {
        setState(() {
          avyData = avyDataList;
          for (var data in avyDataList) {
            List<LatLng> polygonLatLngs = List<LatLng>();
            for (var point in data.coordinates) {
              LatLng newPoint = LatLng(point.lat, point.lon);
              polygonLatLngs.add(newPoint);
              _allDataPoints.add(newPoint);
            }
            _setPolygon(data.name, polygonLatLngs, data.color);
          }
        });
      }
    });
  }

  void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _cntlr;

    _location.onLocationChanged.listen((l) {
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude, l.longitude), zoom: .5),
        ),
      );
    });
  }

  void _setPolygon(String areaName, List<LatLng> points, String fillColor) {
    final Color color = HexColor(fillColor);
    _polygons.add(Polygon(
      polygonId: PolygonId(areaName),
      points: points,
      strokeWidth: 2,
      strokeColor: Colors.blue,
      fillColor: color.withOpacity(0.5),
    ));
  }

  AvalancheData findArea(String name) =>
      avyData.firstWhere((data) => data.name == name);

  bool _getAddress(LatLng latLng) {
    for (var i = 0; i < avyData.length; i++) {
      if (_checkIfValidMarker(latLng, _polygons.elementAt(i).points)) {
        String areaName = _polygons.elementAt(i).polygonId.value;
        // print(areaName);
        AvalancheData avyData = findArea(areaName);
        String title = avyData.name;
        String body = avyData.travelAdvice;
        String link = avyData.link;
        Color color = HexColor(avyData.color);
        setState(() {
          _alertTitle = title;
          _alertBody = body;
          _alertLink = link;
          _alertColor = color;
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
            initialCameraPosition:
                CameraPosition(target: _initialcameraposition),
            onMapCreated: _onMapCreated,
            polygons: _polygons,
            myLocationEnabled: true,
            gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
              new Factory<OneSequenceGestureRecognizer>(
                () => new EagerGestureRecognizer(),
              ),
            ].toSet(),
            onTap: (latLng) {
              _getAddress(latLng)
                  ? showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              leading: Icon(
                                Icons.data_usage,
                                color: _alertColor,
                              ),
                              title: Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                                child: Text(
                                  _alertTitle,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              subtitle: Text(
                                _alertBody,
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                    color: Colors.black87),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                TextButton(
                                  child: const Text('More Info'),
                                  onPressed: () async {
                                    final url = _alertLink;
                                    if (await canLaunch(url)) {
                                      await launch(
                                        url,
                                        forceSafariVC: false,
                                      );
                                    }
                                  },
                                ),
                                const SizedBox(width: 8),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  : printToConsoleNo();
            },
          ))
        ],
      ),
    );
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
