// ignore_for_file: unused_import, must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:mengedegna_flutter/Data/Models/BusAssignment.dart';

import '../../../Data/Models/Booking.dart';

abstract class BookingEvent extends Equatable {
  const BookingEvent();
}

class RouteandDateCheck extends BookingEvent {
  final DateTime date;
  final String startCity;
  final String destination;
  final List seat;
  const RouteandDateCheck(
      {required this.date,
      required this.startCity,
      required this.destination,
      required this.seat});

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

class SelectSeat extends BookingEvent {
  List seat;
  SelectSeat({required this.seat});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class PickSeat extends BookingEvent {
  List seat;
  List occupied;
  PickSeat({required this.seat, required this.occupied});
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ChooseSeat extends BookingEvent {
  List seat;
  BusAssigned? busAssigned;
  ChooseSeat({required this.seat, required this.busAssigned});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
