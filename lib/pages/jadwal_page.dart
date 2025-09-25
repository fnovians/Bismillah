import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_world/models/jadwal.dart';

class JadwalPage extends StatelessWidget {
  const JadwalPage({super.key});

  // Data diubah menjadi Map<String, List<Jadwal>>
  final Map<String, List<Jadwal>> _jadwalKuliah = const {
    "Senin": [
      Jadwal(
        course: "Jaringan Komputer",
        time: "08:00 - 10:30",
        room: "Gedung A, Ruang 101",
        lecturer: "Azis Suroni S.Kom., M.Kom.",
        color: Color(0xFF4A90E2),
      ),
      Jadwal(
        course: "Basis Data",
        time: "13:00 - 15:30",
        room: "Gedung C, Ruang 302",
        lecturer: "Bonda Sisepha Putra M.Kom.",
        color: Color(0xFF7ED321),
      ),
    ],
    "Selasa": [
      Jadwal(
        course: "Struktur Data & Algoritma",
        time: "10:00 - 12:30",
        room: "Gedung B, Ruang 205",
        lecturer: "Azis Suroni S.Kom., M.Kom.",
        color: Color(0xFF50E3C2),
      ),
    ],
    "Rabu": [
      Jadwal(
        course: "Kecerdasan Buatan",
        time: "09:00 - 11:30",
        room: "Gedung A, Ruang 103",
        lecturer: "Durrotun Nashihin M.sc",
        color: Color(0xFFF5A623),
      ),
      Jadwal(
        course: "Sistem Operasi",
        time: "14:00 - 16:30",
        room: "Gedung D, Ruang 401",
        lecturer: "Khoirul Islam S.kom., M.kom.",
        color: Color(0xFFBD10E0),
      ),
    ],
    "Kamis": [],
    "Jumat": [
      Jadwal(
        course: "Praktikum Jaringan Komputer",
        time: "13:30 - 16:00",
        room: "Laboratorium Jaringan",
        lecturer: "Asisten Dosen",
        color: Color(0xFF4A90E2),
      ),
    ],
  };

  @override
  Widget build(BuildContext context) {
    final days = _jadwalKuliah.keys.toList();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'Jadwal Perkuliahan',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xFF2C3E50),
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        itemCount: days.length,
        itemBuilder: (context, index) {
          final day = days[index];
          final classes = _jadwalKuliah[day]!;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 24.0, bottom: 8.0),
                  child: Text(
                    day,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
                if (classes.isEmpty)
                  _buildEmptyCard()
                else
                  ...classes.map((jadwal) {
                    return _buildJadwalCard(jadwal: jadwal);
                  }).toList(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey[500], size: 16),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: Colors.grey[700],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildJadwalCard({required Jadwal jadwal}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      elevation: 3,
      shadowColor: Colors.grey.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 10,
              decoration: BoxDecoration(
                color: jadwal.color,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      jadwal.course,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[850],
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildInfoRow(Icons.access_time_filled_rounded, jadwal.time),
                    const SizedBox(height: 6),
                    _buildInfoRow(Icons.location_on_rounded, jadwal.room),
                    const SizedBox(height: 6),
                    _buildInfoRow(Icons.person_rounded, jadwal.lecturer),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyCard() {
    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      elevation: 0,
      color: Colors.grey[200],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Text(
            'Tidak ada jadwal kuliah',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ),
      ),
    );
  }
}
