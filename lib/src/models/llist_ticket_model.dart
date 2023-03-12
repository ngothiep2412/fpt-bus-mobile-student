import 'dart:convert';

List<ListTicketModel> listTicketModelFromJson(String str) =>
    List<ListTicketModel>.from(
        json.decode(str).map((x) => ListTicketModel.fromJson(x)));

String listTicketModelToJson(List<ListTicketModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListTicketModel {
  ListTicketModel({
    required this.id,
    required this.tripId,
    required this.userId,
    this.checkInAt,
    required this.qrUrl,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.trip,
  });

  String id;
  String tripId;
  String userId;
  dynamic checkInAt;
  String qrUrl;
  bool status;
  DateTime createdAt;
  DateTime updatedAt;
  Trip trip;

  factory ListTicketModel.fromJson(Map<String, dynamic> json) =>
      ListTicketModel(
        id: json["id"],
        tripId: json["trip_id"],
        userId: json["user_id"],
        checkInAt: json["checkInAt"],
        qrUrl: json["qrUrl"],
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        trip: Trip.fromJson(json["Trip"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "trip_id": tripId,
        "user_id": userId,
        "checkInAt": checkInAt,
        "qrUrl": qrUrl,
        "status": status,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "Trip": trip.toJson(),
      };
}

class Trip {
  Trip({
    required this.departureDate,
    required this.departureTime,
    required this.ticketQuantity,
    required this.bus,
    required this.route,
  });

  DateTime departureDate;
  String departureTime;
  int ticketQuantity;
  Bus bus;
  Route route;

  factory Trip.fromJson(Map<String, dynamic> json) => Trip(
        departureDate: DateTime.parse(json["departure_date"]),
        departureTime: json["departure_time"],
        ticketQuantity: json["ticket_quantity"],
        bus: Bus.fromJson(json["Bus"]),
        route: Route.fromJson(json["Route"]),
      );

  Map<String, dynamic> toJson() => {
        "departure_date":
            "${departureDate.year.toString().padLeft(4, '0')}-${departureDate.month.toString().padLeft(2, '0')}-${departureDate.day.toString().padLeft(2, '0')}",
        "departure_time": departureTime,
        "ticket_quantity": ticketQuantity,
        "Bus": bus.toJson(),
        "Route": route.toJson(),
      };
}

class Bus {
  Bus({
    required this.licensePlate,
    required this.seatQuantity,
    required this.user,
  });

  String licensePlate;
  int seatQuantity;
  Student user;

  factory Bus.fromJson(Map<String, dynamic> json) => Bus(
        licensePlate: json["license_plate"],
        seatQuantity: json["seat_quantity"],
        user: Student.fromJson(json["User"]),
      );

  Map<String, dynamic> toJson() => {
        "license_plate": licensePlate,
        "seat_quantity": seatQuantity,
        "User": user.toJson(),
      };
}

class Student {
  Student({
    required this.fullname,
  });

  String fullname;

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        fullname: json["fullname"],
      );

  Map<String, dynamic> toJson() => {
        "fullname": fullname,
      };
}

class Route {
  Route({
    required this.routeName,
    required this.departure,
    required this.destination,
  });

  String routeName;
  String departure;
  String destination;

  factory Route.fromJson(Map<String, dynamic> json) => Route(
        routeName: json["route_name"],
        departure: json["departure"],
        destination: json["destination"],
      );

  Map<String, dynamic> toJson() => {
        "route_name": routeName,
        "departure": departure,
        "destination": destination,
      };
}
