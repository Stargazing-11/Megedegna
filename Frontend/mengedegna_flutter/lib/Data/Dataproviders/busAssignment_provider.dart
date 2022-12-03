import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mengedegna_flutter/Data/Models/Booking.dart';
import 'package:mengedegna_flutter/Data/Models/BusAssignment.dart';

class BusAssignmentProvider {
  final _baseUrl =
      'http://localhost:5000/api/busAssignments/Debre Markos/Bahir Dar/2018-03-29T10:34:00.000+00:00';

  BusAssignmentProvider();

  Future<List<BusAssigned>> checkDateAndRoute(
      startcity, destination, date) async {
    // todo: implement token here
    var token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2Mzc4OTliOWVmZDk5YmE0NWRhNWNhYTMiLCJmaXJzdE5hbWUiOiJBYmEiLCJsYXN0TmFtZSI6IkFsZW0iLCJwaG9uZSI6IjA5NzQ0NTQyNDQiLCJyb2xlIjoiUGFzc2VuZ2VyIiwiZW1haWwiOiJhbGVtbGVtZW5lQGdtYWlsLmNvbSIsImlhdCI6MTY2OTQwMTY4MH0.uEbOomPpx0lS4Xuv_tEi3BrLHnvMT9NlaeqQCfmfDLc';
    print('Response: came here ');
    final response =
        await http.get(Uri.parse('$_baseUrl'), headers: <String, String>{
      'x-auth-token': token,
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
