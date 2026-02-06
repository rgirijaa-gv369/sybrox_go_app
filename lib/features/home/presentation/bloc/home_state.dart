import 'package:equatable/equatable.dart';
import '../../data/models/message_model.dart';

class RideState extends Equatable {
  final List<Ride> rides;
  final int completedOrders;
  final bool isLoading;
  final bool showCouponProgress;

  const RideState({
    this.rides = const [],
    this.completedOrders = 1, // Start with 1 as shown in screenshot
    this.isLoading = false,
    this.showCouponProgress = true, // Always show coupon section
  });

  @override
  List<Object> get props => [
    rides,
    completedOrders,
    isLoading,
    showCouponProgress,
  ];

  RideState copyWith({
    List<Ride>? rides,
    int? completedOrders,
    bool? isLoading,
    bool? showCouponProgress,
  }) {
    return RideState(
      rides: rides ?? this.rides,
      completedOrders: completedOrders ?? this.completedOrders,
      isLoading: isLoading ?? this.isLoading,
      showCouponProgress: showCouponProgress ?? this.showCouponProgress,
    );
  }
}
