import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mengedegna_flutter/Data/Models/Booking.dart';

class BookingDataProvider {
  final _baseUrl = 'http://localhost:5000/api/booking/';
  final http.Client httpClient;

  BookingDataProvider({required this.httpClient});

  Future<List<Booking>> getBookings() async {
    // todo: implement token here
    var token = '';
    final response =
        await httpClient.get(Uri.parse('$_baseUrl'), headers: <String, String>{
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
    var token = '';

    final http.Response response = await httpClient.post(
      Uri.parse('$_baseUrl/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'auth-token': token,
      },
      body: jsonEncode(<String, dynamic>{
        'firstName': booking.firstName,
        'lastName': booking.lastName,
        'phone': booking.phone,
        'seat': booking.seat,
        'busAssigned': booking.busAssigned,
      }),
    );

    if (response.statusCode == 200) {
      return Booking.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create Booking');
    }
  }


}

