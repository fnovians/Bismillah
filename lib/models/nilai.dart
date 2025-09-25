import 'package:flutter/material.dart';

class Nilai {
  final String course;
  final String finalGrade;
  final Map<String, int> scores;

  const Nilai({
    required this.course,
    required this.finalGrade,
    required this.scores,
  });
}
