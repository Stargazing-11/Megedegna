// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_single_cascade_in_expression_statements, unused_local_variable, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mengedegna_flutter/Logic/blocs/Auth/auth_Bloc.dart';
import 'package:mengedegna_flutter/Logic/blocs/Auth/auth_state.dart';
import 'package:mengedegna_flutter/Logic/blocs/Auth/auth_event.dart';

import '../Logic/blocs/Booking/Booking_Bloc.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late AuthBloc bloc;
  final TextEditingController _phone_controller = TextEditingController();
  final TextEditingController _password_controller = TextEditingController();
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
          Widget buttonText = const Text('Sign In');

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
            buttonText = Text('Logged In');
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sign In',
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
                              prefixIcon: Icon(Icons.phone),
                              label: Text('phone:'),
                              hintText: '0987******',
                              hintStyle: TextStyle(
                                  color: Color.fromARGB(110, 168, 166, 166),
                                  fontSize: 13)),
                          controller: _phone_controller,
                        ),
                        TextField(
                          style: TextStyle(fontSize: 15),
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.security),
                            label: Text('Password:'),
                          ),
                          controller: _password_controller,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              bloc.add(SignIn(
                                  phone: _phone_controller.text,
                                  password: _password_controller.text));
                            },
                            child: Text('Sign In')),
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
