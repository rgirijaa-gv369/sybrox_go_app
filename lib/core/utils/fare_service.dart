class FareService {
  double calculateFare(double distanceKm, double durationMin) {
    const baseFare = 20;
    const perKm = 8;
    const perMin = 1;

    return baseFare + (distanceKm * perKm) + (durationMin * perMin);
  }
}
