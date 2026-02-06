import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sybrox_go_app/features/ride/presentation/bloc/location/location_bloc.dart';
import 'package:sybrox_go_app/features/ride/presentation/bloc/location/location_event.dart';
import 'package:sybrox_go_app/features/ride/presentation/bloc/location/location_state.dart';

void main() {
  group('LocationBloc', () {
    blocTest<LocationBloc, LocationState>(
      'sets pickup location',
      build: () => LocationBloc(),
      act: (bloc) => bloc.add(const SetPickupLocation('Chennai')),
      expect: () => [
        const LocationState(pickupAddress: 'Chennai'),
      ],
    );

    blocTest<LocationBloc, LocationState>(
      'sets drop location',
      build: () => LocationBloc(),
      act: (bloc) => bloc.add(const SetDropLocation('Bangalore')),
      expect: () => [
        const LocationState(dropAddress: 'Bangalore'),
      ],
    );
  });
}
