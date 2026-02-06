import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../bloc/registration_bloc.dart';
import '../bloc/registration_event.dart';
import '../bloc/registration_state.dart';
import '../../../../core/utils/uppercase_formatter.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegistrationBloc(),
      child: const _RegistrationView(),
    );
  }
}

class _RegistrationView extends StatelessWidget {
  const _RegistrationView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegistrationBloc, RegistrationState>(
      listenWhen: (previous, current) =>
          previous.isSuccess != current.isSuccess && current.isSuccess,
      listener: (context, state) {
        context.push('/permission');
      },
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      // Header with Help Button
                      Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          Container(
                            alignment: Alignment.centerRight,
                            child: _HelpButton(
                              onTap: () {
                                // Placeholder action
                                showModalBottomSheet(
                                  context: context,
                                  builder: (_) =>
                                      const Center(child: Text("Help Content")),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Registration',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E3A8A), // Deep Blue color
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        'Your name',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      BlocBuilder<RegistrationBloc, RegistrationState>(
                        buildWhen: (previous, current) =>
                            previous.name != current.name,
                        builder: (context, state) {
                          return TextField(
                            decoration: InputDecoration(
                              hintText: 'Sri Karan',
                              prefixIcon: const Icon(Icons.person_outline),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.grey[200],
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                            ),
                            onChanged: (value) => context
                                .read<RegistrationBloc>()
                                .add(NameChanged(value)),
                          );
                        },
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Gender',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      BlocBuilder<RegistrationBloc, RegistrationState>(
                        buildWhen: (previous, current) =>
                            previous.gender != current.gender,
                        builder: (context, state) {
                          return Row(
                            children: [
                              _GenderChip(
                                label: 'Male',
                                isSelected: state.gender == 'Male',
                                onTap: () => context.read<RegistrationBloc>().add(
                                  const GenderChanged('Male'),
                                ),
                              ),
                              const SizedBox(width: 12),
                              _GenderChip(
                                label: 'Female',
                                isSelected: state.gender == 'Female',
                                onTap: () => context.read<RegistrationBloc>().add(
                                  const GenderChanged('Female'),
                                ),
                              ),
                              const SizedBox(width: 12),
                              _GenderChip(
                                label: 'other',
                                isSelected: state.gender == 'other',
                                onTap: () => context.read<RegistrationBloc>().add(
                                  const GenderChanged('other'),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 30),
                      BlocBuilder<RegistrationBloc, RegistrationState>(
                        buildWhen: (previous, current) =>
                            previous.receiveWhatsAppUpdates !=
                            current.receiveWhatsAppUpdates,
                        builder: (context, state) {
                          return Row(
                            children: [
                              // Placeholder for WhatsApp icon
                              Image.asset(
                                'assets/images/whatsup.png',
                                width: 24,
                                height: 24,
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(width: 8),
                              const Expanded(
                                child: Text('Receive updates in whatsapp'),
                              ),
                              Checkbox(
                                value: state.receiveWhatsAppUpdates,
                                onChanged: (value) => context
                                    .read<RegistrationBloc>()
                                    .add(ToggleWhatsAppUpdates(value ?? false)),
                                activeColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 12),
                      BlocBuilder<RegistrationBloc, RegistrationState>(
                        buildWhen: (previous, current) =>
                            previous.isReferralInputVisible !=
                            current.isReferralInputVisible,
                        builder: (context, state) {
                          return Row(
                            children: [
                              Image.asset(
                                'assets/images/gift.png',
                                width: 24,
                                height: 24,
                                fit: BoxFit.contain,
                              ), // Placeholder for Gift icon
                              const SizedBox(width: 8),
                              const Expanded(child: Text('Having a referral code')),
                              Checkbox(
                                value: state.isReferralInputVisible,
                                onChanged: (value) => context
                                    .read<RegistrationBloc>()
                                    .add(ToggleReferralVisibility(value ?? false)),
                                activeColor: Colors.green, // Green to match image
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ), // Square checkbox
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 12),
                      BlocBuilder<RegistrationBloc, RegistrationState>(
                        // Rebuild if visibility, code, or verified status changes
                        buildWhen: (previous, current) =>
                            previous.isReferralInputVisible !=
                                current.isReferralInputVisible ||
                            previous.referralCode != current.referralCode ||
                            previous.isReferralVerified != current.isReferralVerified,
                        builder: (context, state) {
                          if (!state.isReferralInputVisible)
                            return const SizedBox.shrink();

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Enter Referral code',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 8),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          decoration: InputDecoration(
                                            hintText: 'JC543KA',
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(12),
                                              borderSide: BorderSide.none,
                                            ),
                                            filled: true,
                                            fillColor: Colors.grey[200],
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                  horizontal: 16,
                                                  vertical: 14,
                                                ),
                                          ),
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                              RegExp(r'[a-zA-Z0-9]'),
                                            ), // Allow alphanumeric
                                            UpperCaseTextFormatter(), // Auto-convert to uppercase
                                            LengthLimitingTextInputFormatter(
                                              7,
                                            ), // Hard limit 7
                                          ],
                                          onChanged: (value) => context
                                              .read<RegistrationBloc>()
                                              .add(ReferralCodeChanged(value)),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      TextButton(
                                        // Logic moved to BLoC getter isVerifyButtonEnabled
                                        onPressed: state.isVerifyButtonEnabled
                                            ? () => context
                                                  .read<RegistrationBloc>()
                                                  .add(VerifyReferralCode())
                                            : null,
                                        child: Text(
                                          state.isReferralVerified
                                              ? 'Verified'
                                              : 'Verify',
                                          style: TextStyle(
                                            color: state.isReferralVerified
                                                ? Colors.green
                                                : (state.isVerifyButtonEnabled
                                                      ? const Color(0xFF1E3A8A)
                                                      : Colors.grey),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (state.isReferralVerified) _VerifiedPopup(),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 32), // Safety padding
                      const Spacer(flex: 3),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: BlocBuilder<RegistrationBloc, RegistrationState>(
                          builder: (context, state) {
                            return ElevatedButton(
                              onPressed: state.isFormValid && !state.isSubmitting
                                  ? () => context.read<RegistrationBloc>().add(
                                      SubmitRegistration(),
                                    )
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                disabledBackgroundColor: Colors.grey[300],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: state.isSubmitting
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : const Text(
                                      'Next',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HelpButton extends StatelessWidget {
  final VoidCallback onTap;

  const _HelpButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.headset_mic, size: 20, color: Colors.black87),
            SizedBox(width: 4),
            Text(
              'Help',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GenderChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _GenderChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFDAE5F8) : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
          border: isSelected
              ? Border.all(color: const Color(0xFF1E3A8A))
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? const Color(0xFF1E3A8A) : Colors.grey[600],
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class _VerifiedPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle, color: Colors.green, size: 50),
          SizedBox(height: 8),
          Text('Verified', style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
