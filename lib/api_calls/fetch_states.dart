import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/state_model.dart';

final String herokuURL = 'https://pow-pal-api-dvl.herokuapp.com/';
final String localURL = 'http://127.0.0.1:8000/';

Future<List<StateModel>> fetchStates(http.Client client) async {
  final response = await client.get(Uri.parse(localURL + 'states/'));

  return compute(parseStates, response.body);
}

List<StateModel> parseStates(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<StateModel>((json) => StateModel.fromJson(json)).toList();
}