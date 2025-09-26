// Dibuat oleh Farid Novian

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hello_world/pages/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<Offset> _sloganSlideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    // ✅ Animasi khusus slogan
    _sloganSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutExpo),
    );

    _controller.forward();

    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // ✅ Gradient Background
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF3E2AD1), // ungu tua
              Color(0xFF5B86E5), // biru elegan
            ],
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo
                      Image.asset(
                        "assets/images/logo.png",
                        height: 120,
                      ),
                      const SizedBox(height: 20),

                      // Teks utama
                      SlideTransition(
                        position: _slideAnimation,
                        child: const Text(
                          "Pusat Pembelajaran Terpadu",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Poppins",
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      SlideTransition(
                        position: _slideAnimation,
                        child: const Text(
                          "Kampus UNESA 5",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Poppins",
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // ✅ Slogan dengan animasi slide
                      SlideTransition(
                        position: _sloganSlideAnimation,
                        child: const Text(
                          "Satu Langkah Didepan!",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),
                      const CircularProgressIndicator(color: Colors.white),
                    ],
                  ),
                ),
              ),
            ),
            // ✅ Teks nama pembuat di bagian bawah
            Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: const Text(
                  "Dibuat oleh Farid Novian",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
