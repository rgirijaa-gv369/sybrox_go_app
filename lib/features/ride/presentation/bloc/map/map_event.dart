import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class MapEvent {}

class StartDriverTracking extends MapEvent {}

class UpdateDriverLocation extends MapEvent {
  final LatLng location;
  UpdateDriverLocation(this.location);
}
