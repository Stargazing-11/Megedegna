import 'dart:ffi';

import 'package:equatable/equatable.dart';

class Route extends Equatable {
  String? startCity;
  String? destination;
  Double? distance;

  Route(
      {required this.startCity,
      required this.destination,
      required this.distance});

    factory Route.fromJson(Map<String, dynamic> json) {
    String startCity = json['startCity'];
    String destination = json['destination'];
    Double distance = json['distance'];

    Route route = Route(
      startCity: startCity,
      destination: destination,
      distance: distance
    );
    return route;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [startCity, destination, distance];
}
