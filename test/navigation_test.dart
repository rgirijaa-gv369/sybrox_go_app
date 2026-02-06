import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sybrox_go_app/app.dart';
import 'package:sybrox_go_app/features/auth/presentation/pages/login_page.dart';
import 'package:sybrox_go_app/features/auth/presentation/pages/registration_page.dart';
import 'package:sybrox_go_app/features/auth/data/repositories/otp_repository.dart';
import 'package:sybrox_go_app/features/auth/presentation/bloc/otp_bloc.dart';
import 'package:sybrox_go_app/injection_container.dart' as di;

class MockOtpRepository extends OtpRepository {
  @override
  Future<void> sendOtp(String phone) async {}

  @override
  Future<bool> verifyOtp(String otp) async => true;
}

void main() {
  setUpAll(() async {
    // Avoid re-initializing DI if it causes issues, or mock it.
    // di.init() creates real repositories which might fail.
    // Since we provide bloc manually below, we might not need DI for THIS flow,
    // UNLESS nested widgets use get_it.
    // RegistrationPage uses RegistrationBloc.
    // RegistrationPage creates it: create: (context) => RegistrationBloc()
    // RegistrationBloc constructor logic?
    // Let's assume defaults work.
  });

  testWidgets('LoginOtpPage renders directly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<OtpBloc>(
          create: (_) => OtpBloc(MockOtpRepository()),
          child: const LoginOtpPage(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(LoginOtpPage), findsOneWidget);
  });

  testWidgets('RegistrationPage renders directly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: const RegistrationPage(),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(RegistrationPage), findsOneWidget);
  });

  testWidgets('App starts at Login Page and navigates to Registration Page', (WidgetTester tester) async {
    await tester.pumpWidget(
      BlocProvider<OtpBloc>(
        create: (_) => OtpBloc(MockOtpRepository()),
        child: const MyApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(LoginOtpPage), findsOneWidget);
    expect(find.text("Register"), findsOneWidget);

    await tester.tap(find.text("Register"));
    await tester.pumpAndSettle();

    expect(find.byType(RegistrationPage), findsOneWidget);
  });
}
