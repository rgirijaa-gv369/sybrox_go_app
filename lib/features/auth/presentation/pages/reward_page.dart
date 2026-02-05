import 'package:flutter/material.dart';
import 'dart:math' as math;

class CoinRewardScreen extends StatefulWidget {
  const CoinRewardScreen({Key? key}) : super(key: key);

  @override
  State<CoinRewardScreen> createState() => _CoinRewardScreenState();
}

class _CoinRewardScreenState extends State<CoinRewardScreen>
    with TickerProviderStateMixin {
  late AnimationController _coinController;
  late AnimationController _buttonController;
  late Animation<double> _coinAnimation;
  late Animation<double> _buttonScale;
  bool _isClaimed = false;

  @override
  void initState() {
    super.initState();

    // Coin bounce animation
    _coinController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _coinAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _coinController,
        curve: Curves.elasticOut,
      ),
    );

    // Button press animation
    _buttonController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );

    _buttonScale = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(
        parent: _buttonController,
        curve: Curves.easeInOut,
      ),
    );

    _coinController.forward();
  }

  @override
  void dispose() {
    _coinController.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  void _handleClaimCoins() async {
    if (_isClaimed) return;

    // Button press animation
    await _buttonController.forward();
    await _buttonController.reverse();

    setState(() {
      _isClaimed = true;
    });

    // Show success dialog
    await Future.delayed(const Duration(milliseconds: 300));
    if (!mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 64,
            ),
            const SizedBox(height: 16),
            const Text(
              'Coins Claimed!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '10 coins have been added to your wallet',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                _isClaimed = false;
              });
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.orange,
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'OK',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
        actionsAlignment: MainAxisAlignment.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Image.asset(
          'assets/images/success_backgroud.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}




// Coin stack widget
class CoinStack extends StatelessWidget {
  const CoinStack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 120,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Shadow
          Positioned(
            bottom: 0,
            child: Container(
              width: 100,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
            ),
          ),

          // Coins
          Positioned(
            bottom: 25,
            child: _buildCoin(0),
          ),
          Positioned(
            bottom: 35,
            left: 20,
            child: _buildCoin(5),
          ),
          Positioned(
            bottom: 45,
            left: 10,
            child: _buildCoin(-10),
          ),
        ],
      ),
    );
  }

  Widget _buildCoin(double rotation) {
    return Transform.rotate(
      angle: rotation * math.pi / 180,
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFFD54F),
              Color(0xFFFFA726),
              Color(0xFFFF9800),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.orange.withOpacity(0.5),
              blurRadius: 15,
              spreadRadius: 2,
            ),
          ],
          border: Border.all(
            color: Colors.white,
            width: 3,
          ),
        ),
        child: Center(
          child: Text(
            '₹',
            style: TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.3),
                  offset: const Offset(2, 2),
                  blurRadius: 4,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Dashed line painter
class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.5)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    const dashWidth = 8;
    const dashSpace = 6;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, 0),
        Offset(startX + dashWidth, 0),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}