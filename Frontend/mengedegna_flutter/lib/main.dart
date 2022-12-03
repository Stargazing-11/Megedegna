import 'package:flutter/material.dart';
import 'package:mengedegna_flutter/Screens/Home.dart';
import 'package:mengedegna_flutter/Screens/Loading.dart';
import 'package:mengedegna_flutter/Screens/Login.dart';
import 'package:mengedegna_flutter/Screens/Router/app_router.dart';
import 'package:mengedegna_flutter/Screens/bookInformation.dart';
import 'package:mengedegna_flutter/Screens/booked.dart';
import 'package:mengedegna_flutter/Screens/checkRouteandDate.dart';
import 'package:mengedegna_flutter/Screens/ticket.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppRouter _appRouter = AppRouter();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue, brightness: Brightness.dark),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: _appRouter.onGenerateRoute,
      // home: Login(),
    );
  }

  @override
  void dispose() {
    _appRouter.dispose();
    super.dispose();
  }
}
