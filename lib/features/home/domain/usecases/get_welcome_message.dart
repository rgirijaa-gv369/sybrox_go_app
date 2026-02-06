import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/message.dart';
import '../repositories/home_repository.dart';

class GetWelcomeMessage implements UseCase<Message, NoParams> {
  final HomeRepository repository;

  GetWelcomeMessage(this.repository);

  @override
  Future<Either<Failure, Message>> call(NoParams params) async {
    return await repository.getWelcomeMessage();
  }
}
