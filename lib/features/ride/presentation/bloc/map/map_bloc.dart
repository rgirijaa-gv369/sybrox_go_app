import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../core/utils/direction_service.dart';
import '../../../../../core/utils/fare_service.dart';
import 'map_event.dart';
import 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final DirectionService directionService;
  final FareService fareService;

  Timer? _driverTimer;
  LatLng _driverLocation = const LatLng(12.9920, 80.2350); // near pickup

  MapBloc(this.directionService, this.fareService) : super(MapState()) {
    on<StartDriverTracking>(_startTracking);
    on<UpdateDriverLocation>(_updateDriver);
  }

  void _startTracking(StartDriverTracking event, Emitter<MapState> emit) {
    _driverTimer?.cancel();

    emit(state.copyWith(driver: _driverLocation));

    _driverTimer = Timer.periodic(const Duration(seconds: 2), (_) {
      _driverLocation = LatLng(
        _driverLocation.latitude + 0.00015,
        _driverLocation.longitude + 0.00012,
      );

      add(UpdateDriverLocation(_driverLocation));
    });
  }

  void _updateDriver(UpdateDriverLocation event, Emitter<MapState> emit) {
    emit(state.copyWith(driver: event.location));
  }

  @override
  Future<void> close() {
    _driverTimer?.cancel();
    return super.close();
  }
}
