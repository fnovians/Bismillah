import 'package:flutter/material.dart';

class Materi {
  final String title;
  final String description;
  final String lecturer;
  final IconData icon;
  final Color color;

  const Materi({
    required this.title,
    required this.description,
    required this.lecturer,
    required this.icon,
    required this.color,
  });
}
