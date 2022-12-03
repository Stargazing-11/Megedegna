// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_single_cascade_in_expression_statements, unused_local_variable, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mengedegna_flutter/Logic/blocs/Booking/booking_blocs.dart';
import 'package:mengedegna_flutter/Screens/Loading.dart';

import '../Logic/blocs/Booking/Booking_Bloc.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late BookingBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read<BookingBloc>();
  }

  Loading loading = Loading();
  List cities = [
    "Addis Ababa",
    'Debre Markos',
    'Bahir Dar',
    'Hawassa',
    'Gonder',
    'Arba Minch',
    'Dessie',
    'Ambo'
  ];
  List choose = ['Choose Start city', 'Choose destination'];

  DateTime _dateTime = DateTime(2011);
  String startcity = '';
  String destination = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<BookingBloc, BookingState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          print(state);
          if (state is RouteandDateLoading) {
            return CircularProgressIndicator(
              backgroundColor: Colors.white,
              semanticsLabel: 'Loading...',
              value: 4,
            );
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
                            prefixIcon: Icon(Icons.email_rounded),
                            label: Text('Email:'),
                            hintText: 'example@gmial.com',
                            hintStyle: TextStyle(color: Color.fromARGB(110, 168, 166, 166), fontSize: 13)
                          ),
                        ),
                        TextField(
                          style: TextStyle(fontSize: 15),
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.password_rounded),
                            label: Text('Password:'),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              bloc.add(RouteandDateCheck(
                                  date: DateTime(2019),
                                  startCity: 'Addis Ababa',
                                  destination: 'Debre Markos'));
                              if (state == RouteandDateLoadSuccess) {
                                print('dudde $state');
                              }
                            },
                            child: Text('Sign In')),
                        if (state is RouteandDateLoadFaild)
                          Text(state.errorMessage)
                      ],
                    )),
              ],
            ),
          );
        },
      ),
    );
  }
}
