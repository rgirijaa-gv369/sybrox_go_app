import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:permission_handler_platform_interface/permission_handler_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'package:sybrox_go_app/features/permission/presentation/bloc/location_bloc.dart';
import 'package:sybrox_go_app/features/permission/presentation/bloc/location_event.dart';
import 'package:sybrox_go_app/features/permission/presentation/bloc/location_state.dart';

class MockPermissionHandlerPlatform extends Mock
    with MockPlatformInterfaceMixin
    implements PermissionHandlerPlatform {}

void main() {
  late MockPermissionHandlerPlatform platform;

  setUpAll(() {
    registerFallbackValue(<Permission>[]);
  });

  setUp(() {
    platform = MockPermissionHandlerPlatform();
    PermissionHandlerPlatform.instance = platform;
  });

  blocTest<LocationBloc, LocationState>(
    'emits granted when permission is granted',
    build: () {
      when(() => platform.requestPermissions(any())).thenAnswer(
        (_) async => {Permission.location: PermissionStatus.granted},
      );
      return LocationBloc();
    },
    act: (bloc) => bloc.add(RequestLocationPermission()),
    expect: () => [isA<LocationPermissionGranted>()],
  );

  blocTest<LocationBloc, LocationState>(
    'emits permanent denied when permission is permanently denied',
    build: () {
      when(() => platform.requestPermissions(any())).thenAnswer(
        (_) async => {Permission.location: PermissionStatus.permanentlyDenied},
      );
      return LocationBloc();
    },
    act: (bloc) => bloc.add(RequestLocationPermission()),
    expect: () => [const LocationPermissionDenied(isPermanent: true)],
  );

  blocTest<LocationBloc, LocationState>(
    'emits denied when permission is denied',
    build: () {
      when(() => platform.requestPermissions(any())).thenAnswer(
        (_) async => {Permission.location: PermissionStatus.denied},
      );
      return LocationBloc();
    },
    act: (bloc) => bloc.add(RequestLocationPermission()),
    expect: () => [const LocationPermissionDenied(isPermanent: false)],
  );
}
