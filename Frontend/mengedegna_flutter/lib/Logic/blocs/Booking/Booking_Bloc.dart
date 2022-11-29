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
      : super(RouteandDateLoading()) {
    on<RouteandDateCheck>((event, emit) async {
      emit(RouteandDateLoading());
      try {
        final busAssigned = await busAssignedRepository.getBusAssigned(
            event.date, event.startCity, event.destination);
        emit(RouteandDateLoadSuccess(busAssigned: busAssigned));
      } catch (error) {
        emit(RouteandDateLoadFaild());
      }
    });

    on<BookingCreate>((event, emit) async {
      try {
        await bookingRepository.createBooking(event.booking);
        emit(CreateBookingLoadSuccess());
      } catch (error) {
        emit(CreateBookingLoadFailed());
      }
    });
  }
}
