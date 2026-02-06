import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sybrox_go_app/features/auth/presentation/pages/pickup_drop.dart';


import 'package:sybrox_go_app/features/ride/presentation/bloc/location/location_bloc.dart';
import 'package:sybrox_go_app/features/ride/presentation/bloc/location/location_event.dart';
import 'package:sybrox_go_app/features/ride/presentation/bloc/location/location_state.dart';

class MockLocationBloc
    extends MockBloc<LocationEvent, LocationState>
    implements LocationBloc {}

class FakeLocationEvent extends Fake implements LocationEvent {}
class FakeLocationState extends Fake implements LocationState {}

void main() {
  late MockLocationBloc mockLocationBloc;

  setUpAll(() {
    registerFallbackValue(FakeLocationEvent());
    registerFallbackValue(FakeLocationState());
  });

  setUp(() {
    mockLocationBloc = MockLocationBloc();

    /// IMPORTANT: Use REAL constructor, NOT initial()
    when(() => mockLocationBloc.state)
        .thenReturn(const LocationState());

    whenListen(
      mockLocationBloc,
      Stream<LocationState>.fromIterable([
        const LocationState(),
      ]),
    );
  });

  Widget createWidget() {
    return MaterialApp(
      home: BlocProvider<LocationBloc>.value(
        value: mockLocationBloc,
        child: const PickupDropView(),
      ),
    );
  }

  testWidgets('Shows Pickup title', (tester) async {
    await tester.pumpWidget(createWidget());

    expect(find.text('Pickup'), findsOneWidget);
    expect(find.text('Next'), findsOneWidget);
  });

  testWidgets('Next button disabled initially', (tester) async {
    await tester.pumpWidget(createWidget());

    final ElevatedButton button =
    tester.widget(find.byType(ElevatedButton));

    expect(button.onPressed, isNull);
  });

  testWidgets('Enables Next button when pickup & drop filled',
          (tester) async {
        await tester.pumpWidget(createWidget());

        final textFields = find.byType(TextField);

        await tester.enterText(textFields.at(1), 'Chennai');
        await tester.enterText(textFields.at(0), 'Bangalore');

        await tester.pump();

        final ElevatedButton button =
        tester.widget(find.byType(ElevatedButton));

        expect(button.onPressed, isNotNull);
      });
}
