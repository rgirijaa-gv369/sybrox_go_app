import 'package:get_it/get_it.dart';

import 'features/home/presentation/bloc/home_bloc.dart';
import 'features/auth/presentation/bloc/registration_bloc.dart';
import 'features/auth/presentation/bloc/otp_bloc.dart';
import 'features/auth/data/repositories/otp_repository.dart';
import 'features/auth/data/repositories/otp_repository_impl.dart';
import 'features/permission/presentation/bloc/location_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features - Home
  // Bloc
  // sl.registerFactory(() => HomeBloc(getWelcomeMessage: sl()));

  // Features - Auth
  sl.registerFactory(() => RegistrationBloc());
  sl.registerFactory(() => OtpBloc(sl())); // Register OtpBloc with dependency

  // Features - Permission
  sl.registerFactory(() => LocationBloc());

  // Use cases
  // Use cases
  // sl.registerLazySingleton(() => GetWelcomeMessage(sl()));

  // Repository
  // sl.registerLazySingleton<HomeRepository>(
  //       () => HomeRepositoryImpl(localDataSource: sl()),
  // );
  sl.registerLazySingleton<OtpRepository>(() => OtpRepositoryImpl());

  // Data sources
  // sl.registerLazySingleton<HomeLocalDataSource>(
  //       () => HomeLocalDataSourceImpl(),
  // );

  // Core
  // External
}
