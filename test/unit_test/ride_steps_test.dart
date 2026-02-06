import 'package:flutter_test/flutter_test.dart';
import 'package:sybrox_go_app/features/ride/domain/entities/ride_step.dart';

void main() {
  group('RideStep enum', () {
    test('contains expected values', () {
      expect(RideStep.selectRide, isNotNull);
      expect(RideStep.status, isNotNull);
      expect(RideStep.notFound, isNotNull);
      expect(RideStep.confirmation, isNotNull);
    });
  });
}
