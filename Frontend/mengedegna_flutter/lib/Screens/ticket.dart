// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:mengedegna_flutter/Screens/Common/common.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Ticket extends StatelessWidget {
  const Ticket({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 300,
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              decoration: BoxDecoration(
                color: Color.fromRGBO(46, 91, 105, 1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(
                      'assets/images/Logo.jpeg',
                    ),
                    radius: 42,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Mengedegna Bus',
                    style: TextStyle(
                      color: Color.fromARGB(255, 197, 191, 191),
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(4),
                    height: 2,
                    color: Colors.black,
                    width: 300,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        text('Full Name: Samuel Kifle'),
                        text('Phone: 0900319976'),
                        text('From: Addis Ababa'),
                        text('To: Harar'),
                        text('Date: Jan 14, 2023'),
                        text('Paid: 656 ETB'),
                        text('Bus Number: Mengedegna/A'),
                        text(
                          'Seat Number: 12',
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      QrImage(
                        data: "1234567890",
                        version: QrVersions.auto,
                        size: 80.0,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            button('Save', Icon(Icons.download), context, Ticket()),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.white,
        backgroundColor: Color.fromARGB(78, 0, 0, 0),
        elevation: 2.0,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.book_rounded,
              ),
              label: 'Ticket'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.list_alt_rounded,
              ),
              label: 'Booked Trips'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.create_rounded,
              ),
              label: 'Add'),
        ],
      ),
    );
  }
}

Widget text(text) {
  return Container(
    margin: EdgeInsets.all(2),
    child: Text(
      text,
      style: TextStyle(
        color: Color.fromARGB(255, 197, 191, 191),
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
