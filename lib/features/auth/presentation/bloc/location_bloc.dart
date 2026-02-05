import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/utils/location_service.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationService _locationService = LocationService();

  LocationBloc() : super(const LocationState()) {
    on<SetPickupLocation>(_setPickup);
    on<SetDropLocation>(_setDrop);
    on<LoadCurrentLocation>(_loadCurrentLocation);
  }

  void _setPickup(
      SetPickupLocation event,
      Emitter<LocationState> emit,
      ) {
    emit(state.copyWith(pickupAddress: event.address));
  }

  void _setDrop(
      SetDropLocation event,
      Emitter<LocationState> emit,
      ) {
    emit(state.copyWith(dropAddress: event.address));
  }

  Future<void> _loadCurrentLocation(
      LoadCurrentLocation event,
      Emitter<LocationState> emit,
      ) async {
    emit(state.copyWith(isLoading: true));

    const currentAddress = "Current Location";

    emit(state.copyWith(
      pickupAddress: currentAddress,
      isLoading: false,
    ));
  }

}
