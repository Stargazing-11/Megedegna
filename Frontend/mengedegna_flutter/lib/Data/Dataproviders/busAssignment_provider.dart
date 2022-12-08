// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mengedegna_flutter/Data/Models/Booking.dart';
import 'package:mengedegna_flutter/Data/Models/BusAssignment.dart';
import 'package:mengedegna_flutter/Data/sharedPref.dart';

class BusAssignmentProvider {
  final _baseUrl =
      'http://localhost:5000/api/busAssignments/Debre Markos/Bahir Dar/2018-03-29T10:34:00.000+00:00';

  BusAssignmentProvider();

  Future<BusAssigned> checkDateAndRoute(startcity, destination, date) async {
    SharedPreferenceService sharedPreferenceService = SharedPreferenceService();
    var token = await sharedPreferenceService.getValueOf('token');
    final response =
        await http.get(Uri.parse('$_baseUrl'), headers: <String, String>{
      'x-auth-token': token,
    });

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return BusAssigned.fromJson(body);
    } else {
      throw Exception('Failed to load Bookings');
    }
  }
}
