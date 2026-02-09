import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:geolocator_platform_interface/geolocator_platform_interface.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'package:sybrox_go_app/core/utils/location_service.dart';


class MockGeolocatorPlatform extends Mock
    with MockPlatformInterfaceMixin
    implements GeolocatorPlatform {}

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late MockGeolocatorPlatform geolocator;
  late MockHttpClient httpClient;

  setUpAll(() {
    registerFallbackValue(Uri.parse('http://localhost'));
    registerFallbackValue(<String, String>{});
    registerFallbackValue(LocationAccuracy.best);
    registerFallbackValue(const Duration(seconds: 1));
  });

  setUp(() {
    geolocator = MockGeolocatorPlatform();
    httpClient = MockHttpClient();
  });

  group('LocationService.calculateDistanceKm', () {
    test('returns correct distance in KM', () {
      final distance = LocationService.calculateDistanceKm(
        pickupLat: 13.0827,
        pickupLng: 80.2707,
        dropLat: 12.9716,
        dropLng: 77.5946,
      );

      expect(distance, greaterThan(250));
      expect(distance, lessThan(350));
    });

    test('returns 0 for same coordinates', () {
      final distance = LocationService.calculateDistanceKm(
        pickupLat: 10,
        pickupLng: 10,
        dropLat: 10,
        dropLng: 10,
      );

      expect(distance, 0);
    });
  });

  group('LocationService.getCurrentLocation', () {
    test('returns position when permission granted', () async {
      GeolocatorPlatform.instance = geolocator;

      when(() => geolocator.isLocationServiceEnabled())
          .thenAnswer((_) async => true);

      when(() => geolocator.checkPermission())
          .thenAnswer((_) async => LocationPermission.always);

      when(() => geolocator.getCurrentPosition(
        locationSettings: any(named: 'locationSettings'),
      )).thenAnswer(
            (_) async => Position(
          latitude: 13,
          longitude: 80,
          timestamp: DateTime.now(),
          accuracy: 1,
          altitude: 0,
          altitudeAccuracy: 0,
          heading: 0,
          headingAccuracy: 0,
          speed: 0,
          speedAccuracy: 0,
        ),
      );

      final service = LocationService();
      final position = await service.getCurrentLocation();

      expect(position.latitude, 13);
      expect(position.longitude, 80);
    });

    test('throws exception when service disabled', () async {
      GeolocatorPlatform.instance = geolocator;

      when(() => geolocator.isLocationServiceEnabled())
          .thenAnswer((_) async => false);

      final service = LocationService();

      expect(
            () => service.getCurrentLocation(),
        throwsException,
      );
    });
  });

  group('OpenStreetMapService.searchPlace', () {
    test('returns list of place names on success', () async {
      final responseData = [
        {"display_name": "Chennai, Tamil Nadu"},
        {"display_name": "Chennai Central"}
      ];

      when(() => httpClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer(
            (_) async => http.Response(jsonEncode(responseData), 200),
      );

      final results = await OpenStreetMapService.searchPlace(
        'Chennai',
        client: httpClient,
      );

      expect(results.length, 2);
      expect(results.first, contains('Chennai'));
    });

    test('returns empty list on failure', () async {
      when(() => httpClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer(
            (_) async => http.Response('Error', 500),
      );

      final results = await OpenStreetMapService.searchPlace(
        'Invalid',
        client: httpClient,
      );

      expect(results, isEmpty);
    });
  });
}
