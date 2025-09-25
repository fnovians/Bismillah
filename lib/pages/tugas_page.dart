import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_world/models/tugas.dart';
import 'package:intl/intl.dart';

class TugasPage extends StatelessWidget {
  // Menghapus 'const' dari constructor
  TugasPage({super.key});

  // Daftar ini tidak lagi const karena constructor Tugas juga tidak const
  final List<Tugas> _tugasList = [
    Tugas(
      title: "Analisis Algoritma Sorting",
      course: "Struktur Data & Algoritma",
      dueDate: "2024-06-20T23:59:00",
      status: "Belum Selesai",
    ),
    Tugas(
      title: "Implementasi Jaringan Sederhana",
      course: "Jaringan Komputer",
      dueDate: "2024-06-15T23:59:00",
      status: "Selesai",
    ),
    Tugas(
      title: "Rangkuman Bab 1-3 Sistem Operasi",
      course: "Sistem Operasi",
      dueDate: "2024-06-10T23:59:00",
      status: "Terlambat",
    ),
    Tugas(
      title: "Desain ERD Database E-commerce",
      course: "Basis Data",
      dueDate: "2024-06-25T23:59:00",
      status: "Belum Selesai",
    ),
    Tugas(
      title: "Studi Kasus Penerapan AI",
      course: "Kecerdasan Buatan",
      dueDate: "2024-06-22T23:59:00",
      status: "Belum Selesai",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'Daftar Tugas',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xFF2C3E50),
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _tugasList.length,
        itemBuilder: (context, index) {
          final tugas = _tugasList[index];
          return _buildTugasCard(context, tugas: tugas);
        },
      ),
    );
  }

  Widget _getStatusChip(String status) {
    Color chipColor;
    String chipLabel;

    switch (status) {
      case 'Selesai':
        chipColor = Colors.green.shade400;
        chipLabel = 'Selesai';
        break;
      case 'Terlambat':
        chipColor = Colors.red.shade400;
        chipLabel = 'Terlambat';
        break;
      case 'Belum Selesai':
      default:
        chipColor = Colors.orange.shade400;
        chipLabel = 'Belum Selesai';
        break;
    }

    return Chip(
      label: Text(
        chipLabel,
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: chipColor,
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }

  Widget _buildTugasCard(BuildContext context, {required Tugas tugas}) {
    final formattedDate = DateFormat('d MMMM yyyy, HH:mm', 'id_ID').format(tugas.dueDate);

    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 4,
      shadowColor: Colors.grey.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Melihat detail tugas: ${tugas.title}', style: GoogleFonts.poppins()),
              backgroundColor: const Color(0xFF2C3E50),
            ),
          );
        },
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      tugas.course,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue.shade700,
                      ),
                    ),
                  ),
                  _getStatusChip(tugas.status),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                tugas.title,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 12),
              const Divider(height: 1, color: Colors.black12),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.timer_outlined, color: Colors.grey[500], size: 16),
                  const SizedBox(width: 8),
                  Text(
                    'Tenggat: ',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    formattedDate,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: tugas.status == 'Terlambat' ? Colors.red.shade400 : Colors.grey[800],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
