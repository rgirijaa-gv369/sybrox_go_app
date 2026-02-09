import 'package:flutter/material.dart';
import 'package:sybrox_go_app/features/ride/presentation/widgets/ride_cancel_sheet.dart';

import '../pages/pickup_drop_page.dart';
import '../../../chat/presentation/pages/chat_page.dart';
import '../../../chat/presentation/pages/call_page.dart';
import '../pages/receipt_page.dart';

class RideConfirmationCard extends StatefulWidget {
  final double baseFare;
  const RideConfirmationCard({super.key, required this.baseFare});

  @override
  State<RideConfirmationCard> createState() => _RideConfirmationCardState();
}

class _RideConfirmationCardState extends State<RideConfirmationCard> {
  int? selectedAmount;
  final List<int> amounts = [10, 20, 30];

  @override
  Widget build(BuildContext context) {
    final double tipAmount = (selectedAmount ?? 0).toDouble();
    final double totalAmount = widget.baseFare + tipAmount;
    return SafeArea(
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.75,
        ),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 22,
                  backgroundImage: AssetImage(
                    'assets/images/google.png',
                  ), // Placeholder
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Vikash',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.orange,
                            size: 13,
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            '5.0',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'TN 24 AS 1989',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const ChatPage()),
                        );
                      },
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/chat.png',
                            height: 20,
                            errorBuilder: (_, __, ___) =>
                                const Icon(Icons.chat),
                          ),
                          const SizedBox(width: 8),
                          const Expanded(
                            child: Text(
                              'Send message to Rider',
                              style: TextStyle(fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const CallPage()),
                      );
                    },
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.grey.shade300,
                      child: Image.asset(
                        'assets/images/call.png',
                        height: 20,
                        errorBuilder: (_, __, ___) => const Icon(Icons.call),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: const TextSpan(
                                style: TextStyle(color: Colors.black),
                                children: [
                                  TextSpan(
                                    text: 'Verification code\n',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      height: 2.0,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        'Provide this code to rider to start\nthe ride',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: ['2', '0', '4', '3'].map((digit) {
                                return Container(
                                  margin: const EdgeInsets.only(right: 8),
                                  width: 24,
                                  height: 40,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade50,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    digit,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // New Tip Selection Section
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "Add amount",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(width: 24),
                  ...amounts.map((amount) => _amountChip(amount)),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _fareRow('Base fare', widget.baseFare),
                  _fareRow('Tip', tipAmount),
                  const Divider(height: 16),
                  _fareRow('Total', totalAmount, isTotal: true),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Cancel Ride Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  CancelRideHelper(context).showCancelDialog();
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Cancel Ride',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ), // Adjusted as per diff
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Proceed to Pay Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ReceiptPage(
                        baseFare: widget.baseFare,
                        tip: (selectedAmount ?? 0).toDouble(),
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: Colors.orange,
                ),
                child: const Text(
                  "Proceed to Pay",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _fareRow(String label, double amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 15 : 13,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            ),
          ),
          Text(
            "Rs ${amount.toStringAsFixed(0)}",
            style: TextStyle(
              fontSize: isTotal ? 15 : 13,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _amountChip(int amount) {
    final bool isSelected = selectedAmount == amount;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Listener(
        behavior: HitTestBehavior.translucent,
        onPointerDown: (_) {
          debugPrint("Tapped ₹$amount");

          setState(() {
            selectedAmount = amount;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: isSelected ? Colors.blue.shade50 : Colors.transparent,
            border: Border.all(
              color: isSelected ? Colors.black : Colors.grey.shade400,
            ),
          ),
          child: Text(
            "₹ $amount",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: isSelected ? Colors.black : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
