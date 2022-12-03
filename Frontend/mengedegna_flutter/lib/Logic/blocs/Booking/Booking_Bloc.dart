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
        print('bus Assigned:');
        final busAssigned = await busAssignedRepository.getBusAssigned(
            DateTime.now(), 'Addis Ababa', 'Debre Markos');
        emit(RouteandDateLoadSuccess(busAssigned: busAssigned));
      } catch (error) {
        emit(RouteandDateLoadFaild(errorMessage: error.toString()));
      }
    });

    on<BookingCreate>((event, emit) async {
      try {
        await bookingRepository.createBooking(event.booking);
        emit(const CreateBookingLoadSuccess(
            successMessage: 'Booked Successfully'));
      } catch (error) {
        emit(CreateBookingLoadFailed(errorMessage: error.toString()));
      }
    });
  }
}
