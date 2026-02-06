import 'package:flutter_bloc/flutter_bloc.dart';
import 'registration_event.dart';
import 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc() : super(const RegistrationState()) {
    on<NameChanged>(_onNameChanged);
    on<GenderChanged>(_onGenderChanged);
    on<ToggleWhatsAppUpdates>(_onToggleWhatsAppUpdates);
    on<ToggleReferralVisibility>(_onToggleReferralVisibility);
    on<ReferralCodeChanged>(_onReferralCodeChanged);
    on<VerifyReferralCode>(_onVerifyReferralCode);
    on<SubmitRegistration>(_onSubmitRegistration);
  }

  void _onNameChanged(NameChanged event, Emitter<RegistrationState> emit) {
    emit(state.copyWith(name: event.name));
  }

  void _onGenderChanged(GenderChanged event, Emitter<RegistrationState> emit) {
    emit(state.copyWith(gender: event.gender));
  }

  void _onToggleWhatsAppUpdates(ToggleWhatsAppUpdates event, Emitter<RegistrationState> emit) {
    emit(state.copyWith(receiveWhatsAppUpdates: event.isEnabled));
  }

  void _onToggleReferralVisibility(ToggleReferralVisibility event, Emitter<RegistrationState> emit) {
    emit(state.copyWith(
      isReferralInputVisible: event.isVisible,
      referralCode: '', // Clear code when hidden? Requirements didn't specify, but safer UI wise.
      isReferralVerified: false,
    ));
  }

  void _onReferralCodeChanged(ReferralCodeChanged event, Emitter<RegistrationState> emit) {
    // Strict Sanitization:
    // 1. Uppercase
    // 2. Remove non-alphanumeric
    // 3. Max 7 chars
    String sanitized = event.code.toUpperCase().replaceAll(RegExp(r'[^A-Z0-9]'), '');
    if (sanitized.length > 7) {
      sanitized = sanitized.substring(0, 7);
    }
    
    emit(state.copyWith(referralCode: sanitized, isReferralVerified: false));
  }

  void _onVerifyReferralCode(VerifyReferralCode event, Emitter<RegistrationState> emit) async {
    // Only verify if valid
    if (state.isVerifyButtonEnabled) {
      await Future.delayed(const Duration(seconds: 1)); // Simulate delay
      emit(state.copyWith(isReferralVerified: true));
    }
  }

  void _onSubmitRegistration(SubmitRegistration event, Emitter<RegistrationState> emit) async {
    if (state.isFormValid) {
      emit(state.copyWith(isSubmitting: true));
      await Future.delayed(const Duration(seconds: 1)); // Simulate Submission
      emit(state.copyWith(isSubmitting: false, isSuccess: true));
    }
  }
}
