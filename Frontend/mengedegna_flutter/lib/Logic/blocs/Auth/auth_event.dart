abstract class AuthEvent {}

class SignIn extends AuthEvent {
  final String phone;
  final String password;
  SignIn({required this.phone, required this.password});
}

class AddUser extends AuthEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String password;
  AddUser(
      {required this.email,
      required this.firstName,
      required this.lastName,
      required this.password,
      required this.phone});
}
