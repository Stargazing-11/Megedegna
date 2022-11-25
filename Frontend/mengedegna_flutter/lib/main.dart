import 'package:flutter/material.dart';
import 'package:mengedegna_flutter/Screens/Home.dart';
import 'package:mengedegna_flutter/Screens/bookInformation.dart';
import 'package:mengedegna_flutter/Screens/bookNew.dart';
import 'package:mengedegna_flutter/Screens/booked.dart';
import 'package:mengedegna_flutter/Screens/ticket.dart';

import 'Screens/register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const BookNew(),
      debugShowCheckedModeBanner: false,
    );
  }
}