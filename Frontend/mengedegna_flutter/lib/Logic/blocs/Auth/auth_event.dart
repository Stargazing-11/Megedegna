abstract class AuthEvent {}

class Login extends AuthEvent {
  final String email;
  final String password;
  Login(this.email, this.password);
}
