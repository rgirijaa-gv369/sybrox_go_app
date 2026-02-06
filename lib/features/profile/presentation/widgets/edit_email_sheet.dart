import 'package:flutter/material.dart';

class EditEmailSheet extends StatefulWidget {
  final String initialEmail;
  final Function(String) onSave;

  const EditEmailSheet({
    super.key,
    required this.initialEmail,
    required this.onSave,
  });

  @override
  State<EditEmailSheet> createState() => _EditEmailSheetState();
}

class _EditEmailSheetState extends State<EditEmailSheet> {
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(
      text: widget.initialEmail == 'Required' ? '' : widget.initialEmail,
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _saveEmail(BuildContext context) {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email is required'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid email address'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    widget.onSave(email);
    Navigator.pop(context);
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
                    'Edit E-Mail',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFC73030),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Email Field
                  TextField(
                    controller: _emailController,
                    autofocus: true,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.mail_outline,
                        color: Colors.grey.shade600,
                        size: 22,
                      ),
                      hintText: 'Example@gmail.com',
                      hintStyle: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.grey.shade700,
                          width: 1.5,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.grey.shade700,
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color(0xFFFF6B35),
                          width: 1.5,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    onSubmitted: (_) => _saveEmail(context),
                  ),

                  const SizedBox(height: 24),

                  // Save Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () => _saveEmail(context),
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
                        'Save',
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
          top: -40,
          right: 10,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 8,
                    spreadRadius: 1,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(Icons.close, size: 20, color: Colors.black87),
            ),
          ),
        ),
      ],
    );
  }
}
