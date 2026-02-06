import 'package:equatable/equatable.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object> get props => [];
}

class NameChanged extends RegistrationEvent {
  final String name;
  const NameChanged(this.name);

  @override
  List<Object> get props => [name];
}

class GenderChanged extends RegistrationEvent {
  final String gender;
  const GenderChanged(this.gender);

  @override
  List<Object> get props => [gender];
}

class ToggleWhatsAppUpdates extends RegistrationEvent {
  final bool isEnabled;
  const ToggleWhatsAppUpdates(this.isEnabled);

  @override
  List<Object> get props => [isEnabled];
}

class ToggleReferralVisibility extends RegistrationEvent {
  final bool isVisible;
  const ToggleReferralVisibility(this.isVisible);

  @override
  List<Object> get props => [isVisible];
}

class ReferralCodeChanged extends RegistrationEvent {
  final String code;
  const ReferralCodeChanged(this.code);

  @override
  List<Object> get props => [code];
}

class VerifyReferralCode extends RegistrationEvent {}

class SubmitRegistration extends RegistrationEvent {}
