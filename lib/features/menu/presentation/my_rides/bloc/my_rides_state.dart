import 'package:equatable/equatable.dart';
import '../../../domain/entities/ride_entity.dart';

abstract class MyRidesState extends Equatable {
  const MyRidesState();

  @override
  List<Object?> get props => [];
}

class MyRidesInitial extends MyRidesState {}

class MyRidesLoaded extends MyRidesState {
  final List<RideEntity> rides;

  const MyRidesLoaded(this.rides);

  @override
  List<Object?> get props => [rides];
}

class RideSelected extends MyRidesState {
  final RideEntity selectedRide;

  const RideSelected(this.selectedRide);

  @override
  List<Object?> get props => [selectedRide];
}
