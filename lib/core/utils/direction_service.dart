import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../constants/api_keys.dart';

class DirectionService {
  static const _apiKey = "YOUR_GOOGLE_MAPS_KEY";

  Future<List<LatLng>> getRoute(LatLng start, LatLng end) async {
    final url =
        "https://maps.googleapis.com/maps/api/directions/json"
        "?origin=${start.latitude},${start.longitude}"
        "&destination=${end.latitude},${end.longitude}"
        "&key=${ApiKeys.googleMapsApiKey}";

    final res = await http.get(Uri.parse(url));
    final data = json.decode(res.body);

    if (data['status'] != 'OK') {
      return [];
    }

    final points = data['routes'][0]['overview_polyline']['points'];
    return _decodePolyline(points);
  }

  List<LatLng> _decodePolyline(String polyline) {
    List<LatLng> coords = [];
    int index = 0, lat = 0, lng = 0;

    while (index < polyline.length) {
      int b, shift = 0, result = 0;
      do {
        b = polyline.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = polyline.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      coords.add(LatLng(lat / 1E5, lng / 1E5));
    }
    return coords;
  }
}
