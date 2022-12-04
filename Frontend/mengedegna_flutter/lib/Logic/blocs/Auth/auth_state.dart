import 'package:mengedegna_flutter/Data/Models/Auth.dart';

abstract class AuthState {}

class Idle extends AuthState {}

class LoggingIn extends AuthState {}

class LoginFailed extends AuthState {}

class LoginSuccessful extends AuthState {
  final UserResponse response;
  LoginSuccessful({required this.response});
}
