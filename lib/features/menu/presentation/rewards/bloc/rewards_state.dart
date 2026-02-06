import 'package:equatable/equatable.dart';
import '../../../domain/entities/reward_entity.dart';

abstract class RewardsState extends Equatable {
  const RewardsState();

  @override
  List<Object?> get props => [];
}

class RewardsInitial extends RewardsState {}

class RewardsLoaded extends RewardsState {
  final List<RewardEntity> rewards;

  const RewardsLoaded(this.rewards);

  @override
  List<Object?> get props => [rewards];
}
