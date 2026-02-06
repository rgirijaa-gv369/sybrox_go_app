import 'package:equatable/equatable.dart';

class RegistrationState extends Equatable {
  final String name;
  final String gender;
  final bool receiveWhatsAppUpdates;
  final bool isReferralInputVisible;
  final String referralCode;
  final bool isReferralVerified;
  final bool isSubmitting;
  final bool isSuccess;
  final String? errorMessage;

  const RegistrationState({
    this.name = '',
    this.gender = '',
    this.receiveWhatsAppUpdates = false,
    this.isReferralInputVisible = false, 
    this.referralCode = '',
    this.isReferralVerified = false,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  bool get isFormValid => name.trim().length >= 3 && gender.isNotEmpty;

  // Referral Validation: Alphanumeric, Uppercase, Max 7 chars
  // User Requirement: Verify button enabled when length is "between 1 and 7"
  // And also strict checking that it is valid characters.
  bool get isReferralCodeValidFormat { 
     final code = referralCode.trim();
     if (code.isEmpty || code.length > 7) return false;
     // Helper regex for A-Z0-9
     final validRegex = RegExp(r'^[A-Z0-9]+$');
     return validRegex.hasMatch(code);
  }

  bool get isVerifyButtonEnabled => isReferralInputVisible && isReferralCodeValidFormat;

  RegistrationState copyWith({
    String? name,
    String? gender,
    bool? receiveWhatsAppUpdates,
    bool? isReferralInputVisible,
    String? referralCode,
    bool? isReferralVerified,
    bool? isSubmitting,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return RegistrationState(
      name: name ?? this.name,
      gender: gender ?? this.gender,
      receiveWhatsAppUpdates: receiveWhatsAppUpdates ?? this.receiveWhatsAppUpdates,
      isReferralInputVisible: isReferralInputVisible ?? this.isReferralInputVisible,
      referralCode: referralCode ?? this.referralCode,
      isReferralVerified: isReferralVerified ?? this.isReferralVerified,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        name,
        gender,
        receiveWhatsAppUpdates,
        isReferralInputVisible,
        referralCode,
        isReferralVerified,
        isSubmitting,
        isSuccess,
        errorMessage,
      ];
}
