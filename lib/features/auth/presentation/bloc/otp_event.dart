import 'package:equatable/equatable.dart';

abstract class OtpEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SendOtp extends OtpEvent {
  final String phone;
  SendOtp(this.phone);

  @override
  List<Object?> get props => [phone];
}

class VerifyOtp extends OtpEvent {
  final String otp;
  VerifyOtp(this.otp);

  @override
  List<Object?> get props => [otp];
}
