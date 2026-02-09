import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sybrox_go_app/features/auth/presentation/bloc/ride_status/ride_status_bloc.dart';

void main() {
  group('RideBloc', () {
    late RideBloc rideBloc;

    setUp(() {
      rideBloc = RideBloc();
    });

    tearDown(() async {
      await rideBloc.close();
    });

    test('initial state is step 0', () {
      expect(rideBloc.state.step, 0);
    });

    blocTest<RideBloc, RideState>(
      'emits step 0 when StartRide is added',
      build: () => RideBloc(),
      act: (bloc) => bloc.add(StartRide()),
      expect: () => [
        isA<RideState>().having((s) => s.step, 'step', 0),
      ],
    );

    blocTest<RideBloc, RideState>(
      'increments step after timer tick',
      build: () => RideBloc(),
      act: (bloc) => bloc.add(StartRide()),
      wait: const Duration(seconds: 2),
      expect: () => [
        isA<RideState>().having((s) => s.step, 'step', 0),
        isA<RideState>().having((s) => s.step, 'step', 1),
      ],
    );

    blocTest<RideBloc, RideState>(
      'stops incrementing after step 3',
      build: () => RideBloc(),
      act: (bloc) => bloc.add(StartRide()),
      wait: const Duration(seconds: 7),
      expect: () => [
        isA<RideState>().having((s) => s.step, 'step', 0),
        isA<RideState>().having((s) => s.step, 'step', 1),
        isA<RideState>().having((s) => s.step, 'step', 2),
        isA<RideState>().having((s) => s.step, 'step', 3),
      ],
    );
  });
}
