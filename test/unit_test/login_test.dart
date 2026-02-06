import 'package:flutter_test/flutter_test.dart';
import 'package:sybrox_go_app/features/auth/data/repositories/otp_repository.dart';

void main() {
  final repo = OtpRepository();

  test('verifyOtp returns true for correct OTP', () async {
    final result = await repo.verifyOtp('1234');
    expect(result, true);
  });

  test('verifyOtp returns false for wrong OTP', () async {
    final result = await repo.verifyOtp('0000');
    expect(result, false);
  });
}
