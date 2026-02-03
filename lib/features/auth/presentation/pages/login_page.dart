import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sybrox_go_app/features/auth/presentation/bloc/otp_bloc.dart';
import 'package:sybrox_go_app/features/auth/presentation/bloc/otp_event.dart';
import 'package:sybrox_go_app/features/auth/presentation/bloc/otp_state.dart';
import 'package:sybrox_go_app/features/auth/presentation/pages/pickup_drop.dart';
import 'package:sybrox_go_app/features/auth/presentation/pages/registration_page.dart';

class LoginOtpPage extends StatefulWidget {
  const LoginOtpPage({super.key});

  @override
  State<LoginOtpPage> createState() => _LoginOtpPageState();
}

class _LoginOtpPageState extends State<LoginOtpPage> {
  bool isOtpScreen = false;

  final TextEditingController phoneController = TextEditingController();

  final List<TextEditingController> otpControllers = List.generate(
    4,
    (_) => TextEditingController(),
  );

  int resendSeconds = 10;
  Timer? timer;

  void startResendTimer() {
    resendSeconds = 10;
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (resendSeconds == 0) {
        t.cancel();
      } else {
        setState(() => resendSeconds--);
      }
    });
  }

  bool isPhoneValid(String phone) {
    if (phone.length != 10) return false;
    final firstDigit = int.tryParse(phone[0]) ?? 0;
    return firstDigit >= 6 && firstDigit <= 9;
  }

  bool get isOtpValid =>
      otpControllers.every((controller) => controller.text.isNotEmpty);

  @override
  void dispose() {
    timer?.cancel();
    phoneController.dispose();
    for (var c in otpControllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OtpBloc, OtpState>(
      listener: (context, state) {
        if (state is OtpVerified) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("OTP Verified !!")));
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const PickupDropPage()),
          );
        }
        if (state is OtpError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },

      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.headset_mic, size: 16),
                        SizedBox(width: 4),
                        Text("Help", style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                isOtpScreen ? _otpView() : _loginView(),

                const Spacer(),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: isOtpScreen
                        ? (isOtpValid
                              ? () {
                                  final otp = otpControllers
                                      .map((e) => e.text)
                                      .join();
                                  context.read<OtpBloc>().add(VerifyOtp(otp));
                                }
                              : null)
                        : (isPhoneValid(phoneController.text)
                              ? () {
                                  setState(() => isOtpScreen = true);
                                  startResendTimer();
                                }
                              : null),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          (isOtpScreen
                              ? isOtpValid
                              : isPhoneValid(phoneController.text))
                          ? Colors.orange
                          : Colors.grey.shade300,
                      foregroundColor: Colors.white,
                    ),
                    child: BlocBuilder<OtpBloc, OtpState>(
                      builder: (context, state) {
                        if (state is OtpLoading) {
                          return const CircularProgressIndicator(
                            color: Colors.white,
                          );
                        }
                        return Text(isOtpScreen ? "Next" : "Proceed");
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                if (!isOtpScreen)
                  Center(
                    child: RichText(
                      text: const TextSpan(
                        text: "Already have an account? ",
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                        children: [
                          TextSpan(
                            text: "Sign in",
                            style: TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "What’s your number?",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 6),
        Text(
          "Enter your phone number to proceed",
          style: TextStyle(color: Colors.grey.shade600),
        ),
        const SizedBox(height: 30),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: [
              const Text(
                "🇮🇳  +91 | ",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  decoration: const InputDecoration(
                    counterText: "",
                    hintText: "Phone number",
                    border: InputBorder.none,
                  ),
                  onChanged: (_) => setState(() {}),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _otpView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Verify OTP",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.indigo,
          ),
        ),
        const SizedBox(height: 6),
        const Text("Enter verification code"),
        const SizedBox(height: 4),
        Text(
          "sent to ${phoneController.text}",
          style: TextStyle(color: Colors.grey.shade600),
        ),

        const SizedBox(height: 30),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            4,
            (index) => SizedBox(
              width: 55,
              height: 55,
              child: TextField(
                controller: otpControllers[index],
                autofocus: index == 0,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                maxLength: 1,
                decoration: InputDecoration(
                  counterText: "",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (_) => setState(() {}),
              ),
            ),
          ),
        ),

        const SizedBox(height: 20),

        GestureDetector(
          onTap: resendSeconds == 0 ? () => startResendTimer() : null,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              resendSeconds == 0 ? "Resend OTP" : "Resend in ${resendSeconds}s",
              style: TextStyle(
                color: resendSeconds == 0 ? Colors.orange : Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
