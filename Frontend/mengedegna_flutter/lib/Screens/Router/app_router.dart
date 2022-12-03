// ignore_for_file: dead_code, prefer_const_constructors, unused_field

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mengedegna_flutter/Data/Dataproviders/booking_provider.dart';
import 'package:mengedegna_flutter/Data/Dataproviders/busAssignment_provider.dart';
import 'package:mengedegna_flutter/Data/Repositories/BookingRepository.dart';
import 'package:mengedegna_flutter/Data/Repositories/BusAssignedRepository.dart';
import 'package:mengedegna_flutter/Logic/blocs/Booking/Booking_Bloc.dart';
import 'package:mengedegna_flutter/Screens/Home.dart';
import 'package:mengedegna_flutter/Screens/Login.dart';
import 'package:mengedegna_flutter/Screens/bookInformation.dart';
import 'package:mengedegna_flutter/Screens/booked.dart';
import 'package:mengedegna_flutter/Screens/checkRouteandDate.dart';
import 'package:mengedegna_flutter/Screens/default.dart';
import 'package:mengedegna_flutter/Screens/register.dart';
import 'package:mengedegna_flutter/Screens/seat.dart';
import 'package:http/http.dart' as http;

class AppRouter {
  final BookingBloc _bookingBloc = BookingBloc(
      bookingRepository: BookingRepository(dataProvider: BookingDataProvider()),
      busAssignedRepository:
          BusAssignedRepository(dataProvider: BusAssignmentProvider()));

  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: _bookingBloc, child: BookInformation()));
        break;
      case '/register':
        return MaterialPageRoute(
            builder: (_) =>
                BlocProvider.value(value: _bookingBloc, child: Register()));
        break;
      case '/login':
        return MaterialPageRoute(
            builder: (_) =>
                BlocProvider.value(value: _bookingBloc, child: Login()));
        break;
      case '/checkPath':
        return MaterialPageRoute(
            builder: (_) =>
                BlocProvider.value(value: _bookingBloc, child: CheckPath()));
        break;
      case '/bookInformation':
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: _bookingBloc, child: BookInformation()));
        break;
      case '/seat':
        return MaterialPageRoute(
            builder: (_) =>
                BlocProvider.value(value: _bookingBloc, child: Seat()));
        break;
      case '/booked':
        return MaterialPageRoute(
            builder: (_) =>
                BlocProvider.value(value: _bookingBloc, child: Booked()));
        break;
      default:
        return MaterialPageRoute(builder: (_) => Default());
    }
  }

  void dispose() {
    _bookingBloc.close();
  }
}
