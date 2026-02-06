import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/ride_status/ride_status_bloc.dart';

class RideStatusCard extends StatelessWidget {
  final VoidCallback onConfirmed;

  const RideStatusCard({super.key, required this.onConfirmed});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RideBloc()..add(StartRide()),
      child: RideStatusScreen(onConfirmed: onConfirmed),
    );
  }
}

class RideStatusScreen extends StatelessWidget {
  final VoidCallback onConfirmed;
  const RideStatusScreen({super.key, required this.onConfirmed});

  static const List<String> titles = [
    'Confirming your ride',
    'Confirming your ride',
    'Looking for nearby rider',
    'We found a rider nearby',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocListener<RideBloc, RideState>(
      listener: (context, state) {
        if (state.step == 3) {
          onConfirmed();
        }
      },
      child: BlocBuilder<RideBloc, RideState>(
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  RideStatusScreen.titles[state.step],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                _ProgressBar(step: state.step),
                const SizedBox(height: 24),
                Image.asset(
                  'assets/images/scooter.png',
                  errorBuilder: (_, __, ___) => const SizedBox(
                    height: 100,
                    child: Icon(Icons.motorcycle, size: 80),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  final int step;
  const _ProgressBar({required this.step});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(10, (index) {
        final active = index <= (step + 1) * 2;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          height: 6,
          width: 18,
          decoration: BoxDecoration(
            color: active ? Colors.orange : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}
