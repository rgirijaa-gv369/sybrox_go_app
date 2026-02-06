import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:sybrox_go_app/app.dart';
import 'package:sybrox_go_app/injection_container.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sybrox_go_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:sybrox_go_app/features/home/presentation/pages/home_page.dart';

import 'package:sybrox_go_app/main.dart';

void main() {
  setUp(() async {
    await di.init();
  });

  tearDown(() {
    GetIt.instance.reset();
  });

  testWidgets('Home Page renders seamless ride card', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (_) => di.sl<RideBloc>(),
          child: const HomePage(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Ride with GO'), findsOneWidget);
    expect(find.text('Your Ride'), findsOneWidget);
  });
}
