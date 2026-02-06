import 'package:equatable/equatable.dart';

class RewardEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final String points;

  const RewardEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.points,
  });

  @override
  List<Object?> get props => [id, title, description, points];
}
