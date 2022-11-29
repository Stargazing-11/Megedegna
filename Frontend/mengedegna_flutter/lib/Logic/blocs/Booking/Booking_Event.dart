// ignore_for_file: unused_import

import 'package:equatable/equatable.dart';

import '../../../Data/Models/Booking.dart';

abstract class BookingEvent extends Equatable {
  const BookingEvent();
}

class RouteandDateCheck extends BookingEvent {
  final DateTime date;
  final String startCity;
  final String destination;
  const RouteandDateCheck(
      {required this.date, required this.startCity, required this.destination});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class BookingCreate extends BookingEvent {
  final Booking booking;
  const BookingCreate({required this.booking});

  @override
  // TODO: implement props
  List<Object?> get props => [booking];

  @override
  String toString() => 'Booking created {booking: $booking}';
}
