// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';

class Seat extends StatefulWidget {
  const Seat({super.key});

  @override
  State<Seat> createState() => _SeatState();
}

class _SeatState extends State<Seat> {
  int change(number) {
    setState(() {
      number = number == 1 ? 0 : 1;
    });
    return number;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              seats(1),
              seats(1),
              SizedBox(width: 10),
              seats(1),
              seats(0)
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              seats(1),
              seats(0),
              SizedBox(width: 10),
              seats(0),
              seats(0)
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              seats(0),
              seats(0),
              SizedBox(width: 10),
              seats(0),
              seats(0)
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              seats(1),
              seats(0),
              SizedBox(width: 10),
              seats(0),
              seats(1)
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              seats(1),
              seats(0),
              SizedBox(width: 10),
              seats(1),
              seats(0)
            ]),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(onPressed: () {}, child: Text('Next'))
          ],
        ),
      ),
    );
  }
}

Widget seats(number) {
  Icon icon = number == 1
      ? Icon(
          Icons.clear,
          size: 20,
          color: Colors.white,
        )
      : Icon(
          Icons.check_box_sharp,
          color: Colors.white,
          size: 20,
        );
  return InkWell(
    onTap: () {
      number = number == 0 ? 1 : 0;
    },
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 2, vertical: 3),
      width: 30,
      height: 30,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: number == 1 ? Color.fromARGB(255, 167, 0, 0) : Colors.green),
      child: icon,
    ),
  );
}
