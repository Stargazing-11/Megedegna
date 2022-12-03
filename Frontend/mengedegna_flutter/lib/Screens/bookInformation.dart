// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_single_cascade_in_expression_statements, unused_local_variable, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  double seat = -1;
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Addis Ababa To Debre Markos',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      '300 Killometers',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      '629 Birr',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                    Container(
                      width: 50,
                      height: 2,
                      decoration: BoxDecoration(color: Colors.blue),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                  ],
                ),
                Text(
                  "Fill out The Rest of passenger's Information",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    margin: EdgeInsets.only(top: 5),
                    width: 290,
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
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Pick A Date: '),
                            MaterialButton(
                              minWidth: 15,
                              color: Color.fromARGB(255, 52, 153, 131),
                              onPressed: () {
                                Navigator.of(context).pushNamed('/seat');
                              },
                              child: seat == -1
                                  ? Icon(Icons.chair)
                                  : Text(seat.toString()),
                            ),
                          ],
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
