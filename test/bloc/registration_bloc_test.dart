import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sybrox_go_app/features/auth/presentation/bloc/registration_bloc.dart';
import 'package:sybrox_go_app/features/auth/presentation/bloc/registration_event.dart';
import 'package:sybrox_go_app/features/auth/presentation/bloc/registration_state.dart';

void main() {
  group('RegistrationBloc', () {
    blocTest<RegistrationBloc, RegistrationState>(
      'updates name',
      build: () => RegistrationBloc(),
      act: (bloc) => bloc.add(NameChanged('Sri')),
      expect: () => [
        const RegistrationState(name: 'Sri'),
      ],
    );

    blocTest<RegistrationBloc, RegistrationState>(
      'updates gender',
      build: () => RegistrationBloc(),
      act: (bloc) => bloc.add(const GenderChanged('Male')),
      expect: () => [
        const RegistrationState(gender: 'Male'),
      ],
    );

    blocTest<RegistrationBloc, RegistrationState>(
      'sanitizes referral code',
      build: () => RegistrationBloc(),
      act: (bloc) => bloc.add(ReferralCodeChanged('ab#12!')),
      expect: () => [
        const RegistrationState(referralCode: 'AB12'),
      ],
    );

    blocTest<RegistrationBloc, RegistrationState>(
      'verifies referral code when enabled',
      build: () => RegistrationBloc(),
      act: (bloc) {
        bloc.add(const ToggleReferralVisibility(true));
        bloc.add(ReferralCodeChanged('ABC123'));
        bloc.add(VerifyReferralCode());
      },
      wait: const Duration(seconds: 1),
      expect: () => [
        const RegistrationState(
          isReferralInputVisible: true,
          referralCode: '',
          isReferralVerified: false,
        ),
        const RegistrationState(
          isReferralInputVisible: true,
          referralCode: 'ABC123',
          isReferralVerified: false,
        ),
        const RegistrationState(
          isReferralInputVisible: true,
          referralCode: 'ABC123',
          isReferralVerified: true,
        ),
      ],
    );

    blocTest<RegistrationBloc, RegistrationState>(
      'submits registration when form valid',
      build: () => RegistrationBloc(),
      act: (bloc) {
        bloc.add(NameChanged('Sri'));
        bloc.add(const GenderChanged('Male'));
        bloc.add(SubmitRegistration());
      },
      wait: const Duration(seconds: 1),
      expect: () => [
        const RegistrationState(name: 'Sri'),
        const RegistrationState(name: 'Sri', gender: 'Male'),
        const RegistrationState(
          name: 'Sri',
          gender: 'Male',
          isSubmitting: true,
        ),
        const RegistrationState(
          name: 'Sri',
          gender: 'Male',
          isSubmitting: false,
          isSuccess: true,
        ),
      ],
    );
  });
}
