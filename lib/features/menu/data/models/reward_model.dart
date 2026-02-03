import '../../domain/entities/reward_entity.dart';

class RewardModel extends RewardEntity {
  const RewardModel({
    required super.id,
    required super.title,
    required super.description,
    required super.points,
  });
}
