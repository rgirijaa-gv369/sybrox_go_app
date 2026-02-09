import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sybrox_go_app/features/auth/data/repositories/otp_repository.dart';
import 'package:sybrox_go_app/features/auth/presentation/bloc/otp_bloc.dart';
import 'package:sybrox_go_app/features/auth/presentation/bloc/otp_event.dart';
import 'package:sybrox_go_app/features/auth/presentation/bloc/otp_state.dart';

void main() {
  final repo = _FakeOtpRepository();

  group('OtpBloc', () {
    blocTest<OtpBloc, OtpState>(
      'emits [OtpLoading, OtpVerified] when OTP is correct',
      build: () => OtpBloc(repo),
      act: (bloc) => bloc.add(VerifyOtp('1234')),
      expect: () => [
        OtpLoading(),
        OtpVerified(),
      ],
    );

    blocTest<OtpBloc, OtpState>(
      'emits [OtpLoading, OtpError] when OTP is wrong',
      build: () => OtpBloc(repo),
      act: (bloc) => bloc.add(VerifyOtp('0000')),
      expect: () => [
        OtpLoading(),
        isA<OtpError>(),
      ],
    );
  });
}

class _FakeOtpRepository extends OtpRepository {
  @override
  Future<void> sendOtp(String phone) async {}

  @override
  Future<bool> verifyOtp(String otp) async => otp.trim() == '1234';
}
