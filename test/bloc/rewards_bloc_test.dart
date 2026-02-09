import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sybrox_go_app/features/menu/presentation/rewards/bloc/rewards_bloc.dart';
import 'package:sybrox_go_app/features/menu/presentation/rewards/bloc/rewards_event.dart';
import 'package:sybrox_go_app/features/menu/presentation/rewards/bloc/rewards_state.dart';

void main() {
  group('RewardsBloc', () {
    blocTest<RewardsBloc, RewardsState>(
      'loads rewards',
      build: () => RewardsBloc(),
      act: (bloc) => bloc.add(LoadRewardsEvent()),
      expect: () => [
        isA<RewardsLoaded>().having((s) => s.rewards.length, 'rewards length', 2),
      ],
    );
  });
}
