import 'package:bloc/bloc.dart';
import 'package:mengedegna_flutter/Data/Models/Auth.dart';
import 'package:mengedegna_flutter/Data/Models/User.dart';
import 'package:mengedegna_flutter/Data/Repositories/Auth_Repository.dart';
import 'package:mengedegna_flutter/Logic/blocs/Auth/auth_event.dart';
import 'package:mengedegna_flutter/Logic/blocs/Auth/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc(this.authRepository) : super(Idle()) {
    on<Login>(_onLogin);
  }

  void _onLogin(Login event, Emitter emit) async {
    emit(LoggingIn());
    String email = event.email;
    String password = event.password;

    User user = User(email: email, password: password);
    UserResponse response = await authRepository.getUserInfo(user);

    if (response == '-10') {
      emit(LoginFailed());
    } else {
      emit(LoginSuccessful(response: response));
    }
  }
}
