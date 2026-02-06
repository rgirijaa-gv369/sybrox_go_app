import 'package:flutter/material.dart';

class ClaimsPage extends StatelessWidget {
  const ClaimsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: _buildAppBar(context, 'Claims'),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInsuranceClaimsSection(),

                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 40),

                        // Policy Coverage Section
                        _buildPolicyCoverageSection(),

                        const SizedBox(height: 20),

                        _buildLegalSection(context),

                        const SizedBox(height: 120),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: _buildBottomButton(context),
    );
  }

  // EXACT SAME APP BAR AS SETTINGS PAGE
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

  Widget _buildInsuranceClaimsSection() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Yellow background section
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 16),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFFFBD5B), Color(0xFFFFC46B)],
            ),
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(30)),
          ),
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 60),
          child: const Text(
            'Insurance Claims',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),

        // Overlapping coverage validity card
        Positioned(
          bottom: -30,
          left: 20,
          right: 20,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Text(
              'Your insurance coverage is valid on all rides',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPolicyCoverageSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E5E5), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Policy Coverage',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 18),

          // Personal Accident Coverage
          _buildCoverageItem(
            imagePath: 'assets/images/helpand-support/compensation.png',
            title: 'Personal Accident/ Accidental death',
            amount: '₹4,00,000',
          ),

          const SizedBox(height: 16),

          // Medical Expenses Coverage
          _buildCoverageItem(
            imagePath: 'assets/images/helpand-support/accedent.png',
            title: 'Medical Expenses for Hospitalization',
            amount: '₹1,00,000',
          ),
        ],
      ),
    );
  }

  Widget _buildCoverageItem({
    required String imagePath,
    required String title,
    required String amount,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(imagePath, width: 32, height: 32, fit: BoxFit.contain),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'up to $amount',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLegalSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Legal',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 16),

        // Claim Procedure
        _buildLegalItem(
          title: 'Claim Procedure',
          onTap: () {
            _showLegalDialog(context, 'Claim Procedure');
          },
        ),

        const SizedBox(height: 14),

        // Terms and Conditions
        _buildLegalItem(
          title: 'Terms and Conditions',
          onTap: () {
            _showLegalDialog(context, 'Terms and Conditions');
          },
        ),
      ],
    );
  }

  Widget _buildLegalItem({required String title, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            const Text(
              'View',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF2196F3),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              _showClaimDialog(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFBD5B),
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
              shadowColor: Colors.transparent,
            ),
            child: const Text(
              'Claim Insurance',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }

  void _showLegalDialog(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Text(
              title == 'Claim Procedure'
                  ? 'Claim Procedure:\n\n'
                        '1. Report the incident within 24 hours\n'
                        '2. Submit required documents\n'
                        '3. Wait for verification\n'
                        '4. Receive claim amount\n\n'
                        'Required Documents:\n'
                        '• Police FIR copy (if applicable)\n'
                        '• Medical reports\n'
                        '• Identity proof\n'
                        '• Bank details'
                  : 'Terms and Conditions:\n\n'
                        '• Coverage is valid for all registered rides\n'
                        '• Maximum claim amounts apply as specified\n'
                        '• Valid for registered users only\n'
                        '• Claims must be filed within 30 days\n'
                        '• Fraudulent claims will be rejected\n'
                        '• Company reserves right to modify terms',
              style: const TextStyle(
                fontSize: 14,
                height: 1.5,
                color: Colors.black87,
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Close',
              style: TextStyle(
                color: Color(0xFF2196F3),
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showClaimDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'File a Claim',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'To file a claim, please have the following ready:',
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            _buildRequirementItem('Incident details and date'),
            _buildRequirementItem('Police report (if applicable)'),
            _buildRequirementItem('Medical reports'),
            _buildRequirementItem('Bank details for transfer'),
            const SizedBox(height: 16),
            const Text(
              'Contact support@insurance.com or call 1800-XXX-XXXX for assistance.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showComingSoon(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2196F3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Start Claim',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequirementItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 2),
            child: Icon(Icons.check_circle, size: 16, color: Color(0xFF4CAF50)),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  void _showComingSoon(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Coming Soon',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2196F3),
          ),
        ),
        content: const Text(
          'The online claim filing feature will be available soon. '
          'For now, please contact our customer support for assistance.',
          style: TextStyle(fontSize: 14, height: 1.5, color: Colors.black87),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2196F3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'OK',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
