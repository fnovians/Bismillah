import 'package:flutter/material.dart';
import 'package:hello_world/pages/login_page.dart';
import 'package:hello_world/pages/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Learning PSDKU Unesa Magetanx`',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //  Halaman pertama splash screen
      home: const SplashScreen(),
    );
  }
}