import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app.dart';
import 'features/auth/data/repositories/otp_repository.dart';
import 'features/auth/presentation/bloc/otp_bloc.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        colorScheme: .fromSeed(seedColor: Colors.indigo),
      ),
      home: BlocProvider(
        create: (_) => OtpBloc(OtpRepository()),
        child: const LoginOtpPage(),
      ),
    );
  }
}
