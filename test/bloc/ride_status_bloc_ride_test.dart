import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sybrox_go_app/features/ride/presentation/bloc/ride_status/ride_status_bloc.dart';

void main() {
  group('Ride RideBloc', () {
    test('initial state is step 0', () {
      final bloc = RideBloc();
      expect(bloc.state.step, 0);
      bloc.close();
    });

    blocTest<RideBloc, RideState>(
      'emits step 0 when StartRide is added',
      build: () => RideBloc(),
      act: (bloc) => bloc.add(StartRide()),
      expect: () => [
        isA<RideState>().having((s) => s.step, 'step', 0),
      ],
    );
  });
}
