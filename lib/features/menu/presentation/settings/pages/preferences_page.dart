import 'package:flutter/material.dart';

class PreferencesPage extends StatefulWidget {
  const PreferencesPage({super.key});

  @override
  State<PreferencesPage> createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  bool _emailPromotions = false;
  bool _emailInvoice = false;
  bool _smsInvoice = false;
  bool _smsPromo = false;
  bool _whatsappUpdates = false;
  bool _mobileNotification = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: _buildAppBar(context, 'Preferences'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _buildPreferenceItem(
                  title: 'Allow emails for promotions and offers',
                  value: _emailPromotions,
                  onChanged: (value) {
                    setState(() {
                      _emailPromotions = value!;
                    });
                  },
                ),

                _buildDivider(),

                // Email for invoice
                _buildPreferenceItem(
                  title: 'Allow emails for invoice',
                  value: _emailInvoice,
                  onChanged: (value) {
                    setState(() {
                      _emailInvoice = value!;
                    });
                  },
                ),

                _buildDivider(),

                // SMS for invoice
                _buildPreferenceItem(
                  title: 'Allow SMS for invoice',
                  value: _smsInvoice,
                  onChanged: (value) {
                    setState(() {
                      _smsInvoice = value!;
                    });
                  },
                ),

                _buildDivider(),

                // Promotional SMS offer
                _buildPreferenceItem(
                  title: 'Allow promotional SMS offer',
                  value: _smsPromo,
                  onChanged: (value) {
                    setState(() {
                      _smsPromo = value!;
                    });
                  },
                ),

                _buildDivider(),

                // WhatsApp updates
                _buildPreferenceItem(
                  title: 'Allow updated to send on whatsapp',
                  value: _whatsappUpdates,
                  onChanged: (value) {
                    setState(() {
                      _whatsappUpdates = value!;
                    });
                  },
                ),

                _buildDivider(),

                // Mobile notification
                _buildPreferenceItem(
                  title: 'Allow Mobile notification',
                  value: _mobileNotification,
                  onChanged: (value) {
                    setState(() {
                      _mobileNotification = value!;
                    });
                  },
                  isLast: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Reusable AppBar for all settings pages
  PreferredSizeWidget _buildAppBar(BuildContext context, String title) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      surfaceTintColor: Colors.white,
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
      actions: const [SizedBox(width: 56)],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Divider(height: 1, thickness: 1, color: Colors.grey[300]),
    );
  }

  Widget _buildPreferenceItem({
    required String title,
    required bool value,
    required ValueChanged<bool?> onChanged,
    bool isLast = false,
  }) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            // Text
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  height: 1.4,
                ),
              ),
            ),

            const SizedBox(width: 12),

            // Checkbox
            SizedBox(
              width: 24,
              height: 24,
              child: Checkbox(
                value: value,
                onChanged: onChanged,
                activeColor: Colors.transparent,
                checkColor: Colors.black,
                side: BorderSide(color: Colors.grey[400]!, width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
