import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapState {
  final LatLng? pickup;
  final LatLng? drop;
  final LatLng? driver;
  final List<LatLng> polyline;
  final double fare;

  MapState({
    this.pickup,
    this.drop,
    this.driver,
    this.polyline = const [],
    this.fare = 0,
  });

  MapState copyWith({
    LatLng? pickup,
    LatLng? drop,
    LatLng? driver,
    List<LatLng>? polyline,
    double? fare,
  }) {
    return MapState(
      pickup: pickup ?? this.pickup,
      drop: drop ?? this.drop,
      driver: driver ?? this.driver,
      polyline: polyline ?? this.polyline,
      fare: fare ?? this.fare,
    );
  }
}
