import 'package:flutter/material.dart';

class Tugas {
  final String title;
  final String course;
  final DateTime dueDate;
  final String status;

  // Konstruktor diubah untuk menerima String dan melakukan parsing
  Tugas({
    required this.title,
    required this.course,
    required String dueDate, // Menerima String
    required this.status,
  }) : dueDate = DateTime.parse(dueDate); // Mengonversi String ke DateTime
}
