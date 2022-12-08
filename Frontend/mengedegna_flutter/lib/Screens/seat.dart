// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
// ignore_for_file: avoid_single_cascade_in_expression_statements, unused_local_variable, unrelated_type_equality_checks

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mengedegna_flutter/Data/Models/BusAssignment.dart';
import 'package:mengedegna_flutter/Logic/blocs/Booking/booking_blocs.dart';

class Seat extends StatefulWidget {
  const Seat({super.key});

  @override
  State<Seat> createState() => _SeatState();
}

class _SeatState extends State<Seat> {
  late BookingBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read<BookingBloc>();
  }

  List occupied = [];
  List selected = [];
  BusAssigned? bus;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<BookingBloc, BookingState>(
      builder: (context, state) {
        Widget buttonText = const Text('Next');
        Widget messageBox = const Text('');

        if (state is RouteandDateLoadSuccess) {
          occupied = state.busAssigned.occupied!;
          bus = state.busAssigned!;
        }
        if (state is ChooseSeatFaild) {
          messageBox = Text(state.message);
          buttonText = Row(
            children: [
              Text('Retry'),
              SizedBox(
                width: 3,
              ),
              Icon(Icons.refresh_rounded)
            ],
          );
        }

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Choose a Seat'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    color: Colors.green,
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Text('Available')
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    color: Color.fromARGB(255, 255, 0, 0),
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Text('Not Available')
                ],
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.all(8),
                  itemCount: occupied.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            seats(state, index, 0),
                            seats(state, index, 1),
                            SizedBox(width: 10),
                            seats(state, index, 2),
                            seats(state, index, 3)
                          ]),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (selected.isNotEmpty) {
                      if (state is RouteandDateLoadSuccess) {
                        setState(() {
                          state.seat = selected;
                        });
                      }
                      Navigator.of(context).pushNamed('/bookInformation');
                    } else {
                      null;
                    }
                  },
                  child: buttonText),
              SizedBox(
                height: 10,
              ),
              messageBox,
              SizedBox(
                height: 90,
              )
            ],
          ),
        );
      },
      listener: (contet, state) {
        // if (state is RouteandDateLoadSuccess) {
        //   Navigator.of(context).pushNamed("/bookInformation");
        // }
      },
    ));
  }

  Widget seats(state, row, column) {
    Icon icon = occupied[row][column] == 1
        ? Icon(
            Icons.clear,
            size: 20,
            color: Colors.white,
          )
        : Icon(
            Icons.add_box_sharp,
            color: Colors.white,
            size: 20,
          );
    return Tooltip(
      message: occupied[row][column] == 1
          ? "This Seat is already Taken, choose another"
          : "",
      child: InkWell(
        onTap: (() {
          if (occupied[row][column] != 1) {
            setState(() {
              selected = [row, column];
              print("$occupied $row, $column $selected selected");
            });
          } else {
            null;
          }
        }),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 2, vertical: 3),
          width: 35,
          height: 35,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: occupied[row][column] == 1
                  ? Color.fromARGB(255, 167, 0, 0)
                  : Colors.green),
          child: icon,
        ),
      ),
    );
  }
}
