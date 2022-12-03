// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:mengedegna_flutter/Screens/register.dart';

import 'Common/common.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  static const places = [
    ['Addis Ababa', 'addis.png'],
    ['Gonder', 'gonder.jpeg'],
    ['Harar', 'harar.jpeg'],
    ['Hawassa', 'hawassa.jpeg'],
    ['Lalibela', 'lalibela.jpeg'],
    ['Axum', 'axum.jpeg'],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Mengedegna',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            CircleAvatar(
              backgroundImage: AssetImage(
                'assets/images/Logo.jpeg',
              ),
              radius: 70,
            ),
            Container(
              padding: EdgeInsets.all(10),
              width: 200,
              child: Text(
                'Where Do you Want To Go ?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(8),
                itemCount: places.length,
                itemBuilder: (BuildContext context, int index) {
                  return card(places[index][0], places[index][1]);
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/checkPath');
              },
              child: Text(
                'Get Started',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
            ),
            SizedBox(
              height: 80,
            )
          ],
        ),
      ),
    );
  }
}

Widget card(city, image) {
  return Column(
    children: [
      Container(
        margin: EdgeInsets.symmetric(horizontal: 6, vertical: 5),
        width: 140,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue,
          border: Border.all(width: 2, color: Colors.white),
          image: DecorationImage(
            image: AssetImage('assets/images/${image}'),
            fit: BoxFit.fill,
          ),
        ),
      ),
      Text(
        city,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    ],
  );
}
