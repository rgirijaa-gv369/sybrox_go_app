import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


import 'core/theme/app_theme.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'features/home/presentation/bloc/home_bloc.dart';
import 'features/auth/presentation/pages/registration_page.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/permission/presentation/pages/location_page.dart';
import 'features/auth/presentation/bloc/otp_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Go App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
    );
  }
}

final GoRouter _router = GoRouter(
  // initialLocation: '/login',
  initialLocation: '/login', // Start at Login for this flow
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => BlocProvider(
        create: (context) => RideBloc(),
        child: const HomePage(),
      ),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => BlocProvider(
        create: (context) => di.sl<OtpBloc>(),
        child: const LoginOtpPage(),
      ),
    ),
    GoRoute(
      path: '/registration',
      builder: (context, state) => const RegistrationPage(),
    ),
    GoRoute(
      path: '/permission',
      builder: (context, state) => const LocationPage(),
    ),
  ],
);
