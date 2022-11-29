import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mengedegna_flutter/Data/Models/BusAssignment.dart';

class BusAssignmentProvider {
  final _baseUrl = 'http://localhost:5000/api/busAssignments/';
  final http.Client httpClient;

  BusAssignmentProvider({required this.httpClient});

  Future<List<BusAssigned>> checkDateAndRoute(
    startcity, destination, date
  ) async {
    // todo: implement token here
    var token = '';
    final response = await httpClient.get(
        Uri.parse('$_baseUrl/startcity/destination/date'),
        headers: <String, String>{
          'auth-token': token,
        });
    if (response.statusCode == 200) {
      final busAssigned = jsonDecode(response.body) as List;
      return busAssigned
          .map((busAssigned) => BusAssigned.fromJson(busAssigned))
          .toList();
    } else {
      throw Exception('Failed to load Bookings');
    }
  }
}
