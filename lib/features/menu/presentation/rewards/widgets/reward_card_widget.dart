import 'package:flutter/material.dart';
import '../../../domain/entities/reward_entity.dart';

class RewardCardWidget extends StatelessWidget {
  final RewardEntity reward;

  const RewardCardWidget({super.key, required this.reward});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF4A90E2), // Blue background like illustration
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min, // Wrap content height
        children: [
          // Left Side (Darker Blue part with text) - Actually based on image it's one card.
          // Let's approximate the "Ticket" look or just a uniform card as requested "List of reward cards".
          // Image shows: Blue card, "50% off", "Code: WED20", "Wheel" icon/text.
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    reward.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      reward.description,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Dotted line separator or just space? Image is cut off but implies a right section.
          Container(
            width: 1,
            height: 60,
            color: Colors.white.withOpacity(0.3),
            margin: const EdgeInsets.symmetric(vertical: 10),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Image Placeholder
                Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.settings,
                      color: Color(0xFF4A90E2),
                      size: 20,
                    ), // "Wheel" placeholder
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
