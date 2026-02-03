import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/reward_model.dart';
import 'rewards_event.dart';
import 'rewards_state.dart';

class RewardsBloc extends Bloc<RewardsEvent, RewardsState> {
  RewardsBloc() : super(RewardsInitial()) {
    on<LoadRewardsEvent>(_onLoadRewards);
  }

  void _onLoadRewards(LoadRewardsEvent event, Emitter<RewardsState> emit) {
    // Dummy Data
    final rewards = [
      const RewardModel(
        id: '1',
        title: '50% off',
        description: 'Code: WED20',
        points: 'Wheel',
      ),
      const RewardModel(
        id: '2',
        title: '20% off',
        description: 'Code: FRIAY',
        points: 'Wheel',
      ),
    ];
    emit(RewardsLoaded(rewards));
  }
}
