import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const GigConnectApp());
}

class GigConnectApp extends StatelessWidget {
  const GigConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gig Connect',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF1B5E20), // Dark Green
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFF1B5E20),
          secondary: const Color(0xFF4CAF50), // Lighter green accent
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1B5E20),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFF1B5E20)),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}