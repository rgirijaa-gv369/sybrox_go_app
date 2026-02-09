import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../core/utils/direction_service.dart';
import '../../../../core/utils/fare_service.dart';
import '../../../../core/utils/location_service.dart';
import '../../domain/entities/ride_step.dart';
import '../bloc/ride_status/ride_status_bloc.dart';
import '../widgets/bottom_ride_card.dart';
import '../widgets/ride_confirm_card.dart';
import '../widgets/ride_status_card.dart';
import '../widgets/rider_not_found_card.dart';

class RideMapScreen extends StatefulWidget {
  final LatLng pickup;
  final LatLng drop;

  const RideMapScreen({super.key, required this.pickup, required this.drop});

  @override
  State<RideMapScreen> createState() => _RideMapScreenState();
}

class _RideMapScreenState extends State<RideMapScreen> {
  final Completer<GoogleMapController> _mapController = Completer();

  RideStep currentStep = RideStep.selectRide;
  void goToNext(RideStep step) {
    setState(() {
      currentStep = step;
    });
  }

  static const LatLng _pGoogleLoc = LatLng(12.9229, 80.1275);

  late LatLng _pickup;
  late LatLng _drop;

  Timer? _driverTimer;
  LatLng _driverLocation = const LatLng(12.9229, 80.1275);
  bool _isRideBooked = false;
  bool isEnabled = true;
  Set<Polyline> _polylines = {};
  final DirectionService _directionService = DirectionService();
  final FareService _fareService = FareService();
  double _distanceKm = 0;
  double _durationMin = 0;
  double _fare = 0;

  @override
  void initState() {
    super.initState();
    _pickup = widget.pickup;
    _drop = widget.drop;
    _isRideBooked = true;
    _computeRideDetails();
    _moveToCurrentLocation();
    _loadRoute();
    _startDriverTracking();
  }

  Future<void> _moveToCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final controller = await _mapController.future;
      controller.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(position.latitude, position.longitude),
          14,
        ),
      );
    } catch (e) {
      debugPrint("Location error: $e");
    }
  }

  Future<void> _loadRoute() async {
    try {
      final points = await _directionService.getRoute(_pickup, _drop);
      if (!mounted) return;
      setState(() {
        _polylines = {
          Polyline(
            polylineId: const PolylineId('route'),
            color: Colors.blue,
            width: 4,
            points: points,
          ),
        };
      });
    } catch (e) {
      debugPrint("Route error: $e");
    }
  }

  void _computeRideDetails() {
    final distanceKm = LocationService.calculateDistanceKm(
      pickupLat: _pickup.latitude,
      pickupLng: _pickup.longitude,
      dropLat: _drop.latitude,
      dropLng: _drop.longitude,
    );
    const avgSpeedKmph = 25.0;
    final durationMin = (distanceKm / avgSpeedKmph) * 60;
    final fare = _fareService.calculateFare(distanceKm, durationMin);
    _distanceKm = distanceKm;
    _durationMin = durationMin < 1 ? 1 : durationMin;
    _fare = fare;
  }

  void _startDriverTracking() {
    _driverTimer?.cancel();

    _driverTimer = Timer.periodic(const Duration(seconds: 2), (_) {
      setState(() {
        _driverLocation = LatLng(
          _driverLocation.latitude + 0.00015,
          _driverLocation.longitude + 0.00012,
        );
      });
    });
  }

  @override
  void dispose() {
    _driverTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _pGoogleLoc, // India center
              zoom: 13,
            ),

            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            polylines: _polylines,
            onMapCreated: (controller) {
              if (!_mapController.isCompleted) {
                _mapController.complete(controller);
              }
            },
            markers: {
              Marker(
                markerId: const MarkerId("pickup"),
                position: _pickup,
                infoWindow: const InfoWindow(title: "Pickup"),
              ),
              Marker(
                markerId: const MarkerId("drop"),
                position: _drop,
                icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueRed,
                ),
                infoWindow: const InfoWindow(title: "Drop"),
              ),
              if (_isRideBooked)
                Marker(
                  markerId: const MarkerId("driver"),
                  position: _driverLocation,
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueAzure,
                  ),
                  infoWindow: const InfoWindow(title: "Driver on the way"),
                ),
            },
          ),

          Positioned(
            top: 45,
            left: 16,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),

          Positioned(
            right: 16,
            bottom: 220,
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: _moveToCurrentLocation,
              child: const Icon(Icons.my_location, color: Colors.black),
            ),
          ),

          if (currentStep == RideStep.selectRide)
            Positioned(
              left: 16,
              bottom: 200,
              child: _goCoinsToggle(),
            ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _buildBottomCard(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomCard() {
    switch (currentStep) {
      case RideStep.selectRide:
        return BottomRideCard(
          onNext: () => goToNext(RideStep.status),
          distanceKm: _distanceKm,
          durationMin: _durationMin,
          fare: _fare,
        );

      case RideStep.status:
        return RideStatusCard(
          onConfirmed: () => goToNext(RideStep.confirmation),
        );

      case RideStep.notFound:
        return RiderNotFoundCard(onRetry: () => goToNext(RideStep.selectRide));
      case RideStep.confirmation:
        return RideConfirmationCard(baseFare: _fare);
    }
  }

  Widget _goCoinsToggle() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "GO Coins",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(width: 10),

          GestureDetector(
            onTap: () => setState(() => isEnabled = !isEnabled),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: 44,
              height: 24,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: isEnabled
                    ? Colors.orange.shade100
                    : Colors.grey.shade400,
              ),
              child: Align(
                alignment: isEnabled
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.orange,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(width: 10),

          const Text(
            "20",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 6),

          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Colors.orange.shade100,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.orange.shade50, width: 2),
            ),
            child: Image.asset(
              'assets/images/coin.png',
              height: 20,
              errorBuilder: (_, __, ___) => const Icon(
                Icons.monetization_on,
                size: 16,
                color: Colors.orange,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
