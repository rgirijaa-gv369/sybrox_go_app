import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class RideEvent {
  const RideEvent();
}

class LoadRidesEvent extends RideEvent {
  const LoadRidesEvent();
}

class AddRideEvent extends RideEvent {
  final String from;
  final String to;
  final DateTime dateTime;
  final double amount;

  const AddRideEvent({
    required this.from,
    required this.to,
    required this.dateTime,
    required this.amount,
  });
}

class CompleteRideEvent extends RideEvent {
  final String rideId;

  const CompleteRideEvent(this.rideId);
}

class BookAgainEvent extends RideEvent {
  final String rideId;

  const BookAgainEvent(this.rideId);
}

class IncrementOrderCountEvent extends RideEvent {
  const IncrementOrderCountEvent();
}
