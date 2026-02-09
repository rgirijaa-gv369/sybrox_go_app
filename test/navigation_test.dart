import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sybrox_go_app/app.dart';
import 'package:sybrox_go_app/features/auth/presentation/pages/login_page.dart';
import 'package:sybrox_go_app/features/auth/presentation/pages/registration_page.dart';
import 'package:sybrox_go_app/features/auth/data/repositories/otp_repository.dart';
import 'package:sybrox_go_app/features/auth/presentation/bloc/otp_bloc.dart';
import 'package:sybrox_go_app/features/auth/presentation/bloc/otp_event.dart';
import 'package:sybrox_go_app/features/auth/presentation/bloc/otp_state.dart';
import 'package:sybrox_go_app/injection_container.dart' as di;

class MockOtpBloc extends MockBloc<OtpEvent, OtpState>
    implements OtpBloc {}

class FakeOtpEvent extends Fake implements OtpEvent {}
class FakeOtpState extends Fake implements OtpState {}

class _FakeOtpRepository extends OtpRepository {
  @override
  Future<void> sendOtp(String phone) async {}

  @override
  Future<bool> verifyOtp(String otp) async => true;
}

void main() {
  late MockOtpBloc mockOtpBloc;

  setUpAll(() {
    registerFallbackValue(FakeOtpEvent());
    registerFallbackValue(FakeOtpState());
  });

  setUp(() async {
    mockOtpBloc = MockOtpBloc();
    when(() => mockOtpBloc.state).thenReturn(OtpInitial());

    await di.sl.reset();
    di.sl.registerFactory<OtpBloc>(() => mockOtpBloc);
  });

  testWidgets('LoginOtpPage renders directly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<OtpBloc>(
          create: (_) => OtpBloc(_FakeOtpRepository()),
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
    whenListen(
      mockOtpBloc,
      Stream<OtpState>.fromIterable([OtpInitial(), OtpVerified()]),
    );

    await tester.pumpWidget(
      const MyApp(),
    );
    await tester.pumpAndSettle();

    expect(find.byType(RegistrationPage), findsOneWidget);
  });
}
