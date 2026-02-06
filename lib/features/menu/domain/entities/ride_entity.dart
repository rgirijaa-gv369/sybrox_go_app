import 'package:equatable/equatable.dart';

class RideEntity extends Equatable {
  final String id;
  final String pickupLocation;
  final String dropLocation;
  final String date;
  final String time;
  final double amount;
  final bool isCompleted; // true = Complete, false = Cancel
  final Map<String, double> fareBreakdown;
  final double distanceKm;
  final double durationMins;

  const RideEntity({
    required this.id,
    required this.pickupLocation,
    required this.dropLocation,
    required this.date,
    required this.time,
    required this.amount,
    required this.isCompleted,
    this.fareBreakdown = const {},
    this.distanceKm = 0.0,
    this.durationMins = 0.0,
  });

  @override
  List<Object?> get props => [
    id,
    pickupLocation,
    dropLocation,
    date,
    time,
    amount,
    isCompleted,
    fareBreakdown,
    distanceKm,
    durationMins,
  ];
}
