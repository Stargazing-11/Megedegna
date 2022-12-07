// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mengedegna_flutter/Data/Models/Auth.dart';
import 'package:mengedegna_flutter/Data/Models/User.dart';

class AuthProvider {
  Future<UserResponse> authenticateUser(User user) async {
    var baseUrl = Uri.parse('http://localhost:5000/api/auth/');
    final response = await http.post(baseUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, String>{'phone': user.email, "password": user.password}));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      body['token'] = response.headers['x-auth-token'];
      print(body);
      final userResponse = UserResponse.fromJson(body);
      return userResponse;
    }
    throw Exception('Registration Failed');
  }

  Future<UserResponse> registerUser(User user) async {
    var baseUrl = Uri.parse('http://localhost:5000/api/users/');
    final response = await http.post(baseUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'firstName': user.firtName,
          'lastName': user.lastName,
          'email': user.email,
          "phone": user.phone,
          "password": user.password
        }));
    if (response.statusCode == 201) {
      final body = jsonDecode(response.body);
      final userResponse = UserResponse.fromJson(body);
      return userResponse;
    }
    throw Exception('Registration Failed');
  }
}
