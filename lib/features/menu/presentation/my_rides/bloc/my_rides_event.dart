import 'package:equatable/equatable.dart';
import '../../../domain/entities/ride_entity.dart';

abstract class MyRidesEvent extends Equatable {
  const MyRidesEvent();

  @override
  List<Object?> get props => [];
}

class LoadMyRidesEvent extends MyRidesEvent {}

class SelectRideEvent extends MyRidesEvent {
  final RideEntity ride;

  const SelectRideEvent(this.ride);

  @override
  List<Object?> get props => [ride];
}
