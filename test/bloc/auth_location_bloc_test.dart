import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sybrox_go_app/features/auth/presentation/bloc/location_bloc.dart';

void main() {
  group('Auth LocationBloc', () {
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

    blocTest<LocationBloc, LocationState>(
      'loads current location',
      build: () => LocationBloc(),
      act: (bloc) => bloc.add(const LoadCurrentLocation()),
      expect: () => [
        const LocationState(isLoading: true),
        const LocationState(pickupAddress: 'Current Location', isLoading: false),
      ],
    );
  });
}
