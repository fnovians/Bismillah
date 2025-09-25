import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_world/models/pengumuman.dart'; // Import model
import 'login_page.dart';
import 'profil_page.dart';
import 'materi_page.dart';
import 'tugas_page.dart';
import 'pengaturan_page.dart';
import 'notifikasi_page.dart';
import 'bantuan_page.dart';
import 'jadwal_page.dart';
import 'nilai_page.dart';

class HomeDashboard extends StatefulWidget {
  final String name;

  const HomeDashboard({super.key, required this.name});

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  late String greeting;
  String currentTime = "";
  late String dailyQuote;

  // === State untuk Slider Pengumuman ===
  late PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;

  final List<Pengumuman> _announcements = [
    Pengumuman(
      title: "Jadwal Ujian Akhir Semester",
      content: "UAS akan dilaksanakan mulai tanggal 15 Juli 2024. Harap periksa jadwal lengkap di SIAKAD.",
      date: "1 Juli 2024",
      color: Colors.orange.shade300,
    ),
    Pengumuman(
      title: "Perawatan Sistem E-Learning",
      content: "Akan ada maintenance pada hari Sabtu, 6 Juli 2024 pukul 00:00 - 03:00 WIB.",
      date: "30 Juni 2024",
      color: Colors.blue.shade300,
    ),
    Pengumuman(
      title: "Lomba Desain Grafis Nasional",
      content: "Pendaftaran dibuka hingga 10 Juli 2024. Tunjukkan kreativitasmu dan menangkan hadiah jutaan rupiah!",
      date: "28 Juni 2024",
      color: Colors.purple.shade300,
    ),
  ];
  // =====================================

  final List<String> quotes = [
    "“Belajar hari ini adalah investasi untuk masa depanmu.”",
    "“Kegagalan adalah bagian dari proses menuju sukses.”",
    "“Jangan berhenti sebelum kamu bangga.”",
    "“Ilmu adalah kunci yang membuka pintu masa depan.”",
    "“Setiap hari adalah kesempatan baru untuk belajar.”",
  ];

  @override
  void initState() {
    super.initState();
    _setGreeting();
    _startClock();
    dailyQuote = quotes[Random().nextInt(quotes.length)];

    // === Inisialisasi Slider ===
    _pageController = PageController(initialPage: 0);
    _startSliderTimer();
    // ==========================
  }

  @override
  void dispose() {
    // === Hentikan Timer & Dispose Controller ===
    _timer?.cancel();
    _pageController.dispose();
    // =========================================
    super.dispose();
  }

  void _startSliderTimer() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_currentPage < _announcements.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _setGreeting() {
    int hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) {
      greeting = "Selamat Pagi";
    } else if (hour >= 12 && hour < 15) {
      greeting = "Selamat Siang";
    } else if (hour >= 15 && hour < 18) {
      greeting = "Selamat Sore";
    } else {
      greeting = "Selamat Malam";
    }
  }

  void _startClock() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          currentTime =
          "${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}:${DateTime.now().second.toString().padLeft(2, '0')}";
        });
      }
    });
  }

  // === Widget untuk Slider Pengumuman ===
  Widget _buildAnnouncementSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Pengumuman",
          style: GoogleFonts.poppins(
              fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 150,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _announcements.length,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemBuilder: (context, index) {
              final announcement = _announcements[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF112240).withOpacity(0.9),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: announcement.color.withOpacity(0.5)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      announcement.title,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: announcement.color,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Text(
                        announcement.content,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        announcement.date,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.white54,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_announcements.length, (index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 8,
              width: _currentPage == index ? 24 : 8,
              decoration: BoxDecoration(
                color: _currentPage == index ? Colors.cyanAccent : Colors.grey.shade700,
                borderRadius: BorderRadius.circular(12),
              ),
            );
          }),
        ),
      ],
    );
  }
  // =====================================

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = screenWidth < 600 ? 2 : 4;
    double childAspectRatio = screenWidth < 600 ? 1.2 : 1.1;

    final List<Map<String, dynamic>> menus = [
      {"icon": Icons.person_outline, "title": "Profil", "color": const Color(0xFF4A90E2), "page": const ProfilPage()},
      {"icon": Icons.book_outlined, "title": "Materi", "color": const Color(0xFF50E3C2), "page": const MateriPage()},
      {"icon": Icons.assignment_outlined, "title": "Tugas", "color": const Color(0xFFF5A623), "page": TugasPage()},
      {"icon": Icons.calendar_today_outlined, "title": "Jadwal", "color": const Color(0xFFBD10E0), "page": const JadwalPage()},
      {"icon": Icons.school_outlined, "title": "Nilai", "color": const Color(0xFF7ED321), "page": const NilaiPage()},
      {"icon": Icons.notifications_outlined, "title": "Notifikasi", "color": const Color(0xFFD0021B), "page": const NotifikasiPage()},
      {"icon": Icons.settings_outlined, "title": "Pengaturan", "color": const Color(0xFF8B572A), "page": const PengaturanPage()},
      {"icon": Icons.help_outline, "title": "Bantuan", "color": const Color(0xFF417505), "page": const BantuanPage()},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF0A192F), // Latar belakang biru gelap
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A192F).withOpacity(0.8),
        elevation: 0,
        title: Row(
          children: [
            const Icon(Icons.school_rounded, color: Colors.cyanAccent),
            const SizedBox(width: 10),
            Text(
              "e-Learning PSDKU UNESA Magetan  ",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
            icon: const Icon(Icons.exit_to_app, color: Colors.white),
            tooltip: "Logout",
          ),
        ],
      ),
      body: Stack(
        children: [
          // Latar Belakang Animasi Gelombang
          const WavyBackground(),
          // Konten Utama
          ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Header Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF112240).withOpacity(0.85),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.blue.withOpacity(0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white.withOpacity(0.9),
                          child: Icon(Icons.person, size: 35, color: const Color(0xFF0A192F)),
                        ),
                        const SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              greeting,
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              widget.name,
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(Icons.access_time, color: Colors.cyanAccent, size: 16),
                        const SizedBox(width: 5),
                        Text(
                          currentTime,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Quote Card
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF112240).withOpacity(0.85),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.blue.withOpacity(0.2)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.format_quote, color: Colors.cyanAccent, size: 28),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        dailyQuote,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.white70,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // === Tambahkan Slider Pengumuman di sini ===
              _buildAnnouncementSlider(),
              const SizedBox(height: 24),
              // ==========================================

              // Menu Grid
              Text(
                "Menu Utama",
                style: GoogleFonts.poppins(
                    fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
              ),
              const SizedBox(height: 16),

              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: menus.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: childAspectRatio,
                ),
                itemBuilder: (context, index) {
                  final menu = menus[index];
                  return MenuCard(
                    icon: menu["icon"] as IconData,
                    title: menu["title"] as String,
                    color: menu["color"] as Color,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => menu["page"] as Widget),
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 30),

              // Footer
              Center(
                child: Column(
                  children: [
                    Text(
                      "© 2025 UNESA Kampus 5 Magetan",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.white54,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Dibuat Oleh Mahasiswa Farid Novian",
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: Colors.white38,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MenuCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;

  const MenuCard({
    super.key,
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap,
  });

  @override
  State<MenuCard> createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isTapped = true),
      onTapUp: (_) => setState(() => _isTapped = false),
      onTapCancel: () => setState(() => _isTapped = false),
      onTap: () async {
        setState(() => _isTapped = true);
        await Future.delayed(const Duration(milliseconds: 150));
        widget.onTap();
        setState(() => _isTapped = false);
      },
      child: AnimatedScale(
        scale: _isTapped ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 150),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF112240).withOpacity(0.9),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.blue.withOpacity(0.3)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: widget.color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(widget.icon, size: 32, color: widget.color),
              ),
              const SizedBox(height: 12),
              Text(
                widget.title,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- Wavy Background Animation ---

class WavyBackground extends StatefulWidget {
  const WavyBackground({super.key});

  @override
  State<WavyBackground> createState() => _WavyBackgroundState();
}

class _WavyBackgroundState extends State<WavyBackground> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: WavePainter(_controller.value),
          child: Container(),
        );
      },
    );
  }
}

class WavePainter extends CustomPainter {
  final double animationValue;

  WavePainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    // Wave 1
    _drawWave(
      canvas,
      size,
      color: Colors.cyan.withOpacity(0.3),
      amplitude: 50,
      frequency: 0.8,
      phaseShift: animationValue * 2 * pi,
      yOffset: size.height * 0.4,
    );

    // Wave 2
    _drawWave(
      canvas,
      size,
      color: Colors.purple.withOpacity(0.25),
      amplitude: 60,
      frequency: 0.6,
      phaseShift: -animationValue * 2 * pi + 1,
      yOffset: size.height * 0.5,
    );

    // Wave 3
    _drawWave(
      canvas,
      size,
      color: Colors.blue.withOpacity(0.4),
      amplitude: 40,
      frequency: 1.2,
      phaseShift: animationValue * 2 * pi + 2,
      yOffset: size.height * 0.6,
    );
  }

  void _drawWave(
    Canvas canvas,
    Size size,
    {
      required Color color,
      required double amplitude,
      required double frequency,
      required double phaseShift,
      required double yOffset,
    }
  ) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, yOffset);

    for (double x = 0; x <= size.width; x++) {
      final y = yOffset + sin(x * frequency / 100 + phaseShift) * amplitude;
      path.lineTo(x, y);
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
