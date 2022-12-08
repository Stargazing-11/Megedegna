// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class BusAssigned extends Equatable {
  DateTime? date;
  List? occupied;
  String? startCity;
  String? destination;
  String? id;
  int? price;
  int? distance;
  BusAssigned(
      {required this.date,
      required this.occupied,
      required this.startCity,
      required this.destination,
      required this.id,
      required this.price,
      required this.distance});
  @override
  List<Object?> get props => [];

  factory BusAssigned.fromJson(Map<dynamic, dynamic> json) {
    print(json['route']);
    DateTime date = DateTime.parse(json["busAssignment"]['dateOfTravel']);
    List occupied = json["busAssignment"]['occupied'];
    String startCity = json["busAssignment"]['route']['startCity'].toString();
    String destination =
        json["busAssignment"]['route']['destination'].toString();
    String id = json["busAssignment"]['_id'];
    int price = json['totalPrice'];
    int distance = json["busAssignment"]['route']['distance'];
    BusAssigned busAssigned = BusAssigned(
      date: date,
      occupied: occupied,
      startCity: startCity,
      destination: destination,
      id: id,
      price: price,
      distance: distance,
    );
    return busAssigned;
  }
}
