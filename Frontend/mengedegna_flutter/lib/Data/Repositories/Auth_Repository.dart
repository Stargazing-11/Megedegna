import 'package:mengedegna_flutter/Data/Dataproviders/auth_provider.dart';
import 'package:mengedegna_flutter/Data/Models/Auth.dart';
import 'package:mengedegna_flutter/Data/Models/User.dart';
import 'package:mengedegna_flutter/Data/sharedPref.dart';

class AuthRepository {
  final AuthProvider authProvider;
  AuthRepository({required this.authProvider});

  Future<UserResponse> getUserInfo(User user) async {
    UserResponse userResponse = await authProvider.authenticateUser(user);
    return userResponse;
  }

  Future<UserResponse> getUserInfo2(User user) async {
    return await authProvider.registerUser(user);
  }
}
