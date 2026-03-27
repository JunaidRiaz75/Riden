// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:riden/splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Riden',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFF80F0F)),
      ),
      home: const SplashScreen(),
    );
  }
}
