import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/message.dart';

abstract class HomeRepository {
  Future<Either<Failure, Message>> getWelcomeMessage();
}
