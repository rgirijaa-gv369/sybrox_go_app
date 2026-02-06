//import 'package:go_router/go_router.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/message.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_local_data_source.dart';

// class HomeRepositoryImpl implements HomeRepository {
//   final HomeLocalDataSource localDataSource;

//   HomeRepositoryImpl({required this.localDataSource});

//   @override
//   Future<Either<Failure, Message>> getWelcomeMessage() async {
//     try {
//       final localMessage = await localDataSource.getLastMessage();
//       return Right(localMessage);
//     } catch (e) {
//       return const Left(CacheFailure());
//     }
//   }
// }
