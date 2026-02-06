import 'package:equatable/equatable.dart';

abstract class LocationState extends Equatable {
  const LocationState();
  
  @override
  List<Object> get props => [];
}

class LocationInitial extends LocationState {}

class LocationPermissionGranted extends LocationState {}

class LocationPermissionDenied extends LocationState {
    final bool isPermanent;
    const LocationPermissionDenied({this.isPermanent = false});
}
