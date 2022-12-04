import 'package:mengedegna_flutter/Data/Dataproviders/auth_provider.dart';
import 'package:mengedegna_flutter/Data/Models/Auth.dart';
import 'package:mengedegna_flutter/Data/Models/User.dart';

class AuthRepository {
  final AuthProvider authProvider;
  AuthRepository({required this.authProvider});
  getUserInfo(User user) async {
    try {
      final UserResponse userResponse =
          await authProvider.authenticateUser(user);
      return userResponse;
    } catch (err) {
      return -1;
    }
  }
}
