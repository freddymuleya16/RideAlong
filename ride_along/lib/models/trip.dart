import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_mapbox_autocomplete/flutter_mapbox_autocomplete.dart';
import 'package:ride_along/models/user/user.dart';

import '../controllers/user-controller.dart';

class Trip {
  final String id;
  final String duration;
  final double price;
  final String driverId;
  final List<String> passengerIds;
  final List<String> rejectedPassengerIds;
  final List<String> requestedPassengerIds;
  final String startLocation;
  final String endLocation;
  final DateTime startTime;
  final int availableSeats;
  final Car car;
  final TripStatus status;
  final MapBoxPlace? destinationPlace;
  final MapBoxPlace? originPlace;

  Trip({
    this.destinationPlace,
    this.originPlace,
    required this.duration,
    required this.rejectedPassengerIds,
    required this.requestedPassengerIds,
    required this.price,
    required this.id,
    required this.driverId,
    required this.passengerIds,
    required this.startLocation,
    required this.endLocation,
    required this.startTime,
    required this.availableSeats,
    required this.car,
    required this.status,
  });

  factory Trip.fromMap(Map<String, dynamic> map, String id) {
    final startTimestamp = map['startTime'] as Timestamp;

    return Trip(
      destinationPlace: map['destinationPlace'] == null
          ? null
          : MapBoxPlace.fromRawJson(map['destinationPlace']),
      originPlace: map['originPlace'] == null
          ? null
          : MapBoxPlace.fromRawJson(map['originPlace']),
      id: id,
      driverId: (map['driverId'] as String),
      passengerIds: (map['passengerIds'] as List<dynamic>)
          .map((passenger) => (passenger as String))
          .toList(),
      requestedPassengerIds: (map['requestedPassengerIds'] as List<dynamic>)
          .map((passenger) => (passenger as String))
          .toList(),
      rejectedPassengerIds: (map['rejectedPassengerIds'] as List<dynamic>)
          .map((passenger) => (passenger as String))
          .toList(),
      startLocation: map['startLocation'] as String,
      endLocation: map['endLocation'] as String,
      startTime: startTimestamp.toDate(),
      availableSeats: map['availableSeats'] as int,
      car: Car.fromMap(map['car'] as Map<String, dynamic>),
      status: TripStatus.values[map['status'] as int],
      duration: map['duration'] as String,
      price: map['price'].toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'originPlace': originPlace?.toRawJson(),
      'destinationPlace': destinationPlace?.toRawJson(),
      'driverId': driverId,
      'passengerIds': passengerIds.map((passenger) => passenger).toList(),
      'rejectedPassengerIds':
          rejectedPassengerIds.map((passenger) => passenger).toList(),
      'requestedPassengerIds':
          requestedPassengerIds.map((passenger) => passenger).toList(),
      'startLocation': startLocation,
      'endLocation': endLocation,
      'startTime': Timestamp.fromDate(startTime),
      'availableSeats': availableSeats,
      'car': car.toMap(),
      'status': status.index,
      'duration': duration,
      'price': price.toStringAsPrecision(2)
    };
  }
}

enum TripStatus {
  pending,
  accepted,
  inProgress,
  completed,
  cancelled,
  ongoing,
}

class Car {
  final String make;
  final String model;
  final String licensePlate;
  final String color;

  Car({
    required this.color,
    required this.make,
    required this.model,
    required this.licensePlate,
  });

  Map<String, dynamic> toMap() {
    return {
      'make': make,
      'model': model,
      'licensePlate': licensePlate,
      'color': color
    };
  }

  factory Car.fromMap(Map<String, dynamic> map) {
    return Car(
      color: map['color'] as String,
      licensePlate: map['licensePlate'] as String,
      make: map['make'] as String,
      model: map['model'] as String,
    );
  }
}
