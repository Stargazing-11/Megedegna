import 'package:equatable/equatable.dart';
import 'package:mengedegna_flutter/Data/Models/Booking.dart';
import 'package:mengedegna_flutter/Data/Models/BusAssignment.dart';

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
  final Booking busAssigned;

  const RouteandDateLoadSuccess({required this.busAssigned});
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
