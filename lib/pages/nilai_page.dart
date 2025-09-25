import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_world/models/nilai.dart';

class NilaiPage extends StatelessWidget {
  const NilaiPage({super.key});

  // Data diubah menjadi List<Nilai>
  final List<Nilai> _nilaiList = const [
    Nilai(
      course: "Jaringan Komputer",
      finalGrade: "A",
      scores: {"Tugas": 90, "UTS": 85, "UAS": 88},
    ),
    Nilai(
      course: "Struktur Data & Algoritma",
      finalGrade: "A-",
      scores: {"Tugas": 88, "UTS": 82, "UAS": 85},
    ),
    Nilai(
      course: "Kecerdasan Buatan",
      finalGrade: "B+",
      scores: {"Tugas": 85, "UTS": 78, "UAS": 80},
    ),
    Nilai(
      course: "Sistem Operasi",
      finalGrade: "B",
      scores: {"Tugas": 80, "UTS": 75, "UAS": 78},
    ),
    Nilai(
      course: "Basis Data",
      finalGrade: "A",
      scores: {"Tugas": 92, "UTS": 88, "UAS": 90},
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'Transkrip Nilai',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xFF2C3E50),
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _nilaiList.length,
        itemBuilder: (context, index) {
          final nilai = _nilaiList[index];
          return _buildNilaiCard(nilai: nilai);
        },
      ),
    );
  }

  Widget _getGradePill(String grade) {
    Color pillColor;
    switch (grade) {
      case 'A':
      case 'A-':
        pillColor = Colors.green.shade400;
        break;
      case 'B+':
      case 'B':
        pillColor = Colors.blue.shade400;
        break;
      case 'C+':
      case 'C':
        pillColor = Colors.orange.shade400;
        break;
      default:
        pillColor = Colors.red.shade400;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: pillColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        grade,
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildScoreRow(String component, int score) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            component,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          Text(
            score.toString(),
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNilaiCard({required Nilai nilai}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 2,
      shadowColor: Colors.grey.withOpacity(0.15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
        title: Text(
          nilai.course,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
          ),
        ),
        trailing: _getGradePill(nilai.finalGrade),
        children: [
          const Divider(height: 1, indent: 16, endIndent: 16),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rincian Skor:',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 8),
                ...nilai.scores.entries.map((entry) {
                  return _buildScoreRow(entry.key, entry.value);
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
