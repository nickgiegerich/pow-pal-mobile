import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:pow_pal_app/models/station_model.dart';

final String herokuURL = 'https://pow-pal-api-dvl.herokuapp.com/';
final String localURL = 'http://127.0.0.1:8000/';

Future<List<StationModel>> fetchStateStations(http.Client client, String state) async {
  final response = await client.get(Uri.parse(localURL + 'stations/' + state));

  return compute(parseStateStations, response.body);
}

List<StationModel> parseStateStations(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<StationModel>((json) => StationModel.fromJson(json)).toList();
}