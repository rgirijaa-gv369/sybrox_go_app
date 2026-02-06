import 'package:flutter/material.dart';

class RewardsPage extends StatelessWidget {
  const RewardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy Data
    final List<Map<String, dynamic>> vouchers = [
      {
        'type': 'welcome',
        'code': 'WelcomeGo',
        'isExpired': false,
        'discount': '50% off on your 1st ride',
      },
      {'type': 'normal', 'code': '', 'isExpired': false, 'discount': ''},
      {'type': 'normal', 'code': '', 'isExpired': false, 'discount': ''},
      {'type': 'normal', 'code': '', 'isExpired': true, 'discount': ''},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Center(
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 18,
                  color: Colors.black,
                ),
                onPressed: () => Navigator.pop(context),
                padding: EdgeInsets.zero,
              ),
            ),
          ),
        ),
        title: const Text(
          'Rewards',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
        ),
        shadowColor: Colors.black.withOpacity(0.5),
      ),
      body: Column(
        children: [
          // Orange Banner Section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            decoration: const BoxDecoration(
              color: Color(0xFFFFA726), // Solid Orange as per image
            ),
            child: Center(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFCC80), // Lighter orange/peach
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'Vouchers - 3',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),

          // Grid Section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.85, // Slightly taller for content
                ),
                itemCount: vouchers.length,
                itemBuilder: (context, index) {
                  return _buildVoucherCard(vouchers[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVoucherCard(Map<String, dynamic> voucher) {
    final bool isExpired = voucher['isExpired'] == true;
    final bool isWelcome = voucher['type'] == 'welcome';

    // Background Color
    Color bgColor = const Color(0xFF42A5F5); // Blue
    if (isExpired) {
      bgColor = const Color(0xFFBDBDBD); // Grey
    }

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        // Add sunray pattern visible in all cards
        image: const DecorationImage(
          image: AssetImage('assets/images/voucher_pattern.png'),
          fit: BoxFit.cover,
          opacity: 0.1,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Logo Circle
          Positioned(
            top: isWelcome ? 20 : null,
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(isExpired ? 0.3 : 0.9),
              ),
              alignment: Alignment.center,
              child: Text(
                'GO',
                style: TextStyle(
                  color: isExpired
                      ? Colors.grey.shade600
                      : const Color(0xFFD32F2F),
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
          ),

          // Welcome Card Content
          if (isWelcome) ...[
            Positioned(
              bottom: 12,
              left: 12,
              right: 12,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '50% off on your 1st ride',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Code',
                    style: TextStyle(color: Colors.white70, fontSize: 10),
                  ),
                  const SizedBox(height: 2),
                  Container(
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: Colors.white,
                        style: BorderStyle.solid,
                      ), // Dashed look simulated or just solid
                    ),
                    padding: const EdgeInsets.only(left: 8, right: 4),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'WelcomeGo',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0D1B5E), // Dark Blue
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            'Copy',
                            style: TextStyle(color: Colors.white, fontSize: 8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],

          // Expired Badge
          if (isExpired)
            Positioned(
              bottom: 12,
              right: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Expired',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
