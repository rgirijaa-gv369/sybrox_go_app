import 'package:flutter/material.dart';
import 'package:sybrox_go_app/features/menu/presentation/my_rides/pages/my_rides_page.dart';
import 'package:sybrox_go_app/features/menu/presentation/rewards/pages/rewards_page.dart';

void main() {
  runApp(const MenuFeatureTestApp());
}

class MenuFeatureTestApp extends StatelessWidget {
  const MenuFeatureTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(title: const Text('Menu Feature Verification')),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const MyRidesPage()),
                  ),
                  child: const Text('Open My Rides'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RewardsPage()),
                  ),
                  child: const Text('Open Rewards'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
