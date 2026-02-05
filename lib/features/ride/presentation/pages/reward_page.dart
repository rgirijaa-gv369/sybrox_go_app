import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ---------------------------------------------------------------------------
// Main Screen
// ---------------------------------------------------------------------------
class CoinRewardScreen extends StatelessWidget {
  const CoinRewardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Force status bar style if needed
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    // Configuration for the visual center
    // 0.4 (40% height) places it slightly above distinct center,
    // matching the "Star Burst" look.
    const double kBurstCenterYRatio = 0.4;
    const double kCoinSize = 140.0;

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final double w = constraints.maxWidth;
          final double h = constraints.maxHeight;

          // 1. Calculate the shared center point
          final Offset centerPoint = Offset(w / 2, h * kBurstCenterYRatio);

          return Stack(
            fit: StackFit.expand,
            children: [
              // -------------------------------------------------------
              // Layer 1: Unified Background (Gradient + Rays)
              // -------------------------------------------------------
              CustomPaint(
                painter: _SunburstPainter(center: centerPoint),
                size: Size(w, h),
              ),

              // -------------------------------------------------------
              // Layer 2: The Coin
              // Mathematically centered on centerPoint
              // -------------------------------------------------------
              Positioned(
                left: centerPoint.dx - (kCoinSize / 2),
                top: centerPoint.dy - (kCoinSize / 2),
                width: kCoinSize,
                height: kCoinSize,
                child: Image.asset(
                  'assets/images/coin_stack.png',
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => const _FallbackCoinStack(),
                ),
              ),

              // -------------------------------------------------------
              // Layer 3: Text content
              // Positioned relative to the coin bottom
              // -------------------------------------------------------
              Positioned(
                top:
                    centerPoint.dy +
                    (kCoinSize / 2) +
                    30, // 30px padding below coin
                left: 20,
                right: 20,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      "You’ve received 10 coins for\nthis trip.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        height: 1.2,
                        letterSpacing: -0.5,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),

              // -------------------------------------------------------
              // Layer 4: Ticket Card
              // Pinned to bottom
              // -------------------------------------------------------
              const Positioned(
                bottom: 50,
                left: 20,
                right: 20,
                child: _TicketRewardCard(),
              ),

              // Back Button (Optional safety)
              Positioned(
                top: 50,
                left: 16,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Unified Painter (Gradient + Rays)
// ---------------------------------------------------------------------------
class _SunburstPainter extends CustomPainter {
  final Offset center;

  _SunburstPainter({required this.center});

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Draw Radial Gradient Background
    // We draw this manually to ensure it uses the EXACT same center as rays
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    // Calculate radius to cover corners
    // final maxDist = math.max(
    //   center.distance,
    //   (Offset(size.width, size.height) - center).distance
    // );

    // We use a relative alignment for the shader to match standard behavior
    // Center is relative to rect center.
    final gradient = RadialGradient(
      center: Alignment(
        (center.dx - size.width / 2) / (size.width / 2),
        (center.dy - size.height / 2) / (size.height / 2),
      ),
      radius: 1.5,
      colors: const [
        Color(0xFFFFCA28), // Amber 400
        Color(0xFFFF6F00), // Amber 900
      ],
      stops: const [0.0, 1.0],
    );

    final bgPaint = Paint()..shader = gradient.createShader(rect);

    canvas.drawRect(rect, bgPaint);

    // 2. Draw Rays
    // Originating correctly from [center]
    final rayPaint = Paint()
      ..color = Colors.white.withOpacity(0.15)
      ..style = PaintingStyle.fill;

    const int rayCount = 24;
    const double anglePerRay = 2 * math.pi / rayCount;
    final rayLength = size.longestSide * 1.5;

    for (int i = 0; i < rayCount; i++) {
      if (i % 2 == 0) continue;

      final startAngle = i * anglePerRay;

      final path = Path();
      path.moveTo(center.dx, center.dy);
      path.lineTo(
        center.dx + rayLength * math.cos(startAngle),
        center.dy + rayLength * math.sin(startAngle),
      );
      path.lineTo(
        center.dx + rayLength * math.cos(startAngle + anglePerRay),
        center.dy + rayLength * math.sin(startAngle + anglePerRay),
      );
      path.close();

      canvas.drawPath(path, rayPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _SunburstPainter oldDelegate) {
    return oldDelegate.center != center;
  }
}

// ---------------------------------------------------------------------------
// Fallback Widget
// ---------------------------------------------------------------------------
class _FallbackCoinStack extends StatelessWidget {
  const _FallbackCoinStack();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: const [
        Icon(Icons.monetization_on, size: 100, color: Colors.amber),
        Positioned(
          top: 10,
          left: 10,
          child: Icon(
            Icons.monetization_on,
            size: 100,
            color: Colors.amberAccent,
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Ticket Reward Card
// ---------------------------------------------------------------------------
class _TicketRewardCard extends StatelessWidget {
  const _TicketRewardCard();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _TicketShapePainter(color: const Color(0xFFFFCC80)),
      child: Container(
        height: 180,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          children: [
            // Coin + Text Row
            Expanded(
              flex: 5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/single_coin.png',
                    height: 32,
                    errorBuilder: (_, __, ___) =>
                        const Icon(Icons.monetization_on, color: Colors.amber),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    "10 coins",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF8D6E63),
                    ),
                  ),
                ],
              ),
            ),

            const _DashedDivider(),

            // Button Row
            Expanded(
              flex: 5,
              child: Center(
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      // Claim logic stub
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Claim the coins",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Dashed Divider
// ---------------------------------------------------------------------------
class _DashedDivider extends StatelessWidget {
  const _DashedDivider();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 6.0;
        const dashHeight = 1.0;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.brown.withOpacity(0.3)),
              ),
            );
          }),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Ticket Shape Painter
// ---------------------------------------------------------------------------
class _TicketShapePainter extends CustomPainter {
  final Color color;
  const _TicketShapePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    const cornerRadius = 16.0;
    const notchRadius = 12.0;
    final path = Path();

    // Top Left
    path.moveTo(0, cornerRadius);
    path.quadraticBezierTo(0, 0, cornerRadius, 0);
    path.lineTo(size.width - cornerRadius, 0);
    path.quadraticBezierTo(size.width, 0, size.width, cornerRadius);

    // Right Notch
    path.lineTo(size.width, size.height / 2 - notchRadius);
    path.arcToPoint(
      Offset(size.width, size.height / 2 + notchRadius),
      radius: const Radius.circular(notchRadius),
      clockwise: false,
    );
    path.lineTo(size.width, size.height - cornerRadius);
    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width - cornerRadius,
      size.height,
    );

    // Bottom
    path.lineTo(cornerRadius, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - cornerRadius);

    // Left Notch
    path.lineTo(0, size.height / 2 + notchRadius);
    path.arcToPoint(
      Offset(0, size.height / 2 - notchRadius),
      radius: const Radius.circular(notchRadius),
      clockwise: false,
    );

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
