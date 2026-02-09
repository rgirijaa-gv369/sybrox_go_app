import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:sybrox_go_app/features/auth/presentation/bloc/otp_bloc.dart';
import 'package:sybrox_go_app/features/auth/presentation/bloc/otp_event.dart';
import 'package:sybrox_go_app/features/auth/presentation/bloc/otp_state.dart';
import 'package:sybrox_go_app/features/auth/presentation/pages/pickup_drop.dart';
import 'package:go_router/go_router.dart';
import 'package:sybrox_go_app/features/menu/presentation/help_and_support/pages/help_support_page.dart';

class LoginOtpPage extends StatefulWidget {
  const LoginOtpPage({super.key});

  @override
  State<LoginOtpPage> createState() => _LoginOtpPageState();
}

class _LoginOtpPageState extends State<LoginOtpPage> {
  bool isOtpScreen = false;
  bool isSignin = false;
  late TextEditingController phoneController;
  String enteredOtp = '';
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

  bool get isOtpValid => enteredOtp.length == 4;
  bool get isPhoneInvalid {
    final text = phoneController.text.trim();
    if (text.isEmpty) return false;
    final firstDigit = int.tryParse(text[0]) ?? 0;
    return firstDigit < 6;
  }

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController();
  }

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
          context.go('/registration');
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
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const HelpSupportPage(),
                        ),
                      );
                    },
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
                                  context.read<OtpBloc>().add(
                                    VerifyOtp(enteredOtp.trim()),
                                  );
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
                      text: TextSpan(
                        text:  isSignin ?  "Don't have an account? " : "Already have an account? ",
                        style: const TextStyle(color: Colors.grey, fontSize: 13),
                        children: [
                          TextSpan(
                            text:  isSignin ? "Create Account" : "Sign in",
                            style: const TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.w500,
                            ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = (){
                                  setState(() {
                                    isSignin = !isSignin;
                                  });}
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
        if (isSignin) ...[
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Welcome Back",
                  style: TextStyle(color: Colors.black,fontSize: 22, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 6),
                Text(
                  "Log in and pick up right where you left",
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        ],
        const SizedBox(height: 30),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "What’s your number?",
              style: TextStyle(color: Colors.black,fontSize: 22, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            Text(
              "Enter your phone number to proceed",
              style: TextStyle(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 20),
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
                    style: TextStyle(color: Colors.black,fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      style: const TextStyle(
                        color: Colors.black, // text color
                        fontSize: 16,
                      ),
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
            if (isPhoneInvalid) ...[
              const SizedBox(height: 6),
              const Text(
                "Enter a valid 10-digit phone number starting with 6-9",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _otpView() {
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 50,
      textStyle: const TextStyle(fontSize: 22, color: Colors.black),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.transparent),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Verify OTP",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 6),
        const Text("Enter verification code", style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w100,
          color: Colors.black,
        ),),
        const SizedBox(height: 4),
        Text(
          "sent to ${phoneController.text}",
          style: TextStyle(fontSize: 14,
              fontWeight: FontWeight.w100,color: Colors.grey.shade600),
        ),

        const SizedBox(height: 30),

        Pinput(
          length: 4,
          keyboardType: TextInputType.number,

          defaultPinTheme: defaultPinTheme,
          focusedPinTheme: defaultPinTheme.copyWith(
            decoration: defaultPinTheme.decoration!.copyWith(
              border: Border.all(color: Colors.orange),
            ),
          ),
          submittedPinTheme: defaultPinTheme.copyWith(
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              border: Border.all(color:Colors.black ),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onChanged: (value) {
            setState(() => enteredOtp = value);
          },
          onCompleted: (value) {
            setState(() => enteredOtp = value);
          },
        ),

        const SizedBox(height: 20),

        GestureDetector(
          onTap: resendSeconds == 0 ? () => startResendTimer() : null,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: resendSeconds == 0 ? Colors.orange : Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              resendSeconds == 0 ? "Resend OTP" : "Resend in ${resendSeconds}s",
              style: TextStyle(
                color: resendSeconds == 0 ? Colors.white : Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
