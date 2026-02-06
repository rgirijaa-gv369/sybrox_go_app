import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'location_event.dart';
import 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationInitial()) {
    on<RequestLocationPermission>(_onRequestLocationPermission);
  }

  void _onRequestLocationPermission(RequestLocationPermission event, Emitter<LocationState> emit) async {
    final status = await Permission.location.request();

    if (status.isGranted) {
      emit(LocationPermissionGranted());
    } else if (status.isPermanentlyDenied) {
      emit(const LocationPermissionDenied(isPermanent: true));
    } else {
      emit(const LocationPermissionDenied(isPermanent: false));
    }
  }
}
