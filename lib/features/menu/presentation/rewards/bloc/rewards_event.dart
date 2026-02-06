import 'package:equatable/equatable.dart';

abstract class RewardsEvent extends Equatable {
  const RewardsEvent();

  @override
  List<Object?> get props => [];
}

class LoadRewardsEvent extends RewardsEvent {}
