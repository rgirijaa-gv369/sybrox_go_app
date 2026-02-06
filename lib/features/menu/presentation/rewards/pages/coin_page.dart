import 'package:flutter/material.dart';
import 'transactions_page.dart';

class CoinPage extends StatefulWidget {
  const CoinPage({super.key});

  @override
  State<CoinPage> createState() => _CoinPageState();
}

class _CoinPageState extends State<CoinPage> {
  bool _alwaysUseCoins = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: _buildAppBar(context, 'Go Coin'),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCoinCard(),
                    const SizedBox(height: 16),
                    _buildDiscountCard(),
                    const SizedBox(height: 16),
                    _buildToggleCard(),
                  ],
                ),
              ),
            ),
          ),
          _buildTransactionButton(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, String title) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      leadingWidth: 56,
      leading: Container(
        margin: const EdgeInsets.only(left: 16),
        child: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w700,
          color: Colors.black,
          letterSpacing: 0.07,
        ),
      ),
      centerTitle: true,
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 16),
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFFFC46B),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: const Color(0xFFFFAA2B), width: 1),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 6),
                child: Image.asset(
                  'assets/images/coins/Smallcoin.png',
                  width: 16,
                  height: 16,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 16,
                      height: 16,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFAA2B),
                        shape: BoxShape.circle,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 4),
              const Text(
                '20',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.person, color: Colors.white, size: 18),
              ),
            ],
          ),
        ),
      ],
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
      ),
    );
  }

  Widget _buildCoinCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/coins/coin_stack.png',
            width: 165,
            height: 165,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 165,
                height: 165,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE0B2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Icon(
                    Icons.monetization_on,
                    size: 60,
                    color: Colors.orange[300],
                  ),
                ),
              );
            },
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '20',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 2),

                const Text(
                  'Coin Earned',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF666666),
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 12),

                IntrinsicWidth(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFE0B2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/images/coins/Smallcoin.png',
                          width: 16,
                          height: 16,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 16,
                              height: 16,
                              decoration: const BoxDecoration(
                                color: Color(0xFFFFC46B),
                                shape: BoxShape.circle,
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 5),
                        const Flexible(
                          child: Text(
                            '10 Earned in last ride',
                            style: TextStyle(
                              fontSize: 10,
                              color: Color(0xFF7A3D00),
                              fontWeight: FontWeight.w600,
                              height: 1.1,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                GestureDetector(
                  onTap: () {},
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Learn More',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF2196F3),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 2),
                      Icon(
                        Icons.chevron_right,
                        color: Color(0xFF2196F3),
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDiscountCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF2E1300),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF805204).withOpacity(0.5),
            blurRadius: 40,
            spreadRadius: 0,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF805204).withOpacity(0.6),
                  blurRadius: 25,
                  spreadRadius: -3,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Image.asset(
              'assets/images/coins/coins_group.png',
              width: 100,
              height: 100,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.brown[700],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.monetization_on,
                      size: 48,
                      color: Colors.white70,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 16),

          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Use Go Coin to enjoy a\ndiscount on your ride!',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    height: 1.35,
                    letterSpacing: 0.2,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '10 Go Coins = ₹1',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Always you Go coin',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Use Go Coin to enjoy a discount on your ride!',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF888888),
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),

          Transform.scale(
            scale: 0.9,
            child: Switch(
              value: _alwaysUseCoins,
              onChanged: (value) {
                setState(() {
                  _alwaysUseCoins = value;
                });
              },
              activeThumbColor: const Color(0xFFFFAA2B),
              activeTrackColor: const Color(0xFFFFE0B2),
              inactiveThumbColor: const Color(0xFFF5F5F5),
              inactiveTrackColor: const Color(0xFFE0E0E0),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionButton() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TransactionsPage()),
            );
          },
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'View all coin transactions',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                Icon(Icons.chevron_right, color: Colors.grey[600], size: 22),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
