import 'package:equatable/equatable.dart';
import 'package:mengedegna_flutter/Data/Models/Booking.dart';
import 'package:mengedegna_flutter/Data/Models/BusAssignment.dart';
import 'package:mengedegna_flutter/Logic/blocs/Booking/booking_blocs.dart';

class BookingState extends Equatable {
  const BookingState();

  @override
  List<Object> get props => [];
}

class InitialState extends BookingState {
  const InitialState();
}

class RouteandDateLoading extends BookingState {
  const RouteandDateLoading();
}

class RouteandDateLoadSuccess extends BookingState {
  final BusAssigned busAssigned;
  List seat;
  RouteandDateLoadSuccess({required this.busAssigned, required this.seat});
}

class RouteandDateLoadFaild extends BookingState {
  final String errorMessage;
  const RouteandDateLoadFaild({required this.errorMessage});
}

class CreateBookingLoading extends BookingState {
  const CreateBookingLoading();
}

class CreateBookingLoadSuccess extends BookingState {
  final String successMessage;
  const CreateBookingLoadSuccess({required this.successMessage});
}

class CreateBookingLoadFailed extends BookingState {
  final String errorMessage;
  const CreateBookingLoadFailed({required this.errorMessage});
}

class ChooseSeatSuccess extends BookingState {
  List seat;
  ChooseSeatSuccess({required this.seat});
}

class ChooseSeatFaild extends BookingState {
  String message;
  ChooseSeatFaild({required this.message});
}

class SelectSeatState extends BookingState {
  List seat = [];
  SelectSeatState({required this.seat});
}

class PickSeatState extends BookingState {
  List seat = [];
  List occupied;
  PickSeatState({required this.seat, required this.occupied});
}
