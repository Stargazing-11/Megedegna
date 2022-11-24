// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:mengedegna_flutter/Screens/ticket.dart';

import 'Common/common.dart';

class BookInformation extends StatelessWidget {
  const BookInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(83, 0, 0, 0),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'From Hawassa to Addis Ababa',
              style: TextStyle(
                color: Color.fromARGB(255, 189, 183, 183),
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              'Distance 256 Km',
              style: TextStyle(
                color: Color.fromARGB(255, 189, 183, 183),
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              'Price: 655 ETB',
              style: TextStyle(
                color: Color.fromARGB(255, 189, 183, 183),
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(10),
              width: 200,
              child: Text(
                'Please Fill out your Information ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            field('First Name'),
            field('Last Name'),
            field('Phone '),
            field('Seat'),
            button('Book', Icon(Icons.next_plan), context, Ticket()),
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
