import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/avalanche_data.dart';

Future<List<AvalancheData>> fetchAvalancheData(http.Client client) async {
  final response = 
    await client.get('http://127.0.0.1:8000/avy-props/');

  return compute(parseAvalancheData, response.body);
}

List<AvalancheData> parseAvalancheData(String responseBody) { 
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<AvalancheData>((json) => AvalancheData.fromJson(json)).toList();
}