import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const SorcierApp());
}

class SorcierApp extends StatelessWidget {
  const SorcierApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tu es un sorcier, Harry !',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark, // ✅ cohérent
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF0C0B1D),
        fontFamily: 'Poppins',
        textTheme: const TextTheme(
          headlineMedium: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(fontSize: 18),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
