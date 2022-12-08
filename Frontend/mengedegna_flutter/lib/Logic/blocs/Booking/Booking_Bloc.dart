// ignore_for_file: file_names, unused_local_variable

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mengedegna_flutter/Data/Repositories/BookingRepository.dart';
import 'package:mengedegna_flutter/Data/Repositories/BusAssignedRepository.dart';
import 'booking_blocs.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final BookingRepository bookingRepository;
  final BusAssignedRepository busAssignedRepository;

  BookingBloc(
      {required this.busAssignedRepository, required this.bookingRepository})
      : super(const InitialState()) {
    on<RouteandDateCheck>((event, emit) async {
      emit(const RouteandDateLoading());
      try {
        final busAssigned = await busAssignedRepository.getBusAssigned(
            event.date, event.destination, event.startCity);
        emit(RouteandDateLoadSuccess(
            busAssigned: busAssigned, seat: event.seat));
      } catch (error) {
        emit(RouteandDateLoadFaild(errorMessage: error.toString()));
      }
    });

    on<BookingCreate>((event, emit) async {
      emit(const CreateBookingLoading());
      try {
        await bookingRepository.createBooking(event.booking);
        emit(const CreateBookingLoadSuccess(
            successMessage: 'Booked Successfully'));
      } catch (error) {
        emit(CreateBookingLoadFailed(errorMessage: error.toString()));
      }
    });

    on<SelectSeat>((event, emit) async {
      emit(SelectSeatState(seat: event.seat));
    });

    on<ChooseSeat>((event, emit) async {
      emit(RouteandDateLoadSuccess(
          busAssigned: event.busAssigned!, seat: event.seat));
    });

    on<PickSeat>((event, emit) async {
      emit(PickSeatState(seat: event.seat, occupied: event.occupied));
    });
  }
}
