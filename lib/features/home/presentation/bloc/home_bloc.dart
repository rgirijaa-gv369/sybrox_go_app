import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/models/message_model.dart';
import 'home_event.dart';
import 'home_state.dart';

class RideBloc extends Bloc<RideEvent, RideState> {
  RideBloc() : super(const RideState()) {
    on<LoadRidesEvent>(_onLoadRides);
    on<AddRideEvent>(_onAddRide);
    on<CompleteRideEvent>(_onCompleteRide);
    on<BookAgainEvent>(_onBookAgain);
    on<IncrementOrderCountEvent>(_onIncrementOrderCount);
  }

  Future<void> _onLoadRides(
    LoadRidesEvent event,
    Emitter<RideState> emit,
  ) async {
    // Check if already loading or already loaded to prevent infinite loops
    if (state.isLoading) return;

    emit(state.copyWith(isLoading: true));

    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Mock data EXACTLY matching your screenshot
    final mockRides = [
      Ride(
        id: '1',
        fromLocation: 'IIT Madras C...',
        toLocation: 'Airports Authority ...',
        dateTime: DateTime(2024, 4, 23, 12, 8), // 23 Apr 2024, 12:08pm
        amount: 190.0,
        isCompleted: false,
      ),
    ];

    emit(state.copyWith(rides: mockRides, isLoading: false));
  }

  void _onAddRide(AddRideEvent event, Emitter<RideState> emit) {
    final newRide = Ride(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      fromLocation: event.from,
      toLocation: event.to,
      dateTime: event.dateTime,
      amount: event.amount,
    );

    final updatedRides = [newRide, ...state.rides];

    emit(state.copyWith(rides: updatedRides));
  }

  void _onCompleteRide(CompleteRideEvent event, Emitter<RideState> emit) {
    final updatedRides = state.rides.map((ride) {
      if (ride.id == event.rideId) {
        return ride.copyWith(isCompleted: true);
      }
      return ride;
    }).toList();

    final newOrderCount = state.completedOrders + 1;

    emit(
      state.copyWith(
        rides: updatedRides,
        completedOrders: newOrderCount,
        showCouponProgress: newOrderCount < 4,
      ),
    );
  }

  void _onBookAgain(BookAgainEvent event, Emitter<RideState> emit) {
    final rideToCopy = state.rides.firstWhere(
      (ride) => ride.id == event.rideId,
    );

    final newRide = Ride(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      fromLocation: rideToCopy.fromLocation,
      toLocation: rideToCopy.toLocation,
      dateTime: DateTime.now(),
      amount: rideToCopy.amount,
    );

    emit(state.copyWith(rides: [newRide, ...state.rides]));
  }

  void _onIncrementOrderCount(
    IncrementOrderCountEvent event,
    Emitter<RideState> emit,
  ) {
    final newOrderCount = state.completedOrders + 1;

    emit(
      state.copyWith(
        completedOrders: newOrderCount,
        showCouponProgress: newOrderCount < 4,
      ),
    );
  }
}
