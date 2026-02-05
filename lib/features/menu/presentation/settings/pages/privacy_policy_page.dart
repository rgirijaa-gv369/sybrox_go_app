import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: _buildAppBar(context, 'Privacy Policy'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _getPrivacyContent(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getPrivacyContent() {
    return '''
Your privacy is important to us. This privacy policy explains what personal data we collect from you and how we use it.

1. Information We Collect
We collect information you provide directly to us when you use our application. This may include:
- Personal identification information (name, email address, phone number)
- Device information
- Usage data

2. How We Use Your Information
We use the information we collect to:
- Provide, maintain, and improve our services
- Send you technical notices, updates, security alerts, and support messages
- Respond to your comments, questions, and requests
- Monitor and analyze trends, usage, and activities in connection with our services

3. Information Sharing
We do not sell, trade, or rent your personal identification information to others. We may share generic aggregated demographic information not linked to any personal identification information regarding visitors and users with our business partners.

4. Data Security
We implement appropriate data collection, storage and processing practices and security measures to protect against unauthorized access, alteration, disclosure or destruction of your personal information.

5. Data Retention
We will retain your personal information only for as long as is necessary for the purposes set out in this Privacy Policy. We will retain and use your information to the extent necessary to comply with our legal obligations.

6. Your Rights
You have the right to:
- Access your personal data
- Correct inaccurate personal data
- Request deletion of your personal data
- Object to processing of your personal data
- Request restriction of processing your personal data
- Request transfer of your personal data

7. Changes to This Privacy Policy
We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page and updating the "last updated" date.

8. Contact Us
If you have any questions about this Privacy Policy, please contact us at privacy@example.com.
''';
  }

  // Reusable AppBar for all settings pages
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
      actions: const [SizedBox(width: 56)],
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
      ),
    );
  }
}
