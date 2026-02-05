// lib/features/menu/presentation/widgets/menu_drawer.dart
import 'package:flutter/material.dart';

// Import the ProfileScreen
// Import the ProfileScreen
import '../../../profile/presentation/pages/profile_screen.dart';
import '../my_rides/pages/my_rides_page.dart';
import '../saved_location/saved_location_page.dart';
import '../rewards/pages/rewards_page.dart';
import '../payment/pages/payment_page.dart';
import '../refer_and_earn/pages/refer_and_earn_page.dart';
import '../rewards/pages/coin_page.dart';
import '../settings/pages/settings_page.dart';
import '../help_and_support/pages/help_support_page.dart';
import '../help_and_support/pages/claims_page.dart';
import '../../../ride/presentation/pages/pickup_drop_page.dart';

class MenuDrawer extends StatelessWidget {
  final String? gender;
  final String? userName;
  final String? phoneNumber;
  final double? rating;

  const MenuDrawer({
    super.key,
    this.gender,
    this.userName,
    this.phoneNumber,
    this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.75,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(60),
          bottomRight: Radius.circular(60),
        ),
      ),
      child: Column(
        children: [
          _buildHeaderSection(context),
          _buildRatingSection(),
          Expanded(child: _buildMenuItems(context)),
        ],
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 48, 16, 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFFFAA2B), Color(0xFFFFC46B)],
          stops: [0.0, 1.0],
        ),
        borderRadius: BorderRadius.only(topRight: Radius.circular(30)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Close Button
              GestureDetector(
                onTap: () => Navigator.pop(context),
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
                  child: const Icon(Icons.close, color: Colors.black, size: 22),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Profile Section
          Row(
            children: [
              Stack(
                children: [
                  Container(
                    width: 68,
                    height: 68,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2.5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ClipOval(child: _buildProfileImage()),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context); // Close drawer
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfileScreen(),
                          ),
                        );
                      },
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.edit,
                          size: 13,
                          color: Color(0xFF4A90E2),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName ?? 'Sri Karan',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      phoneNumber ?? '+91-9876543216',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black.withOpacity(0.75),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRatingSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Color(0xFFE0E0E0), width: 1.0),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.star, size: 24, color: Color(0xFFFFAA2B)),
          const SizedBox(width: 8),
          Text(
            '${rating?.toStringAsFixed(0) ?? "5"}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 16),
          const Text(
            'My Ratings',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileImage() {
    if (gender != null) {
      String imagePath = gender?.toLowerCase() == 'female'
          ? 'assets/images/profile_female.png'
          : 'assets/images/profile_male.png';

      return Image.asset(
        imagePath,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: const Color(0xFF2C2C2C),
            child: const Icon(Icons.person, size: 36, color: Colors.white),
          );
        },
      );
    }

    return Container(
      color: const Color(0xFF2C2C2C),
      child: const Icon(Icons.person, size: 36, color: Colors.white),
    );
  }

  Widget _buildMenuItems(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: ListView(
        padding: const EdgeInsets.only(top: 8, bottom: 20),
        children: [
          _buildMenuItem(
            iconPath: 'assets/images/Menus/my_rides_icon.png',
            fallbackIcon: Icons.directions_bike,
            title: 'My Rides',
            iconBgColor: const Color(0xFFE8EAFC),
            iconColor: const Color(0xFF5B67CA),
            context: context,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyRidesPage()),
              );
            },
          ),
          _buildMenuItem(
            iconPath: 'assets/images/Menus/saved_location_icon.png',
            fallbackIcon: Icons.location_on,
            title: 'Saved Location',
            iconBgColor: const Color(0xFFFDE8E8),
            iconColor: const Color(0xFFE85C5C),
            context: context,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SavedLocationPage(),
                ),
              );
            },
          ),
          _buildMenuItem(
            iconPath: 'assets/images/Menus/rewards_icon.png',
            fallbackIcon: Icons.card_giftcard,
            title: 'Rewards',
            iconBgColor: const Color(0xFFFFF4E0),
            iconColor: const Color(0xFFFFA726),
            context: context,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RewardsPage()),
              );
            },
          ),
          _buildMenuItem(
            iconPath: 'assets/images/Menus/payment_icon.png',
            fallbackIcon: Icons.payment,
            title: 'Payment',
            iconBgColor: const Color(0xFFE0F7FA),
            iconColor: const Color(0xFF00BCD4),
            context: context,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PaymentPage()),
              );
            },
          ),
          _buildMenuItem(
            iconPath: 'assets/images/Menus/refer_earn_icon.png',
            fallbackIcon: Icons.people,
            title: 'Refer and Earn',
            iconBgColor: const Color(0xFFE8F4FC),
            iconColor: const Color(0xFF2196F3),
            context: context,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ReferAndEarnPage(),
                ),
              );
            },
          ),
          _buildMenuItem(
            iconPath: 'assets/images/Menus/coins_icon.png',
            fallbackIcon: Icons.monetization_on,
            title: 'Coins',
            iconBgColor: const Color(0xFFFFF9E6),
            iconColor: const Color(0xFFFFB300),
            context: context,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CoinPage()),
              );
            },
          ),
          _buildMenuItem(
            iconPath: 'assets/images/Menus/settings_icon.png',
            fallbackIcon: Icons.settings,
            title: 'Settings',
            iconBgColor: const Color(0xFFE8F8F0),
            iconColor: const Color(0xFF4CAF50),
            context: context,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
          ),
          _buildMenuItem(
            iconPath: 'assets/images/Menus/help_support_icon.png',
            fallbackIcon: Icons.headset_mic,
            title: 'Help & support',
            iconBgColor: const Color(0xFFFFF4E0),
            iconColor: const Color(0xFFFF9800),
            context: context,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HelpSupportPage(),
                ),
              );
            },
          ),
          _buildMenuItem(
            iconPath: 'assets/images/Menus/claims_icon.png',
            fallbackIcon: Icons.favorite,
            title: 'Claims',
            iconBgColor: const Color(0xFFFCE8F0),
            iconColor: const Color(0xFFE91E63),
            context: context,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ClaimsPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required String iconPath,
    required IconData fallbackIcon,
    required String title,
    required Color iconBgColor,
    required Color iconColor,
    required BuildContext context,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        if (onTap != null) {
          onTap();
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: iconColor.withOpacity(0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Image.asset(
                  iconPath,
                  width: 24,
                  height: 24,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(fallbackIcon, size: 24, color: iconColor);
                  },
                ),
              ),
            ),

            const SizedBox(width: 18),

            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
