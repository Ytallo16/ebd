import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

const Color kPrimaryDark = Color(0xFF0B4C86);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ADDIRCEU EBD',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: kPrimaryDark),
        primaryColor: kPrimaryDark,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          elevation: 2,
          backgroundColor: kPrimaryDark,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(backgroundColor: kPrimaryDark),
        ),
      ),
      home: const LoginScreen(),
    );
  }
}
