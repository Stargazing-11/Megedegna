// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class BusAssigned extends Equatable {
  DateTime? date;
  List? occupied;
  String? startCity;
  String? destination;

  BusAssigned(
      {required this.date,
      required this.occupied,
      required this.startCity, required this.destination});
  @override
  List<Object?> get props => throw UnimplementedError();

  factory BusAssigned.fromJson(Map<String, dynamic> json) {
    DateTime date = json['dateOfTravle'];
    List occupied = json['occupied'];
    String startCity = json['startCity'];
    String destination = json['destination'];

    BusAssigned busAssigned = BusAssigned(
      date: date,
      occupied: occupied,
      startCity: startCity,
      destination:destination
    );
    return busAssigned;
  }
}
