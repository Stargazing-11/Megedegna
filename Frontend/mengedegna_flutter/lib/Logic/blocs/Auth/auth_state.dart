import 'package:mengedegna_flutter/Data/Models/Auth.dart';

abstract class AuthState {}

class Idle extends AuthState {}

class Loading extends AuthState {}

class Failed extends AuthState {}

class Successful extends AuthState {
  final UserResponse response;
  Successful({required this.response});
}
