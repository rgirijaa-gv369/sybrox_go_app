import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

enum RideStatus { confirming1, confirming2, searching, found }

abstract class RideEvent {}

class StartRide extends RideEvent {}

class _NextStep extends RideEvent {}

class RideState {
  final int step;
  const RideState(this.step);
}

class RideBloc extends Bloc<RideEvent, RideState> {
  static const int maxSteps = 3;
  Timer? _timer;

  RideBloc() : super(const RideState(0)) {
    on<StartRide>(_onStart);
    on<_NextStep>(_onNext);
  }

  void _onStart(StartRide event, Emitter<RideState> emit) {
    _timer?.cancel();
    emit(const RideState(0));

    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      add(_NextStep());
    });
  }

  void _onNext(_NextStep event, Emitter<RideState> emit) {
    if (state.step < 3) {
      emit(RideState(state.step + 1));
    } else {
      _timer?.cancel();
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
