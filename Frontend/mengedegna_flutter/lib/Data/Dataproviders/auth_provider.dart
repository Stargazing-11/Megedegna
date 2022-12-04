import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mengedegna_flutter/Data/Models/Auth.dart';
import 'package:mengedegna_flutter/Data/Models/User.dart';

class AuthProvider {
  String baseUrl = 'https://localhost:5000/api/auth';

  @override
  Future<UserResponse> authenticateUser(User user) async {
    final response = await http.post(Uri.parse(baseUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset= UTF-8',
        },
        body: jsonEncode(
            <String, String>{"email": user.email, "password": user.password}));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final userReponse = UserResponse.fromJson(body);
      return userReponse;
    }
    throw Exception('Authentication Failed');
  }
}
