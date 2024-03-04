import 'package:flutter/material.dart';
import 'package:memorise/features/home/home.dart';

void main() {
  runApp(const MemoRise());
}

class MemoRise extends StatelessWidget {
  const MemoRise({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const primaryColor = Color.fromARGB(255, 183, 58, 58);
    return MaterialApp(
      title: 'MemoRise',
      theme: ThemeData(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: const Color(0xFFEFF1F3),
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
