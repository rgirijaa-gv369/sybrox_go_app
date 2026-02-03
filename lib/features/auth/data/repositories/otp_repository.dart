import 'dart:async';

class OtpRepository {
  Future<void> sendOtp(String phone) async {
    await Future.delayed(const Duration(seconds: 2));
  }

  Future<bool> verifyOtp(String otp) async {
    await Future.delayed(const Duration(seconds: 2));
    return otp == "1234";
  }
}