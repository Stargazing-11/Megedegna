// ignore_for_file: unnecessary_string_interpolations

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mengedegna_flutter/Data/Models/Booking.dart';
import 'package:mengedegna_flutter/Data/sharedPref.dart';

class BookingDataProvider {
  final _baseUrl = 'http://localhost:5000/api/booking/';

  Future<List<Booking>> getBookings() async {
    SharedPreferenceService sharedPreferenceService = SharedPreferenceService();
    var token = await sharedPreferenceService.getValueOf('token');
    final response =
        await http.get(Uri.parse('$_baseUrl'), headers: <String, String>{
      'auth-token': token,
    });
    if (response.statusCode == 200) {
      final bookings = jsonDecode(response.body) as List;
      return bookings.map((booking) => Booking.fromJson(booking)).toList();
    } else {
      throw Exception('Failed to load Bookings');
    }
  }

  Future<Booking> createBooking(Booking booking) async {
    SharedPreferenceService sharedPreferenceService = SharedPreferenceService();
    var token = await sharedPreferenceService.getValueOf('token');
    
    final http.Response response = await http.post(
      Uri.parse('$_baseUrl/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token,
      },
      body: jsonEncode(<String, dynamic>{
        'firstName': booking.firstName,
        'lastName': booking.lastName,
        'phoneNumber': booking.phone,
        'seat': booking.seat,
        'busAssigned': booking.busAssigned,
      }),
    );
    print(response.body);
    if (response.statusCode == 201) {
      return Booking.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  }
}
