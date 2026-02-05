import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sybrox_go_app/features/auth/presentation/widget/ride_status_card.dart';

import 'custom_divider.dart';

class BottomRideCard extends StatelessWidget {
  final VoidCallback onNext;
  const BottomRideCard({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFFFE0B2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children:  [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Image.asset('assets/images/scooter2.png', height: 30),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Ride",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.access_time, size: 14),
                          SizedBox(width: 4),
                          Text("18 mins", style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                ),
                Text("₹ 82",
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ),

          const SizedBox(height: 16),

          ListTile(
            leading: Image.asset('assets/images/cash.png', height: 40),
            title: const Text("Select payment Option",
                style: TextStyle(fontWeight: FontWeight.w600)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),

          const Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 14),
            child: DashedDivider(
              color: Colors.grey,
              dashWidth: 10,
              dashSpace: 8,
            ),
          ),


          ListTile(
            leading: Image.asset('assets/images/reward.png', height: 40),
            title: const Text("Apply Coupons",
                style: TextStyle(fontWeight: FontWeight.w600)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),

          const SizedBox(height: 16),

          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: onNext,
              child: const Text(
                "Book ride",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
