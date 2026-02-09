import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:geolocator_platform_interface/geolocator_platform_interface.dart';

import 'package:sybrox_go_app/features/auth/data/repositories/otp_repository.dart';
import 'package:sybrox_go_app/features/auth/presentation/bloc/otp_bloc.dart';
import 'package:sybrox_go_app/features/auth/presentation/pages/login_page.dart';
import 'package:sybrox_go_app/features/auth/presentation/pages/registration_page.dart';
import 'package:sybrox_go_app/features/auth/presentation/pages/pickup_drop.dart' as auth_pickup;
import 'package:sybrox_go_app/features/auth/presentation/pages/map_ride_page.dart' as auth_map;
import 'package:sybrox_go_app/features/auth/presentation/pages/reward_page.dart' as auth_reward;

import 'package:sybrox_go_app/features/chat/presentation/pages/chat_page.dart';
import 'package:sybrox_go_app/features/chat/presentation/pages/call_page.dart';

import 'package:sybrox_go_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:sybrox_go_app/features/home/presentation/pages/home_page.dart';

import 'package:sybrox_go_app/features/menu/domain/entities/ride_entity.dart';
import 'package:sybrox_go_app/features/menu/presentation/help_and_support/pages/claims_page.dart';
import 'package:sybrox_go_app/features/menu/presentation/help_and_support/pages/help_support_page.dart';
import 'package:sybrox_go_app/features/menu/presentation/my_rides/pages/my_rides_page.dart';
import 'package:sybrox_go_app/features/menu/presentation/my_rides/pages/ride_details_page.dart';
import 'package:sybrox_go_app/features/menu/presentation/payment/pages/payment_page.dart';
import 'package:sybrox_go_app/features/menu/presentation/payment/pages/reload_wallet_page.dart';
import 'package:sybrox_go_app/features/menu/presentation/refer_and_earn/pages/refer_and_earn_page.dart';
import 'package:sybrox_go_app/features/menu/presentation/rewards/pages/coin_page.dart';
import 'package:sybrox_go_app/features/menu/presentation/rewards/pages/rewards_page.dart';
import 'package:sybrox_go_app/features/menu/presentation/rewards/pages/transactions_page.dart';
import 'package:sybrox_go_app/features/menu/presentation/saved_location/saved_location_page.dart';
import 'package:sybrox_go_app/features/menu/presentation/settings/pages/preferences_page.dart';
import 'package:sybrox_go_app/features/menu/presentation/settings/pages/privacy_policy_page.dart';
import 'package:sybrox_go_app/features/menu/presentation/settings/pages/settings_page.dart';
import 'package:sybrox_go_app/features/menu/presentation/settings/pages/terms_conditions_page.dart';

import 'package:sybrox_go_app/features/permission/presentation/pages/location_page.dart';

import 'package:sybrox_go_app/features/ride/presentation/pages/pickup_drop_page.dart' as ride_pickup;
import 'package:sybrox_go_app/features/ride/presentation/pages/ride_map_page.dart' as ride_map;
import 'package:sybrox_go_app/features/ride/presentation/pages/reward_page.dart' as ride_reward;
import 'package:sybrox_go_app/features/ride/presentation/pages/ride_completion_page.dart';

class _TestAssetBundle extends CachingAssetBundle {
  static final Uint8List _transparentImage = base64Decode(
    'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR4nGNgYAAAAAMAASsJTYQAAAAASUVORK5CYII=',
  );

  @override
  Future<ByteData> load(String key) async {
    return ByteData.view(_transparentImage.buffer);
  }
}

class _FakeOtpRepository extends OtpRepository {
  @override
  Future<void> sendOtp(String phone) async {}

  @override
  Future<bool> verifyOtp(String otp) async => true;
}

Widget _wrap(Widget child) {
  return DefaultAssetBundle(
    bundle: _TestAssetBundle(),
    child: MaterialApp(home: child),
  );
}

Widget _wrapWithRideBloc(Widget child) {
  return DefaultAssetBundle(
    bundle: _TestAssetBundle(),
    child: MaterialApp(
      home: BlocProvider<RideBloc>(
        create: (_) => RideBloc(),
        child: child,
      ),
    ),
  );
}

Widget _wrapWithOtpBloc(Widget child) {
  return DefaultAssetBundle(
    bundle: _TestAssetBundle(),
    child: MaterialApp(
      home: BlocProvider<OtpBloc>(
        create: (_) => OtpBloc(_FakeOtpRepository()),
        child: child,
      ),
    ),
  );
}

class _FakeGoogleMapsFlutterPlatform extends GoogleMapsFlutterPlatform {
  @override
  Widget buildViewWithConfiguration(
    int creationId,
    PlatformViewCreatedCallback onPlatformViewCreated, {
    required MapWidgetConfiguration widgetConfiguration,
    MapConfiguration mapConfiguration = const MapConfiguration(),
    MapObjects mapObjects = const MapObjects(),
  }) {
    return Container(key: ValueKey('fake-google-map-$creationId'));
  }

  @override
  Future<void> init(int mapId) async {}

  @override
  Future<void> updateMapConfiguration(
    MapConfiguration configuration, {
    required int mapId,
  }) async {}

  @override
  Future<void> updateMarkers(
    MarkerUpdates markerUpdates, {
    required int mapId,
  }) async {}

  @override
  Future<void> updatePolygons(
    PolygonUpdates polygonUpdates, {
    required int mapId,
  }) async {}

  @override
  Future<void> updatePolylines(
    PolylineUpdates polylineUpdates, {
    required int mapId,
  }) async {}

  @override
  Future<void> updateCircles(
    CircleUpdates circleUpdates, {
    required int mapId,
  }) async {}

  @override
  Future<void> updateTileOverlays({
    required Set<TileOverlay> newTileOverlays,
    required int mapId,
  }) async {}

  @override
  Future<void> updateClusterManagers(
    ClusterManagerUpdates clusterManagerUpdates, {
    required int mapId,
  }) async {}

  @override
  Future<void> updateGroundOverlays(
    GroundOverlayUpdates groundOverlayUpdates, {
    required int mapId,
  }) async {}

  @override
  Future<void> animateCamera(CameraUpdate cameraUpdate, {required int mapId}) async {}

  @override
  Future<void> moveCamera(CameraUpdate cameraUpdate, {required int mapId}) async {}

  @override
  Future<LatLngBounds> getVisibleRegion({required int mapId}) async {
    return LatLngBounds(
      southwest: const LatLng(0, 0),
      northeast: const LatLng(0, 0),
    );
  }

  @override
  Stream<CameraMoveStartedEvent> onCameraMoveStarted({required int mapId}) =>
      const Stream.empty();

  @override
  Stream<CameraMoveEvent> onCameraMove({required int mapId}) =>
      const Stream.empty();

  @override
  Stream<CameraIdleEvent> onCameraIdle({required int mapId}) =>
      const Stream.empty();

  @override
  Stream<MarkerTapEvent> onMarkerTap({required int mapId}) =>
      const Stream.empty();

  @override
  Stream<InfoWindowTapEvent> onInfoWindowTap({required int mapId}) =>
      const Stream.empty();

  @override
  Stream<MarkerDragStartEvent> onMarkerDragStart({required int mapId}) =>
      const Stream.empty();

  @override
  Stream<MarkerDragEvent> onMarkerDrag({required int mapId}) =>
      const Stream.empty();

  @override
  Stream<MarkerDragEndEvent> onMarkerDragEnd({required int mapId}) =>
      const Stream.empty();

  @override
  Stream<PolylineTapEvent> onPolylineTap({required int mapId}) =>
      const Stream.empty();

  @override
  Stream<PolygonTapEvent> onPolygonTap({required int mapId}) =>
      const Stream.empty();

  @override
  Stream<CircleTapEvent> onCircleTap({required int mapId}) =>
      const Stream.empty();

  @override
  Stream<MapTapEvent> onTap({required int mapId}) => const Stream.empty();

  @override
  Stream<MapLongPressEvent> onLongPress({required int mapId}) =>
      const Stream.empty();

  @override
  Stream<ClusterTapEvent> onClusterTap({required int mapId}) =>
      const Stream.empty();

  @override
  Stream<GroundOverlayTapEvent> onGroundOverlayTap({required int mapId}) =>
      const Stream.empty();

  @override
  void dispose({required int mapId}) {}
}

class _FakeGeolocatorPlatform extends GeolocatorPlatform {
  @override
  Future<bool> isLocationServiceEnabled() async => false;

  @override
  Future<LocationPermission> checkPermission() async =>
      LocationPermission.denied;

  @override
  Future<LocationPermission> requestPermission() async =>
      LocationPermission.denied;

  @override
  Future<Position> getCurrentPosition({
    LocationSettings? locationSettings,
  }) async {
    return Position(
      latitude: 0,
      longitude: 0,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      altitudeAccuracy: 0,
      heading: 0,
      headingAccuracy: 0,
      speed: 0,
      speedAccuracy: 0,
    );
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  GoogleMapsFlutterPlatform.instance = _FakeGoogleMapsFlutterPlatform();
  GeolocatorPlatform.instance = _FakeGeolocatorPlatform();

  group('Auth Pages', () {
    testWidgets('LoginOtpPage renders', (tester) async {
      await tester.pumpWidget(_wrapWithOtpBloc(const LoginOtpPage()));
      expect(find.byType(LoginOtpPage), findsOneWidget);
    });

    testWidgets('RegistrationPage renders', (tester) async {
      await tester.pumpWidget(_wrap(const RegistrationPage()));
      expect(find.byType(RegistrationPage), findsOneWidget);
    });

    testWidgets('Auth PickupDropPage renders', (tester) async {
      await tester.pumpWidget(_wrap(const auth_pickup.PickupDropPage()));
      expect(find.byType(auth_pickup.PickupDropPage), findsOneWidget);
    });

    testWidgets('Auth RideMapScreen renders', (tester) async {
      await tester.pumpWidget(
        _wrap(
          auth_map.RideMapScreen(
            pickup: const LatLng(12.9, 80.1),
            drop: const LatLng(12.95, 80.2),
          ),
        ),
      );
      expect(find.byType(auth_map.RideMapScreen), findsOneWidget);
    });

    testWidgets('Auth CoinRewardScreen renders', (tester) async {
      await tester.pumpWidget(_wrap(const auth_reward.CoinRewardScreen()));
      expect(find.byType(auth_reward.CoinRewardScreen), findsOneWidget);
    });
  });

  group('Chat Pages', () {
    testWidgets('ChatPage renders', (tester) async {
      await tester.pumpWidget(_wrap(const ChatPage()));
      expect(find.byType(ChatPage), findsOneWidget);
    });

    testWidgets('CallPage renders', (tester) async {
      await tester.pumpWidget(_wrap(const CallPage()));
      expect(find.byType(CallPage), findsOneWidget);
    });
  });

  group('Home Page', () {
    testWidgets('HomePage renders', (tester) async {
      await tester.pumpWidget(_wrapWithRideBloc(const HomePage()));
      await tester.pump();
      expect(find.byType(HomePage), findsOneWidget);
    });
  });

  group('Menu Pages', () {
    testWidgets('ClaimsPage renders', (tester) async {
      await tester.pumpWidget(_wrap(const ClaimsPage()));
      expect(find.byType(ClaimsPage), findsOneWidget);
    });

    testWidgets('HelpSupportPage renders', (tester) async {
      await tester.pumpWidget(_wrap(const HelpSupportPage()));
      expect(find.byType(HelpSupportPage), findsOneWidget);
    });

    testWidgets('MyRidesPage renders', (tester) async {
      await tester.pumpWidget(_wrap(const MyRidesPage()));
      expect(find.byType(MyRidesPage), findsOneWidget);
    });

    testWidgets('RideDetailsPage renders', (tester) async {
      const ride = RideEntity(
        id: '1',
        pickupLocation: 'Pickup',
        dropLocation: 'Drop',
        date: '01 Jan 2024',
        time: '10:00am',
        amount: 100.0,
        isCompleted: true,
        fareBreakdown: {'Total Fare': 100.0},
        distanceKm: 5.0,
        durationMins: 10.0,
      );
      await tester.pumpWidget(_wrap(const RideDetailsPage(ride: ride)));
      expect(find.byType(RideDetailsPage), findsOneWidget);
    });

    testWidgets('PaymentPage renders', (tester) async {
      await tester.pumpWidget(_wrap(const PaymentPage()));
      expect(find.byType(PaymentPage), findsOneWidget);
    });

    testWidgets('ReloadWalletPage renders', (tester) async {
      await tester.pumpWidget(_wrap(const ReloadWalletPage()));
      expect(find.byType(ReloadWalletPage), findsOneWidget);
    });

    testWidgets('ReferAndEarnPage renders', (tester) async {
      await tester.pumpWidget(_wrap(const ReferAndEarnPage()));
      expect(find.byType(ReferAndEarnPage), findsOneWidget);
    });

    testWidgets('CoinPage renders', (tester) async {
      await tester.pumpWidget(_wrap(const CoinPage()));
      expect(find.byType(CoinPage), findsOneWidget);
    });

    testWidgets('RewardsPage renders', (tester) async {
      await tester.pumpWidget(_wrap(const RewardsPage()));
      expect(find.byType(RewardsPage), findsOneWidget);
    });

    testWidgets('TransactionsPage renders', (tester) async {
      await tester.pumpWidget(_wrap(const TransactionsPage()));
      expect(find.byType(TransactionsPage), findsOneWidget);
    });

    testWidgets('SavedLocationPage renders', (tester) async {
      await tester.pumpWidget(_wrap(const SavedLocationPage()));
      expect(find.byType(SavedLocationPage), findsOneWidget);
    });

    testWidgets('PreferencesPage renders', (tester) async {
      await tester.pumpWidget(_wrap(const PreferencesPage()));
      expect(find.byType(PreferencesPage), findsOneWidget);
    });

    testWidgets('PrivacyPolicyPage renders', (tester) async {
      await tester.pumpWidget(_wrap(const PrivacyPolicyPage()));
      expect(find.byType(PrivacyPolicyPage), findsOneWidget);
    });

    testWidgets('SettingsPage renders', (tester) async {
      await tester.pumpWidget(_wrap(const SettingsPage()));
      expect(find.byType(SettingsPage), findsOneWidget);
    });

    testWidgets('TermsConditionsPage renders', (tester) async {
      await tester.pumpWidget(_wrap(const TermsConditionsPage()));
      expect(find.byType(TermsConditionsPage), findsOneWidget);
    });
  });

  group('Permission Page', () {
    testWidgets('LocationPage renders', (tester) async {
      await tester.pumpWidget(_wrap(const LocationPage()));
      expect(find.byType(LocationPage), findsOneWidget);
    });
  });

  group('Ride Pages', () {
    testWidgets('Ride PickupDropPage renders', (tester) async {
      await tester.pumpWidget(_wrap(const ride_pickup.PickupDropPage()));
      expect(find.byType(ride_pickup.PickupDropPage), findsOneWidget);
    });

    testWidgets('Ride RideMapScreen renders', (tester) async {
      await tester.pumpWidget(
        _wrap(
          ride_map.RideMapScreen(
            pickup: const LatLng(12.9, 80.1),
            drop: const LatLng(12.95, 80.2),
          ),
        ),
      );
      expect(find.byType(ride_map.RideMapScreen), findsOneWidget);
    });

    testWidgets('Ride CoinRewardScreen renders', (tester) async {
      await tester.pumpWidget(_wrap(const ride_reward.CoinRewardScreen()));
      expect(find.byType(ride_reward.CoinRewardScreen), findsOneWidget);
    });

    testWidgets('RideCompletionScreen renders', (tester) async {
      await tester.pumpWidget(_wrap(const RideCompletionScreen()));
      expect(find.byType(RideCompletionScreen), findsOneWidget);
    });
  });
}
