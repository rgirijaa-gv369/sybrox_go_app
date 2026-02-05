import 'package:equatable/equatable.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object?> get props => [];
}

class LoadCurrentLocation extends LocationEvent {
  const LoadCurrentLocation();
}

class SetPickupLocation extends LocationEvent {
  final String address;

  const SetPickupLocation(this.address);

  @override
  List<Object?> get props => [address];
}

class SetDropLocation extends LocationEvent {
  final String address;

  const SetDropLocation(this.address);

  @override
  List<Object?> get props => [address];
}
