// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_single_cascade_in_expression_statements, unused_local_variable, unrelated_type_equality_checks, sort_child_properties_last, unnecessary_import

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
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
        builder: (context, state) {
          Widget buttonText = const Text('Next');
          if (state is RouteandDateLoading) {
            buttonText = Center(
              child: LoadingAnimationWidget.threeRotatingDots(
                color: Color.fromARGB(255, 196, 114, 8),
                size: 30,
              ),
            );
          }

          if (state is RouteandDateLoadFaild) {
            buttonText = Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('No Route'),
                SizedBox(width: 3),
                Icon(Icons.refresh_rounded)
              ],
            );
          }
          if (state is RouteandDateLoadSuccess) {
            buttonText = Text('Found!');
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
                              bloc.add(
                                RouteandDateCheck(
                                  date: _dateTime,
                                  startCity: startcity,
                                  destination: destination,
                                  seat: [],
                                ),
                              );
                            },
                            child: buttonText),
                        if (state is RouteandDateLoadFaild)
                          Text(state.errorMessage)
                      ],
                    )),
              ],
            ),
          );
        },
        listener: (context, state) {
          if (state is RouteandDateLoadSuccess) {
            Navigator.of(context).pushNamed('/bookInformation');
          }
        },
      ),
    );
  }
}
