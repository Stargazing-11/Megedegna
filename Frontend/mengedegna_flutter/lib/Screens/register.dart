// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_single_cascade_in_expression_statements, unused_local_variable, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mengedegna_flutter/Logic/blocs/Booking/booking_blocs.dart';
import 'package:mengedegna_flutter/Screens/Loading.dart';

import '../Logic/blocs/Booking/Booking_Bloc.dart';

class Register extends StatefulWidget {
  const Register({super.key});
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late BookingBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read<BookingBloc>();
  }

  Loading loading = Loading();

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
                            hintStyle: TextStyle(color: Color.fromARGB(110, 168, 166, 166), fontSize: 13)
                          ),
                        ),
                        TextField(
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            label: Text('Last Name:'),
                            hintText: 'Mekonennen, ...',
                            hintStyle: TextStyle(color: Color.fromARGB(110, 168, 166, 166), fontSize: 13)
                          ),
                        ),TextField(
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
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.phone),
                            label: Text('Phone:'),
                            hintText: '0909......',
                            hintStyle: TextStyle(color: Color.fromARGB(110, 168, 166, 166), fontSize: 13)
                          ),
                        ),
                        TextField(
                          style: TextStyle(fontSize: 15),
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.password_rounded),
                            label: Text('Password:'),
                            hintText: 'qr&76**f',
                            hintStyle: TextStyle(color: Color.fromARGB(110, 168, 166, 166), fontSize: 13)
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
                            child: Text('Sign Up')),
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
