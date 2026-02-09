import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:mocktail/mocktail.dart';
import 'package:go_router/go_router.dart';

import 'package:sybrox_go_app/features/auth/presentation/bloc/otp_bloc.dart';
import 'package:sybrox_go_app/features/auth/presentation/bloc/otp_event.dart';
import 'package:sybrox_go_app/features/auth/presentation/bloc/otp_state.dart';
import 'package:sybrox_go_app/features/auth/presentation/pages/login_page.dart';


class MockOtpBloc extends MockBloc<OtpEvent, OtpState>
    implements OtpBloc {}


class FakeOtpEvent extends Fake implements OtpEvent {}
class FakeOtpState extends Fake implements OtpState {}

void main() {
  late MockOtpBloc mockOtpBloc;

  setUpAll(() {
    registerFallbackValue(FakeOtpEvent());
    registerFallbackValue(FakeOtpState());
  });

  setUp(() {
    mockOtpBloc = MockOtpBloc();

    when(() => mockOtpBloc.state).thenReturn(OtpInitial());

    whenListen(
      mockOtpBloc,
      Stream<OtpState>.fromIterable([OtpInitial()]),
    );
      });

  testWidgets('Shows login screen initially',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider<OtpBloc>.value(
              value: mockOtpBloc,
              child: const LoginOtpPage(),
            ),
          ),
        );

        expect(find.text("What’s your number?"), findsOneWidget);
        expect(find.text("Proceed"), findsOneWidget);
      });

  testWidgets('Proceed button disabled for invalid phone number',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider<OtpBloc>.value(
              value: mockOtpBloc,
              child: const LoginOtpPage(),
            ),
          ),
        );

        await tester.enterText(
          find.byType(TextField),
          '1234567890',
        );

        await tester.pump();

        final ElevatedButton button =
        tester.widget(find.byType(ElevatedButton));

        expect(button.onPressed, isNull);
      });

  testWidgets('Proceed button enables for valid phone number',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider<OtpBloc>.value(
              value: mockOtpBloc,
              child: const LoginOtpPage(),
            ),
          ),
        );

        await tester.enterText(
          find.byType(TextField),
          '9876543210',
        );

        await tester.pump();

        final ElevatedButton button =
        tester.widget(find.byType(ElevatedButton));

        expect(button.onPressed, isNotNull);
      });

  testWidgets('Navigates to OTP screen after Proceed tap',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider<OtpBloc>.value(
              value: mockOtpBloc,
              child: const LoginOtpPage(),
            ),
          ),
        );

        await tester.enterText(
          find.byType(TextField),
          '9876543210',
        );

        await tester.pump();

        await tester.tap(find.text('Proceed'));
        await tester.pumpAndSettle();

        expect(find.text('Verify OTP'), findsOneWidget);
        expect(find.byType(Pinput), findsOneWidget);
      });

  testWidgets('Shows snackbar on OTP error',
          (WidgetTester tester) async {
        whenListen(
          mockOtpBloc,
          Stream<OtpState>.fromIterable([
            OtpInitial(),
            OtpError('Bad OTP'),
          ]),
        );

        await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider<OtpBloc>.value(
              value: mockOtpBloc,
              child: const LoginOtpPage(),
            ),
          ),
        );

        await tester.pump();

        expect(find.text('Bad OTP'), findsOneWidget);
      });

  testWidgets('Navigates to registration on OTP verified',
          (WidgetTester tester) async {
        whenListen(
          mockOtpBloc,
          Stream<OtpState>.fromIterable([
            OtpInitial(),
            OtpVerified(),
          ]),
        );

        final router = GoRouter(
          initialLocation: '/',
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => BlocProvider<OtpBloc>.value(
                value: mockOtpBloc,
                child: const LoginOtpPage(),
              ),
            ),
            GoRoute(
              path: '/registration',
              builder: (context, state) => const Scaffold(
                body: Text('Registration Page'),
              ),
            ),
          ],
        );

        await tester.pumpWidget(
          MaterialApp.router(
            routerConfig: router,
          ),
        );

        await tester.pumpAndSettle();

        expect(find.text('Registration Page'), findsOneWidget);
      });
}
