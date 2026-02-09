import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:sybrox_go_app/core/utils/direction_service.dart';
import 'package:sybrox_go_app/core/utils/fare_service.dart';
import 'package:sybrox_go_app/features/ride/presentation/bloc/map/map_bloc.dart';
import 'package:sybrox_go_app/features/ride/presentation/bloc/map/map_event.dart';
import 'package:sybrox_go_app/features/ride/presentation/bloc/map/map_state.dart';

void main() {
  group('Ride MapBloc', () {
    blocTest<MapBloc, MapState>(
      'updates driver location',
      build: () => MapBloc(DirectionService(), FareService()),
      act: (bloc) =>
          bloc.add(UpdateDriverLocation(const LatLng(12.0, 80.0))),
      expect: () => [
        isA<MapState>()
            .having((s) => s.driver, 'driver', const LatLng(12.0, 80.0)),
      ],
    );
  });
}
