import 'package:mengedegna_flutter/Data/Dataproviders/booking_provider.dart';
import 'package:mengedegna_flutter/Data/Models/Booking.dart';
import 'package:meta/meta.dart';

class BookingRepository {
  final BookingDataProvider dataProvider;

  BookingRepository({required this.dataProvider});

  Future<Booking> createBooking(Booking booking) async {
    return await dataProvider.createBooking(booking);
  }

  Future<List<Booking>> getBookings() async {
    return await dataProvider.getBookings();
  }
}
