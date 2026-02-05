import 'package:flutter/material.dart';

class EditEmergencyContactSheet extends StatefulWidget {
  final String initialContact;
  final Function(String) onSave;

  const EditEmergencyContactSheet({
    super.key,
    required this.initialContact,
    required this.onSave,
  });

  @override
  State<EditEmergencyContactSheet> createState() =>
      _EditEmergencyContactSheetState();
}

class _EditEmergencyContactSheetState extends State<EditEmergencyContactSheet> {
  String? _selectedContact;
  final List<Map<String, String>> _contacts = [
    {'name': 'APPA', 'relationship': 'Father', 'phone': '+91 9876543210'},
    {'name': 'AMMA', 'relationship': 'Mother', 'phone': '+91 9876543211'},
    {'name': 'BRO', 'relationship': 'Brother', 'phone': '+91 9876543212'},
  ];

  @override
  void initState() {
    super.initState();

    _selectedContact = 'APPA';
  }

  void _saveContact(BuildContext context) {
    if (_selectedContact != null) {
      widget.onSave(_selectedContact!);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a contact'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    Navigator.pop(context);
  }

  void _addNewPerson() {
    print('Add new person tapped');
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Emergency Contact',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFC73030),
                    ),
                  ),
                  const SizedBox(height: 24),

                  Column(
                    children: [
                      ..._contacts.map((contact) {
                        final name = contact['name']!;
                        return _buildContactItem(
                          name: name,
                          isSelected: _selectedContact == name,
                          onTap: () {
                            setState(() {
                              _selectedContact = name;
                            });
                          },
                        );
                      }),

                      const SizedBox(height: 20),

                      InkWell(
                        onTap: _addNewPerson,
                        borderRadius: BorderRadius.circular(8),
                        child: Row(
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF007AFF),
                              ),
                              child: const Icon(
                                Icons.person_add_outlined,
                                size: 22,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'Add new person',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF007AFF),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Done Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () => _saveContact(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFAA2B),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                        shadowColor: Colors.transparent,
                      ),
                      child: const Text(
                        'Done',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // Close Button
        Positioned(
          top: -45,
          right: 10,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      spreadRadius: 1,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(Icons.close, size: 22, color: Colors.black87),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContactItem({
    required String name,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade300,
              ),
              child: Icon(Icons.person, size: 24, color: Colors.grey.shade600),
            ),
            const SizedBox(width: 12),

            Expanded(
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            // Radio Button
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Center(
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected ? Colors.black : Colors.transparent,
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
