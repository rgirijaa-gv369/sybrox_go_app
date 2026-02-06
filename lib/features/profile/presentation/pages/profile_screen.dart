import 'package:flutter/material.dart';
import '../widgets/edit_name_sheet.dart';
import '../widgets/edit_email_sheet.dart';
import '../widgets/edit_gender_sheet.dart';
import '../widgets/edit_dob_sheet.dart';
import '../widgets/edit_emergency_contact_sheet.dart';
import '../widgets/delete_account_sheet.dart';
import '../widgets/logout_sheet.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Map<String, String> userProfile = {
    'name': 'Srikaran',
    'email': 'Required',
    'contact': '9876543216',
    'dob': 'Required',
    'gender': 'Male',
    'memberSince': 'October 2024',
    'emergencyContact': 'Required',
  };

  void _showLogoutSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return LogoutSheet(
          onLogout: () {
            Navigator.pop(context);
            print('User logged out');
          },
          onCancel: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }

  void _showDeleteAccountSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DeleteAccountSheet(
          onDelete: () {
            print('Account deletion requested');
          },
          onCancel: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }

  void _editName() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return EditNameSheet(
          initialName: userProfile['name']!,
          onSave: (firstName, lastName) {
            setState(() {
              final fullName = lastName.isEmpty
                  ? firstName
                  : '$firstName $lastName';
              userProfile['name'] = fullName;
            });
          },
        );
      },
    );
  }

  void _editEmail() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return EditEmailSheet(
          initialEmail: userProfile['email']!,
          onSave: (email) {
            setState(() {
              userProfile['email'] = email;
            });
          },
        );
      },
    );
  }

  void _editGender() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return EditGenderSheet(
          initialGender: userProfile['gender']!,
          onSave: (gender) {
            setState(() {
              userProfile['gender'] = gender;
            });
          },
        );
      },
    );
  }

  void _editDob() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return EditDobSheet(
          initialDob: userProfile['dob']!,
          onSave: (dob) {
            setState(() {
              userProfile['dob'] = dob;
            });
          },
        );
      },
    );
  }

  void _editEmergencyContact() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return EditEmergencyContactSheet(
          initialContact: userProfile['emergencyContact']!,
          onSave: (contact) {
            setState(() {
              userProfile['emergencyContact'] = contact;
            });
          },
        );
      },
    );
  }

  void _editContact() {
    print('Edit Contact tapped');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
                size: 18,
              ),
              onPressed: () => Navigator.pop(context),
              padding: EdgeInsets.zero,
            ),
          ),
        ),
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 24),
              child: Center(
                child: Stack(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: ClipOval(
                        child: Container(
                          color: Colors.black,
                          child: const Icon(
                            Icons.person,
                            size: 50,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: const Color(0xFF5B9BED),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          size: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            _buildProfileItem(
              icon: Icons.person_outline,
              label: 'Name',
              value: userProfile['name']!,
              valueColor: Colors.grey.shade700,
              showArrow: true,
              onTap: _editName,
            ),
            _buildDivider(),
            _buildProfileItem(
              icon: Icons.mail_outline,
              label: 'Email',
              value: userProfile['email']!,
              valueColor: const Color(0xFFE53935),
              showArrow: true,
              onTap: _editEmail,
            ),
            _buildDivider(),
            _buildProfileItem(
              icon: Icons.phone_outlined,
              label: 'Contact No',
              value: userProfile['contact']!,
              valueColor: Colors.grey.shade700,
              showArrow: true,
              onTap: _editContact,
            ),
            _buildDivider(),
            _buildProfileItem(
              icon: Icons.calendar_today_outlined,
              label: 'Date of birth',
              value: userProfile['dob']!,
              valueColor: const Color(0xFFE53935),
              showArrow: true,
              onTap: _editDob,
            ),
            _buildDivider(),
            _buildProfileItem(
              icon: Icons.wc_outlined,
              label: 'Gender',
              value: userProfile['gender']!,
              valueColor: Colors.grey.shade700,
              showArrow: true,
              onTap: _editGender,
            ),
            _buildDivider(),
            _buildProfileItem(
              icon: Icons.military_tech_outlined,
              label: 'Member since',
              value: userProfile['memberSince']!,
              valueColor: Colors.grey.shade700,
              showArrow: false,
            ),
            _buildDivider(),
            _buildProfileItem(
              icon: Icons.phone_callback_outlined,
              label: 'Emergency contact',
              value: userProfile['emergencyContact']!,
              valueColor: const Color(0xFFE53935),
              showArrow: true,
              onTap: _editEmergencyContact,
            ),

            const SizedBox(height: 24),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _showLogoutSheet,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFAA2B),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.logout_outlined, size: 22),
                          const SizedBox(width: 8),
                          const Text(
                            'Log Out',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: TextButton(
                      onPressed: _showDeleteAccountSheet,
                      style: TextButton.styleFrom(
                        foregroundColor: const Color(0xFFE53935),
                        backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.delete_outline, size: 22),
                          const SizedBox(width: 8),
                          const Text(
                            'Delete Account',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem({
    required IconData icon,
    required String label,
    required String value,
    required Color valueColor,
    required bool showArrow,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: showArrow ? onTap : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        child: Row(
          children: [
            Icon(icon, size: 28, color: Colors.grey.shade800),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 15,
                      color: valueColor,
                      fontWeight: FontWeight.w400,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            if (showArrow)
              Icon(Icons.chevron_right, color: Colors.grey.shade400, size: 26),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 1,
      color: const Color(0xFFE0E0E0),
      margin: const EdgeInsets.only(left: 60, right: 18),
    );
  }
}
