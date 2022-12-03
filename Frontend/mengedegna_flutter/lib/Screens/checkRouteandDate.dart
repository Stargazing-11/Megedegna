// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_single_cascade_in_expression_statements, unused_local_variable, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mengedegna_flutter/Logic/blocs/Booking/booking_blocs.dart';
import 'package:mengedegna_flutter/Screens/Loading.dart';

import '../Logic/blocs/Booking/Booking_Bloc.dart';

class CheckPath extends StatefulWidget {
  const CheckPath({super.key});
  @override
  State<CheckPath> createState() => _CheckPathState();
}

class _CheckPathState extends State<CheckPath> {
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
                  'Book a New Trip',
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
                        DropdownButton(
                            items: cities
                                .map((city) => DropdownMenuItem(
                                    child: Text(city), value: city))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                startcity = value.toString();
                              });
                            },
                            hint: Text(startcity == '' ? choose[0] : startcity),
                            isExpanded: true,
                            elevation: 15,
                            dropdownColor: Color.fromARGB(255, 85, 80, 80),
                            alignment: AlignmentDirectional.center,
                            style: TextStyle(color: Colors.white)),
                        DropdownButton(
                          items: cities
                              .map((city) => DropdownMenuItem(
                                  child: Text(city), value: city))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              destination = value.toString();
                            });
                          },
                          hint:
                              Text(destination == '' ? choose[0] : destination),
                          isExpanded: true,
                          elevation: 15,
                          dropdownColor: Color.fromARGB(255, 85, 80, 80),
                          alignment: AlignmentDirectional.center,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Pick A Date: '),
                            MaterialButton(
                              minWidth: 15,
                              color: Color.fromARGB(255, 52, 153, 131),
                              onPressed: () {
                                showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(DateTime.now().year + 1))
                                  ..then((value) => {
                                        setState(() {
                                          _dateTime = value!;
                                        })
                                      });
                              },
                              child: _dateTime.year < DateTime.now().year
                                  ? Icon(Icons.date_range)
                                  : Text(
                                      '${_dateTime.day.toString()}/${_dateTime.month.toString()}/${_dateTime.year.toString()}'),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
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
                            child: Text('Next')),
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
