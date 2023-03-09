// TEST

import 'package:fbus_app/src/models/station_model.dart';

class RouteModel {
  String id;
  String departure;
  String destination;
  bool status;
  List<Station>? stations;

  RouteModel({
    required this.id,
    required this.departure,
    required this.destination,
    required this.status,
    this.stations,
  });

  factory RouteModel.fromJson(Map<String, dynamic> json) {
    return RouteModel(
      id: json["id"],
      departure: json["departure"],
      destination: json["destination"],
      status: json["status"],
      stations: json["stations"] == null
          ? []
          : List<Station>.from(
              json["stations"].map((x) => Station.fromJson(x))),
    );
  }

  static List<RouteModel> fromJsonList(List list) {
    return list.map((item) => RouteModel.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#${this.id} ${this.departure}';
  }

  ///this method will prevent the override of toString
  // bool userFilterByCreationDate(String filter) {
  //   return this.createdAt?.toString().contains(filter) ?? false;
  // }

  ///custom comparing function to check if two users are equal
  bool isEqual(RouteModel model) {
    return this.id == model.id;
  }

  @override
  String toString() => departure;
}
