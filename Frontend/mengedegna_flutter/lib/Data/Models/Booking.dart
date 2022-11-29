// ignore_for_file: unused_import, must_be_immutable

import 'package:equatable/equatable.dart';

class Booking extends Equatable {
  String firstName;
  String lastName;
  String phone;
  List seat;
  String busAssigned;

  Booking(
      {required this.firstName,
      required this.lastName,
      required this.phone,
      required this.seat,
      required this.busAssigned});

  @override
  List<Object?> get props => [firstName, lastName, phone, seat];

  factory Booking.fromJson(Map<String, dynamic> json) {
    String firstName = json['firstName'];
    String lastName = json['lastName'];
    String phone = json['lastName'];
    List seat = json['seat'];
    String busAssigned = json['busAssigned'];

    Booking booking = Booking(
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        seat: seat,
        busAssigned: busAssigned);
    return booking;
  }
}
