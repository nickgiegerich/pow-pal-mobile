import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/state_snotel.dart';

Future<List<StateSnotel>> fetchStateSnotels(http.Client client) async {
  final response = 
    await client.get('http://127.0.0.1:8000/states/');

  return compute(parseSnoteStations, response.body);
}

List<StateSnotel> parseSnoteStations(String responseBody) { 
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<StateSnotel>((json) => StateSnotel.fromJson(json)).toList();
}