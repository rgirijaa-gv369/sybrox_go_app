import 'package:flutter/material.dart';

class AppTheme {
  static const String _fontFamily = 'Poppins';

  static final lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    textTheme: ThemeData.light().textTheme.apply(fontFamily: _fontFamily),
    primaryTextTheme:
        ThemeData.light().textTheme.apply(fontFamily: _fontFamily),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.blue,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    useMaterial3: true,
    // Add more customization here
  );

  static final darkTheme = ThemeData.dark().copyWith(
    primaryColor: Colors.deepPurple,
    textTheme: ThemeData.dark().textTheme.apply(fontFamily: _fontFamily),
    primaryTextTheme:
        ThemeData.dark().textTheme.apply(fontFamily: _fontFamily),
    // Add more customization here
  );
}
