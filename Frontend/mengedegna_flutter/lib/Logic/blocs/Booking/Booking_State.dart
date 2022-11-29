import 'package:equatable/equatable.dart';
import 'package:mengedegna_flutter/Data/Models/BusAssignment.dart';

class BookingState extends Equatable {
  const BookingState();

  @override
  List<Object> get props => [];
}

class RouteandDateLoading extends BookingState {}

class RouteandDateLoadSuccess extends BookingState {
  final BusAssigned busAssigned;

  RouteandDateLoadSuccess({required this.busAssigned});
}

class RouteandDateLoadFaild extends BookingState {}

class CreateBookingLoading extends BookingState {}

class CreateBookingLoadSuccess extends BookingState {}

class CreateBookingLoadFailed extends BookingState {}
