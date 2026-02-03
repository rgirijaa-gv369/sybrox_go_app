import '../../domain/entities/ride_entity.dart';

class RideModel extends RideEntity {
  const RideModel({
    required super.id,
    required super.pickupLocation,
    required super.dropLocation,
    required super.date,
    required super.time,
    required super.amount,
    required super.isCompleted,
    super.fareBreakdown,
    super.distanceKm,
    super.durationMins,
  });
}
