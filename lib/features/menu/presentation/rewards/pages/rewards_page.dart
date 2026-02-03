import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/rewards_bloc.dart';
import '../bloc/rewards_event.dart';
import '../bloc/rewards_state.dart';
import '../widgets/reward_card_widget.dart';

class RewardsPage extends StatelessWidget {
  const RewardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RewardsBloc()..add(LoadRewardsEvent()),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 16,
                  color: Colors.black,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
          centerTitle: true,
          title: const Text(
            'Rewards',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        body: BlocBuilder<RewardsBloc, RewardsState>(
          builder: (context, state) {
            if (state is RewardsLoaded) {
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.rewards.length,
                itemBuilder: (context, index) {
                  return RewardCardWidget(reward: state.rewards[index]);
                },
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
