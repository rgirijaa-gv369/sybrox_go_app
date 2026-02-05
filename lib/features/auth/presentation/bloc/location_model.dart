class LocationData {
  final String name;
  final String address;
  final double? latitude;
  final double? longitude;

  LocationData({
    required this.name,
    required this.address,
    this.latitude,
    this.longitude,
  });

  LocationData copyWith({
    String? name,
    String? address,
    double? latitude,
    double? longitude,
  }) {
    return LocationData(
      name: name ?? this.name,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}
