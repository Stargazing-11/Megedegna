// ignore_for_file: unused_import

import 'package:mengedegna_flutter/Data/Dataproviders/booking_provider.dart';
import 'package:mengedegna_flutter/Data/Dataproviders/busAssignment_provider.dart';
import 'package:mengedegna_flutter/Data/Models/Booking.dart';
import 'package:mengedegna_flutter/Data/Models/BusAssignment.dart';
import 'package:meta/meta.dart';

class BusAssignedRepository {
  final BusAssignmentProvider dataProvider;

  BusAssignedRepository({required this.dataProvider});

  Future<BusAssigned> getBusAssigned(
      DateTime date, String startCity, String destination) async {
    BusAssigned busAssigned =
        await dataProvider.checkDateAndRoute(startCity, destination, date);
    return busAssigned;
  }
}
