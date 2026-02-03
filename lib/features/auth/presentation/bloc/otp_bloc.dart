import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sybrox_go_app/features/auth/data/repositories/otp_repository.dart';
import 'otp_event.dart';
import 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final OtpRepository repository;

  OtpBloc(this.repository) : super(OtpInitial()) {
    on<SendOtp>((event, emit) async {
      emit(OtpLoading());
      try {
        await repository.sendOtp(event.phone);
        emit(OtpSent());
      } catch (_) {
        emit(OtpError("Failed to send OTP"));
      }
    });

    on<VerifyOtp>((event, emit) async {
      emit(OtpLoading());
      final isValid = await repository.verifyOtp(event.otp);
      if (isValid) {
        emit(OtpVerified());
      } else {
        emit(OtpError("Invalid OTP"));
      }
    });
  }
}
