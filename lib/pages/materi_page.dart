import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_world/models/materi.dart';

class MateriPage extends StatelessWidget {
  const MateriPage({super.key});

  // Data diubah menjadi List<Materi>
  final List<Materi> _materiList = const [
    Materi(
      title: "Pengantar Jaringan Komputer",
      description: "Dasar-dasar jaringan, topologi, dan protokol.",
      lecturer: "Azis Suroni S.Kom., M.Kom.",
      icon: Icons.wifi,
      color: Color(0xFF4A90E2),
    ),
    Materi(
      title: "Pemrograman Berbasis Platform",
      description: "Mempelajari tentang Coding",
      lecturer: "Saifudin Yahya S.Kom, M.T.I",
      icon: Icons.code,
      color: Color(0xFF50E3C2),
    ),
    Materi(
      title: "Kecerdasan Buatan",
      description: "Konsep dasar AI, machine learning, dan neural network.",
      lecturer: "Durrotun Nashihin, M.sc",
      icon: Icons.psychology,
      color: Color(0xFFF5A623),
    ),
    Materi(
      title: "Sistem Operasi",
      description: "Manajemen proses, memori, dan sistem file.",
      lecturer: "Khoirul Islam, S.Kom., M.Kom.",
      icon: Icons.memory,
      color: Color(0xFFBD10E0),
    ),
    Materi(
      title: "Basis Data",
      description: "Desain, implementasi, dan manajemen database relasional.",
      lecturer: "Bonda Sisephaputra, M. Kom",
      icon: Icons.storage,
      color: Color(0xFF7ED321),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'Materi Perkuliahan',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xFF2C3E50),
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _materiList.length,
        itemBuilder: (context, index) {
          final materi = _materiList[index];
          return _buildMateriCard(context, materi: materi);
        },
      ),
    );
  }

  Widget _buildMateriCard(BuildContext context, {required Materi materi}) {
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
              content: Text('Membuka materi: ${materi.title}...',
                  style: GoogleFonts.poppins()),
              backgroundColor: materi.color,
            ),
          );
        },
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: materi.color.withOpacity(0.15),
                child: Icon(materi.icon, size: 28, color: materi.color),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      materi.title,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      materi.description,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.person_pin_rounded, size: 14, color: Colors.grey[500]),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            materi.lecturer,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[500],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 16),
            ],
          ),
        ),
      ),
    );
  }
}
