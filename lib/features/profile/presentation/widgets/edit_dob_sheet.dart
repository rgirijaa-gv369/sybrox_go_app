import 'package:flutter/material.dart';

class EditDobSheet extends StatefulWidget {
  final String initialDob;
  final Function(String) onSave;

  const EditDobSheet({
    super.key,
    required this.initialDob,
    required this.onSave,
  });

  @override
  State<EditDobSheet> createState() => _EditDobSheetState();
}

class _EditDobSheetState extends State<EditDobSheet> {
  DateTime _selectedDate = DateTime.now();
  late DateTime _currentMonth;
  final List<String> _weekDays = [
    'MON',
    'TUE',
    'WED',
    'THU',
    'FRI',
    'SAT',
    'SUN',
  ];
  final List<String> _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _currentMonth = DateTime(DateTime.now().year, DateTime.now().month, 1);

    if (widget.initialDob != 'Required') {
      try {
        List<String> parts = widget.initialDob.split(' ');
        if (parts.length >= 2) {
          int monthIndex = _months.indexOf(parts[0]);
          int year = int.tryParse(parts[1]) ?? DateTime.now().year;
          if (monthIndex != -1) {
            _selectedDate = DateTime(year, monthIndex + 1, 1);
            _currentMonth = DateTime(year, monthIndex + 1, 1);
          }
        }
      } catch (e) {
        print('Error parsing date: $e');
      }
    }
  }

  List<DateTime> _getDaysInMonth() {
    final firstDay = DateTime(_currentMonth.year, _currentMonth.month, 1);
    final lastDay = DateTime(_currentMonth.year, _currentMonth.month + 1, 0);

    int firstWeekday = firstDay.weekday;

    int daysBefore = firstWeekday - 1;
    if (daysBefore < 0) daysBefore = 6;

    List<DateTime> days = [];

    final previousMonth = DateTime(
      _currentMonth.year,
      _currentMonth.month - 1,
      1,
    );
    final lastDayPrevMonth = DateTime(
      _currentMonth.year,
      _currentMonth.month,
      0,
    );
    for (int i = daysBefore - 1; i >= 0; i--) {
      days.add(
        DateTime(
          previousMonth.year,
          previousMonth.month,
          lastDayPrevMonth.day - i,
        ),
      );
    }

    for (int i = 1; i <= lastDay.day; i++) {
      days.add(DateTime(_currentMonth.year, _currentMonth.month, i));
    }

    int remainingDays = 35 - days.length;
    for (int i = 1; i <= remainingDays; i++) {
      days.add(DateTime(_currentMonth.year, _currentMonth.month + 1, i));
    }

    return days;
  }

  void _previousMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1, 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 1);
    });
  }

  void _saveDob(BuildContext context) {
    final dob = '${_months[_selectedDate.month - 1]} ${_selectedDate.year}';
    widget.onSave(dob);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final monthYear =
        '${_months[_currentMonth.month - 1]} ${_currentMonth.year}';
    final days = _getDaysInMonth();

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Month
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: _previousMonth,
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        size: 18,
                        color: Colors.black,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    Text(
                      monthYear,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    IconButton(
                      onPressed: _nextMonth,
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: Colors.black,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Week Days
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: _weekDays.map((day) {
                    return Expanded(
                      child: Center(
                        child: Text(
                          day,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 12),

                // Calendar Days
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    childAspectRatio: 1,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                  ),
                  itemCount: 35,
                  itemBuilder: (context, index) {
                    final day = days[index];
                    final isCurrentMonth = day.month == _currentMonth.month;
                    final isSelected =
                        day.day == _selectedDate.day &&
                        day.month == _selectedDate.month &&
                        day.year == _selectedDate.year;

                    return InkWell(
                      onTap: isCurrentMonth
                          ? () {
                              setState(() {
                                _selectedDate = day;
                              });
                            }
                          : null,
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.grey.shade300
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            '${day.day}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: isCurrentMonth
                                  ? Colors.black
                                  : Colors.grey.shade400,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 16),

                // Done Button
                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: () => _saveDob(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFAA2B),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                      shadowColor: Colors.transparent,
                    ),
                    child: const Text(
                      'Done',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Close Button
          Positioned(
            top: -12,
            right: -12,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  print('Close button tapped');
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
                  child: const Icon(
                    Icons.close,
                    size: 22,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Helper function
void showEditDobDialog(
  BuildContext context, {
  required String initialDob,
  required Function(String) onSave,
}) {
  showDialog(
    context: context,
    builder: (context) => EditDobSheet(initialDob: initialDob, onSave: onSave),
  );
}
