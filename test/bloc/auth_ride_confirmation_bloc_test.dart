import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sybrox_go_app/features/auth/presentation/bloc/ride_confirm/ride_confirmation_bloc.dart';

void main() {
  group('Auth RideConfirmationBloc', () {
    blocTest<RideConfirmationBloc, RideConfirmationState>(
      'selects tip amount',
      build: () => RideConfirmationBloc(otp: '1234'),
      act: (bloc) => bloc.add(SelectTipAmount(20)),
      expect: () => [
        const RideConfirmationState(otp: '1234', selectedTip: 20),
      ],
    );

    blocTest<RideConfirmationBloc, RideConfirmationState>(
      'resets tip selection',
      build: () => RideConfirmationBloc(otp: '1234'),
      seed: () => const RideConfirmationState(otp: '1234', selectedTip: 10),
      act: (bloc) => bloc.add(ResetTip()),
      expect: () => [
        const RideConfirmationState(otp: '1234'),
      ],
    );
  });
}
