import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sybrox_go_app/features/ride/presentation/bloc/ride_confirmation/ride_confirmation_bloc.dart';

void main() {
  group('Ride RideConfirmationBloc', () {
    blocTest<RideConfirmationBloc, RideConfirmationState>(
      'selects tip amount',
      build: () => RideConfirmationBloc(otp: '5678'),
      act: (bloc) => bloc.add(SelectTipAmount(30)),
      expect: () => [
        const RideConfirmationState(otp: '5678', selectedTip: 30),
      ],
    );

    blocTest<RideConfirmationBloc, RideConfirmationState>(
      'resets tip selection',
      build: () => RideConfirmationBloc(otp: '5678'),
      seed: () => const RideConfirmationState(otp: '5678', selectedTip: 15),
      act: (bloc) => bloc.add(ResetTip()),
      expect: () => [
        const RideConfirmationState(otp: '5678'),
      ],
    );
  });
}
