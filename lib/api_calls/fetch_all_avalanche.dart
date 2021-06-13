import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/avalanche_data.dart';

final String herokuURL = 'https://pow-pal-api-dvl.herokuapp.com/';
final String localURL = 'http://127.0.0.1:8000/';

Future<List<AvalancheData>> fetchAvalancheData(http.Client client) async {
  final response = await client.get(Uri.parse(herokuURL + 'avy-props/'));

  return compute(parseAvalancheData, response.body);
}

List<AvalancheData> parseAvalancheData(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed
      .map<AvalancheData>((json) => AvalancheData.fromJson(json))
      .toList();
}
