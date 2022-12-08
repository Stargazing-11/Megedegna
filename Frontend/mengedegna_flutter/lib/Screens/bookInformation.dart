// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_single_cascade_in_expression_statements, unused_local_variable, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mengedegna_flutter/Data/Models/Booking.dart';
import 'package:mengedegna_flutter/Data/Models/BusAssignment.dart';
import 'package:mengedegna_flutter/Logic/blocs/Booking/booking_blocs.dart';
import 'package:mengedegna_flutter/Screens/Loading.dart';

import '../Logic/blocs/Booking/Booking_Bloc.dart';

class BookInformation extends StatefulWidget {
  const BookInformation({super.key});
  @override
  State<BookInformation> createState() => _BookInformationState();
}

class _BookInformationState extends State<BookInformation> {
  late BookingBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = context.read<BookingBloc>();
  }

  List seat = [];
  String startCity = "";
  String destination = "";
  late String busAssignedId;
  String price = "";
  String date = "";
  List occupied = [];
  String distance = "";
  TextEditingController firtNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<BookingBloc, BookingState>(
            builder: (context, state) {
              Widget buttonText = const Text('Next');
              if (state is CreateBookingLoading) {
                buttonText = Center(
                  child: LoadingAnimationWidget.threeRotatingDots(
                    color: Color.fromARGB(255, 196, 114, 8),
                    size: 30,
                  ),
                );
              }

              if (state is CreateBookingLoadFailed) {
                buttonText = Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Failed, Retry"),
                    SizedBox(width: 3),
                    Icon(Icons.refresh_rounded)
                  ],
                );
              }
              if (state is CreateBookingLoadSuccess) {
                buttonText = Text('Created!');
              }
              if (state is RouteandDateLoadSuccess) {
                startCity = state.busAssigned.startCity!;
                destination = state.busAssigned.destination!;
                occupied = state.busAssigned.occupied!;
                busAssignedId = state.busAssigned.id!;
                price = state.busAssigned.price.toString();
                date = state.busAssigned.date.toString();
                distance = state.busAssigned.distance.toString();
                seat = state.seat;
              }
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'From: $startCity \n To: $destination \n Total Distance: $distance Kms \n Price: $price Birr',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(198, 219, 219, 213)),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 3),
                      width: 210,
                      height: 2,
                      decoration: BoxDecoration(
                        color: Colors.white
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      "Fill out The Rest of passenger's Information",
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                        margin: EdgeInsets.only(top: 5),
                        width: 290,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Pick A Seat: '),
                                MaterialButton(
                                  minWidth: 15,
                                  color: Color.fromARGB(255, 52, 153, 131),
                                  onPressed: () {
                                    Navigator.of(context).pushNamed('/seat');
                                  },
                                  child: seat.isEmpty
                                      ? Icon(Icons.chair)
                                      : Text(
                                          "Row ${seat[0]}  Column ${seat[1]} Choosen"),
                                ),
                              ],
                            ),
                            TextField(
                              style: TextStyle(fontSize: 15),
                              controller: firtNameController,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.person),
                                  label: Text('First Name:'),
                                  hintText: 'Bruk, ...',
                                  hintStyle: TextStyle(
                                      color: Color.fromARGB(110, 168, 166, 166),
                                      fontSize: 13)),
                            ),
                            TextField(
                              style: TextStyle(fontSize: 15),
                              controller: lastNameController,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.person),
                                  label: Text('Last Name:'),
                                  hintText: 'Mekonennen, ...',
                                  hintStyle: TextStyle(
                                      color: Color.fromARGB(110, 168, 166, 166),
                                      fontSize: 13)),
                            ),
                            TextField(
                              controller: phoneController,
                              style: TextStyle(fontSize: 15),
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.phone),
                                  label: Text('Phone:'),
                                  hintText: '0909......',
                                  hintStyle: TextStyle(
                                      color: Color.fromARGB(110, 168, 166, 166),
                                      fontSize: 13)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  if (seat.isEmpty) {
                                    buttonText = Text('Choose Seat First');
                                  } else {
                                    bloc.add(BookingCreate(
                                        booking: Booking(
                                            firstName: firtNameController.text,
                                            lastName: lastNameController.text,
                                            phone: phoneController.text,
                                            seat: seat,
                                            busAssigned: busAssignedId)));
                                  }
                                },
                                child: buttonText),
                            if (state is CreateBookingLoadFailed)
                              Text(state.errorMessage)
                          ],
                        )),
                  ],
                ),
              );
            },
            listener: (context, state) {}));
  }
}
