// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, unnecessary_brace_in_string_interps
import 'package:flutter/material.dart';
import 'package:mengedegna_flutter/Screens/bookInformation.dart';

import 'Common/common.dart';

class BookNew extends StatefulWidget {
  const BookNew({super.key});

  @override
  State<BookNew> createState() => _BookNewState();
}

class _BookNewState extends State<BookNew> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(83, 0, 0, 0),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              width: 250,
              child: Text(
                'Book a New Trip',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            field('Start City'),
            field('Destination'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Date:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  width: 70,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: IconButton(
                    icon: Icon(
                      Icons.date_range,
                      color: Colors.black,
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            button(
              'Next',
              Icon(Icons.forward),
              context,
              BookInformation()
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.white,
        backgroundColor: Color.fromARGB(78, 0, 0, 0),
        elevation: 2.0,
        currentIndex: 2,
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
