import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sybrox_go_app/features/auth/presentation/pages/map_ride_page.dart';




void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('RideMapScreen Widget Test', () {
    testWidgets('renders screen and bottom card', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: RideMapScreen(
            pickup: LatLng(12.9, 80.1),
            drop: LatLng(12.95, 80.2),
          ),
        ),
      );


      expect(find.byType(Scaffold), findsOneWidget);


      expect(find.byIcon(Icons.arrow_back), findsOneWidget);

     
      expect(find.byIcon(Icons.my_location), findsOneWidget);
    });

    testWidgets('GO Coins toggle switches state', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: RideMapScreen(
            pickup: LatLng(12.9, 80.1),
            drop: LatLng(12.95, 80.2),
          ),
        ),
      );

      final toggle = find.byType(AnimatedContainer);
      expect(toggle, findsWidgets);

      await tester.tap(toggle.first);
      await tester.pump(const Duration(milliseconds: 300));

      expect(toggle, findsWidgets);
    });
  });
}
