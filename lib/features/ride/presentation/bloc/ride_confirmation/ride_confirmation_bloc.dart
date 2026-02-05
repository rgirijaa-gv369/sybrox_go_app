import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

/// EVENTS
abstract class RideConfirmationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SelectTipAmount extends RideConfirmationEvent {
  final int amount;
  SelectTipAmount(this.amount);

  @override
  List<Object?> get props => [amount];
}

class ResetTip extends RideConfirmationEvent {}

/// STATE
class RideConfirmationState extends Equatable {
  final String otp;
  final int? selectedTip;

  const RideConfirmationState({required this.otp, this.selectedTip});

  bool get isTipSelected => selectedTip != null;

  RideConfirmationState copyWith({int? selectedTip}) {
    return RideConfirmationState(otp: otp, selectedTip: selectedTip);
  }

  @override
  List<Object?> get props => [otp, selectedTip];
}

class RideConfirmationBloc
    extends Bloc<RideConfirmationEvent, RideConfirmationState> {
  RideConfirmationBloc({required String otp})
    : super(RideConfirmationState(otp: otp)) {
    on<SelectTipAmount>((event, emit) {
      emit(state.copyWith(selectedTip: event.amount));
    });

    on<ResetTip>((event, emit) {
      emit(RideConfirmationState(otp: state.otp));
    });
  }
}
