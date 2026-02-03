import 'otp_repository.dart';

class OtpRepositoryImpl implements OtpRepository {
  @override
  Future<void> sendOtp(String phone) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    print("OTP Sent to $phone");
  }

  @override
  Future<bool> verifyOtp(String otp) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    // Accept any 4 digit OTP for now, or specific one
    return otp.length == 4;
  }
}
