import 'package:equatable/equatable.dart';

class Ride extends Equatable {
  final String id;
  final String fromLocation;
  final String toLocation;
  final DateTime dateTime;
  final double amount;
  final bool isCompleted;

  const Ride({
    required this.id,
    required this.fromLocation,
    required this.toLocation,
    required this.dateTime,
    required this.amount,
    this.isCompleted = false,
  });

  Ride copyWith({
    String? id,
    String? fromLocation,
    String? toLocation,
    DateTime? dateTime,
    double? amount,
    bool? isCompleted,
  }) {
    return Ride(
      id: id ?? this.id,
      fromLocation: fromLocation ?? this.fromLocation,
      toLocation: toLocation ?? this.toLocation,
      dateTime: dateTime ?? this.dateTime,
      amount: amount ?? this.amount,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  String get formattedDate {
    final day = dateTime.day;
    final month = _getMonthName(dateTime.month);
    final year = dateTime.year;

    // Format time as 12:08pm
    final hour = dateTime.hour % 12;
    final hourStr = hour == 0 ? '12' : hour.toString();
    final minuteStr = dateTime.minute.toString().padLeft(2, '0');
    final period = dateTime.hour < 12 ? 'am' : 'pm';

    return '$day $month $year - $hourStr:$minuteStr$period';
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }

  @override
  List<Object> get props => [
    id,
    fromLocation,
    toLocation,
    dateTime,
    amount,
    isCompleted,
  ];
}
