import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/location_service.dart';
import 'location_event.dart';
import 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationService _locationService = LocationService();

  LocationBloc() : super(const LocationState()) {
    on<SetPickupLocation>(_setPickup);
    on<SetDropLocation>(_setDrop);
    on<LoadCurrentLocation>(_loadCurrentLocation);
  }

  void _setPickup(SetPickupLocation event, Emitter<LocationState> emit) {
    emit(state.copyWith(pickupAddress: event.address));
  }

  void _setDrop(SetDropLocation event, Emitter<LocationState> emit) {
    emit(state.copyWith(dropAddress: event.address));
  }

  Future<void> _loadCurrentLocation(
    LoadCurrentLocation event,
    Emitter<LocationState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    // Ideally call _locationService.getCurrentLocation() and convert to address here
    // For now keeping simple as per source commit structure
    // const currentAddress = "Current Location";

    // In a real scenario you would:
    // final pos = await _locationService.getCurrentLocation();
    // final addr = await _locationService.convertPositionToAddress(pos.latitude, pos.longitude);

    emit(
      state.copyWith(
        // pickupAddress: addr,
        isLoading: false,
      ),
    );
  }
}
