import 'package:flutter/material.dart';

class EditGenderSheet extends StatefulWidget {
  final String initialGender;
  final Function(String) onSave;

  const EditGenderSheet({
    super.key,
    required this.initialGender,
    required this.onSave,
  });

  @override
  State<EditGenderSheet> createState() => _EditGenderSheetState();
}

class _EditGenderSheetState extends State<EditGenderSheet> {
  String _selectedGender = 'Male';
  final List<String> _genderOptions = ['Male', 'Female', 'Prefer Not to Say'];

  @override
  void initState() {
    super.initState();
    _selectedGender = widget.initialGender;
  }

  void _saveGender(BuildContext context) {
    widget.onSave(_selectedGender);
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
                    'Edit Gender',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFC73030),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Gender
                  Column(
                    children: _genderOptions.map((gender) {
                      final isSelected = _selectedGender == gender;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _selectedGender = gender;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                gender,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                              Container(
                                width: 22,
                                height: 22,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 2,
                                  ),
                                ),
                                child: Center(
                                  child: Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: isSelected
                                          ? Colors.black
                                          : Colors.transparent,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 24),

                  // Save Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () => _saveGender(context),
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
