// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:mengedegna_flutter/Data/Models/Auth.dart';
import 'package:mengedegna_flutter/Data/Models/User.dart';
import 'package:mengedegna_flutter/Data/Repositories/Auth_Repository.dart';
import 'package:mengedegna_flutter/Data/sharedPref.dart';
import 'package:mengedegna_flutter/Logic/blocs/Auth/auth_event.dart';
import 'package:mengedegna_flutter/Logic/blocs/Auth/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(Idle()) {
    on<SignIn>(_onLogin);
    on<AddUser>(_onRegister);
  }

  void _onRegister(AddUser event, Emitter emit) async {
    emit(Loading());
    String firstName = event.firstName;
    String lastName = event.lastName;
    String phone = event.phone;
    String email = event.email;
    String password = event.password;
    User user = User(
      email: email,
      password: password,
      lastName: lastName,
      phone: phone,
      firtName: firstName,
    );
    try {
      UserResponse response = await authRepository.getUserInfo2(user);
      SharedPreferenceService sharedPreferenceService =
          SharedPreferenceService();
      sharedPreferenceService.saveToken("token", response.token);
      emit(Successful(response: response));
    } catch (err) {
      emit(Failed());
    }
  }

  void _onLogin(SignIn event, Emitter emit) async {
    emit(Loading());
    String email = event.phone;
    String password = event.password;

    User user = User(
        email: email,
        password: password,
        firtName: "",
        lastName: "",
        phone: "");
    try {
      UserResponse response = await authRepository.getUserInfo(user);
      SharedPreferenceService sharedPreferenceService =
          SharedPreferenceService();
      sharedPreferenceService.saveToken("token", response.token);
      emit(Successful(response: response));
    } catch (err) {
      emit(Failed());
    }
  }
}
