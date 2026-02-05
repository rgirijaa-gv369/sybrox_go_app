import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LocationService {
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
        'Location permission permanently denied. Please enable from settings.',
      );
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<String> convertPositionToAddress(
    double latitude,
    double longitude,
  ) async {
    final placemarks = await placemarkFromCoordinates(latitude, longitude);
    final place = placemarks.first;

    return "${place.street}, ${place.locality}, ${place.administrativeArea}";
  }

  Future<Position> getLatLngFromAddress(String address) async {
    final locations = await locationFromAddress(address);

    if (locations.isEmpty) {
      throw Exception("No location found for address");
    }

    return Position(
      latitude: locations.first.latitude,
      longitude: locations.first.longitude,
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

  static double calculateDistanceKm({
    required double pickupLat,
    required double pickupLng,
    required double dropLat,
    required double dropLng,
  }) {
    final distanceInMeters = Geolocator.distanceBetween(
      pickupLat,
      pickupLng,
      dropLat,
      dropLng,
    );

    return distanceInMeters / 1000;
  }
}

class OpenStreetMapService {
  static Future<List<String>> searchPlace(String query) async {
    final url = Uri.parse(
      "https://nominatim.openstreetmap.org/search?q=$query&format=json&addressdetails=1",
    );

    final response = await http.get(url, headers: {"User-Agent": "cab_app"});

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data.map<String>((e) => e["display_name"].toString()).toList();
    }
    return [];
  }
}
