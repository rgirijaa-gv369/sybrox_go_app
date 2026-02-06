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
        const RideState(0),
      ],
    );

    blocTest<RideBloc, RideState>(
      'increments step when _NextStep is triggered',
      build: () => RideBloc(),
      seed: () => const RideState(0),
      act: (bloc) => bloc.add(

        (bloc as dynamic)._NextStep(),
      ),
      expect: () => [
        const RideState(1),
      ],
    );

    blocTest<RideBloc, RideState>(
      'stops incrementing after step 3',
      build: () => RideBloc(),
      seed: () => const RideState(3),
      act: (bloc) => bloc.add(
        (bloc as dynamic)._NextStep(),
      ),
      expect: () => [],
    );
  });
}
