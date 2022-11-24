// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, unnecessary_brace_in_string_interps
import 'package:flutter/material.dart';

import 'Common/common.dart';

class Booked extends StatefulWidget {
  const Booked({super.key});

  @override
  State<Booked> createState() => _BookedState();
}

class _BookedState extends State<Booked> {
  @override
  static const trips = [
    ['Addis Ababa', 'Harar', 'Augest 22, 2020'],
    ['Bahir Dar', 'Gonder', 'January 02, 2021'],
    ['Arba Minch', 'Hawassa', 'September 12, 2021'],
    ['Nazeret', 'Dilla', 'December 08, 2021'],
    ['Dessie', 'Debre Markos', 'April 01, 2022'],
  ];
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(83, 0, 0, 0),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              width: 250,
              child: Text(
                'Your Booked Trips',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 200,
                ),
                IconButton(
                  icon: Icon(
                    Icons.sort_rounded,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  tooltip: 'Sort',
                  onPressed: () {},
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.all(8),
                itemCount: trips.length,
                itemBuilder: (BuildContext context, int index) {
                  return card(
                      trips[index][0], trips[index][1], trips[index][2]);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.white,
        backgroundColor: Color.fromARGB(78, 0, 0, 0),
        elevation: 2.0,
        currentIndex: 1,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.list_alt_rounded,
              ),
              label: 'Booked Trips'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.create_rounded,
              ),
              label: 'Book New'),
        ],
      ),
    );
  }
}

Widget card(from, to, date) {
  return SizedBox(
    width: 150,
    height: 120,
    child: Container(
      width: 200,
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromARGB(135, 116, 113, 113)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            '${from} to ${to}',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
          ),
          Text(
            date,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 10,
              ),
              TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.white),
                    elevation: MaterialStatePropertyAll(21)),
                onPressed: () {},
                child: Text(
                  'Details',
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
              )
            ],
          )
        ],
      ),
    ),
  );
}
