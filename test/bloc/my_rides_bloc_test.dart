import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sybrox_go_app/features/menu/data/models/ride_model.dart';
import 'package:sybrox_go_app/features/menu/presentation/my_rides/bloc/my_rides_bloc.dart';
import 'package:sybrox_go_app/features/menu/presentation/my_rides/bloc/my_rides_event.dart';
import 'package:sybrox_go_app/features/menu/presentation/my_rides/bloc/my_rides_state.dart';

void main() {
  group('MyRidesBloc', () {
    blocTest<MyRidesBloc, MyRidesState>(
      'loads rides',
      build: () => MyRidesBloc(),
      act: (bloc) => bloc.add(LoadMyRidesEvent()),
      expect: () => [
        isA<MyRidesLoaded>().having((s) => s.rides.length, 'rides length', 3),
      ],
    );

    blocTest<MyRidesBloc, MyRidesState>(
      'selects ride',
      build: () => MyRidesBloc(),
      seed: () => MyRidesLoaded(const []),
      act: (bloc) => bloc.add(
        SelectRideEvent(
          const RideModel(
            id: '1',
            pickupLocation: 'A',
            dropLocation: 'B',
            date: '01 Jan 2024',
            time: '10:00am',
            amount: 100,
            isCompleted: true,
          ),
        ),
      ),
      expect: () => [
        isA<RideSelected>(),
      ],
    );
  });
}
