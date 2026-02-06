import 'package:flutter/material.dart';

class DeleteAccountSheet extends StatefulWidget {
  final VoidCallback onDelete;
  final VoidCallback onCancel;

  const DeleteAccountSheet({
    super.key,
    required this.onDelete,
    required this.onCancel,
  });

  @override
  State<DeleteAccountSheet> createState() => _DeleteAccountSheetState();
}

class _DeleteAccountSheetState extends State<DeleteAccountSheet> {
  int? _selectedReason;
  final TextEditingController _otherReasonController = TextEditingController();
  final FocusNode _otherReasonFocusNode = FocusNode();
  final List<String> _reasons = [
    'Not Satisfied with the Service',
    'Switching to Another Service',
    'Using Your Own Vehicle',
    'The fares were too high',
    'No good offers or discounts',
    'Customer support didn\'t help me',
    'Got a new phone number',
  ];

  @override
  void dispose() {
    _otherReasonController.dispose();
    _otherReasonFocusNode.dispose();
    super.dispose();
  }

  void _deleteAccount(BuildContext context) {
    if (_selectedReason == null && _otherReasonController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a reason or specify other reason'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    widget.onDelete();
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
                    'Delete Account Reason',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFC73030),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Reason List
                  Column(
                    children: List.generate(_reasons.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _selectedReason = index;
                              _otherReasonController.clear();
                              _otherReasonFocusNode.unfocus();
                            });
                          },
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  _reasons[index],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                              // Radio button
                              Container(
                                width: 22,
                                height: 22,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: _selectedReason == index
                                        ? const Color(0xFFFF6B35)
                                        : Colors.grey.shade400,
                                    width: 2,
                                  ),
                                ),
                                child: _selectedReason == index
                                    ? Center(
                                        child: Container(
                                          width: 12,
                                          height: 12,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0xFFFF6B35),
                                          ),
                                        ),
                                      )
                                    : null,
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 0),

                  // Text Field
                  InkWell(
                    onTap: () {
                      setState(() {
                        _selectedReason = null;
                      });
                      _otherReasonFocusNode.requestFocus();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _otherReasonController,
                              focusNode: _otherReasonFocusNode,
                              maxLines: 1,
                              decoration: const InputDecoration(
                                hintText: 'Others',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                                isDense: true,
                                hintStyle: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black87,
                                fontWeight: FontWeight.w400,
                              ),
                              onTap: () {
                                setState(() {
                                  _selectedReason = null;
                                });
                              },
                              onChanged: (value) {
                                setState(() {
                                  if (value.isNotEmpty) {
                                    _selectedReason = null;
                                  }
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            width: 22,
                            height: 22,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color:
                                    _selectedReason == null &&
                                        _otherReasonController.text.isNotEmpty
                                    ? const Color(0xFFFF6B35)
                                    : Colors.grey.shade400,
                                width: 2,
                              ),
                            ),
                            child:
                                _selectedReason == null &&
                                    _otherReasonController.text.isNotEmpty
                                ? Center(
                                    child: Container(
                                      width: 12,
                                      height: 12,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xFFFF6B35),
                                      ),
                                    ),
                                  )
                                : null,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Logout Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () => _deleteAccount(context),
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
                        'Logout',
                        style: TextStyle(
                          fontSize: 20,
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
            onTap: widget.onCancel,
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
