import 'package:flutter/material.dart';

class Jadwal {
  final String course;
  final String time;
  final String room;
  final String lecturer;
  final Color color;

  const Jadwal({
    required this.course,
    required this.time,
    required this.room,
    required this.lecturer,
    required this.color,
  });
}
