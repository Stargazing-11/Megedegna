// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_single_cascade_in_expression_statements, unused_local_variable, unrelated_type_equality_checks, non_constant_identifier_names, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mengedegna_flutter/Logic/blocs/Auth/auth_Bloc.dart';
import 'package:mengedegna_flutter/Logic/blocs/Auth/auth_event.dart';
import 'package:mengedegna_flutter/Logic/blocs/Auth/auth_state.dart';

class Register extends StatefulWidget {
  const Register({super.key});
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late AuthBloc bloc;
  final TextEditingController _phone_controller = TextEditingController();
  final TextEditingController _password_controller = TextEditingController();
  final TextEditingController _email_controller = TextEditingController();
  final TextEditingController _firstName_controller = TextEditingController();
  final TextEditingController _lastName_controller = TextEditingController();
  String email = 'samuelkifle199314@gmail.com';
  String firstName = 'Samuel';
  String lastName = 'Kifle';
  String phone = '0903193236';
  String password = 'tejoboyj';

  @override
  void initState() {
    super.initState();
    bloc = context.read<AuthBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        builder: (context, state) {
          Widget buttonText = const Text('Sign Up');
          if (state is Loading) {
            buttonText = Center(
                child: LoadingAnimationWidget.threeRotatingDots(
              color: Color.fromARGB(255, 196, 114, 8),
              size: 30,
            ));
          }

          if (state is Failed) {
            buttonText = Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Login Failed'),
                SizedBox(width: 3),
                Icon(Icons.refresh_rounded)
              ],
            );
          }
          if (state is Successful) {
            buttonText = Text('Created');
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                ),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    margin: EdgeInsets.only(top: 5),
                    width: 290,
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextField(
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              label: Text('First Name:'),
                              hintText: 'Bruk, ...',
                              hintStyle: TextStyle(
                                  color: Color.fromARGB(110, 168, 166, 166),
                                  fontSize: 13)),
                          controller: _firstName_controller,
                        ),
                        TextField(
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              label: Text('Last Name:'),
                              hintText: 'Mekonennen, ...',
                              hintStyle: TextStyle(
                                  color: Color.fromARGB(110, 168, 166, 166),
                                  fontSize: 13)),
                          controller: _lastName_controller,
                        ),
                        TextField(
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email_rounded),
                            label: Text('Email:'),
                            hintText: 'example@gmial.com',
                            hintStyle: TextStyle(
                                color: Color.fromARGB(110, 168, 166, 166),
                                fontSize: 13),
                          ),
                          controller: _email_controller,
                        ),
                        TextField(
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.phone),
                              label: Text('Phone:'),
                              hintText: '0909......',
                              hintStyle: TextStyle(
                                  color: Color.fromARGB(110, 168, 166, 166),
                                  fontSize: 13)),
                          controller: _phone_controller,
                        ),
                        TextField(
                          style: TextStyle(fontSize: 15),
                          obscureText: true,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.password_rounded),
                              label: Text('Password:'),
                              hintText: 'qr&76**f',
                              hintStyle: TextStyle(
                                  color: Color.fromARGB(110, 168, 166, 166),
                                  fontSize: 13)),
                          controller: _password_controller,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              bloc.add(
                                AddUser(
                                    email: _email_controller.text,
                                    firstName: _firstName_controller.text,
                                    lastName: _lastName_controller.text,
                                    password: _password_controller.text,
                                    phone: _phone_controller.text),
                              );
                            },
                            child: buttonText),
                      ],
                    )),
              ],
            ),
          );
        },
        listener: (context, state) {
          print(bloc);
          if (state is Successful) Navigator.of(context).pushNamed('/checkPath');
        },
      ),
    );
  }
}
