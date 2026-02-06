import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/ride_model.dart';
import 'my_rides_event.dart';
import 'my_rides_state.dart';

class MyRidesBloc extends Bloc<MyRidesEvent, MyRidesState> {
  MyRidesBloc() : super(MyRidesInitial()) {
    on<LoadMyRidesEvent>(_onLoadMyRides);
    on<SelectRideEvent>(_onSelectRide);
  }

  void _onLoadMyRides(LoadMyRidesEvent event, Emitter<MyRidesState> emit) {
    // Dummy Data EXACTLY matching images
    final rides = [
      const RideModel(
        id: '1',
        pickupLocation: 'IIT Madras Campus',
        dropLocation: 'Airports Authority of Indian',
        date: '23 Apr 2024',
        time: '12:08pm',
        amount: 190.0,
        isCompleted: true,
        fareBreakdown: {
          'Total Fare': 78.0,
          'Ride Charge': 61.0,
          'Booking Fees & Convenience Charges': 17.0,
        },
        distanceKm: 7.0,
        durationMins: 20.0,
      ),
      const RideModel(
        id: '2',
        pickupLocation: '5, 200 Feet Road',
        dropLocation: '5/705A, Gandhi Nagar',
        date: '04 Oct 2024',
        time: '08:02pm',
        amount: 0.0,
        isCompleted: false, // Cancel
        fareBreakdown: {},
        distanceKm: 0.0,
        durationMins: 0.0,
      ),
      const RideModel(
        id: '3',
        pickupLocation: 'Aiwarya Colony',
        dropLocation: 'Seevaram,chennai...',
        date: '23 Apr 2024',
        time: '12:08pm',
        amount: 190.0,
        isCompleted: true,
      ),
    ];
    emit(MyRidesLoaded(rides));
  }

  void _onSelectRide(SelectRideEvent event, Emitter<MyRidesState> emit) {
    emit(RideSelected(event.ride));
    // After selection, we usually might want to stay in Loaded state or have a separate mechanism,
    // but requested behavior is "Emits RideSelected".
    // Important: Emitting RideSelected replaces the list state.
    // In strict BLoC, the UI listening to this would navigate, then effectively the Bloc
    // needs to reset or the details page needs to use the data.
    // We will emit Loaded again immediately or handle this carefully in UI (Action vs State).
    // For now, adhering strictly to "Emits RideSelected".
  }
}
