import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _jurusan;

  final List<String> _jurusanList = ["Informatika", "Sistem Informasi"];

  void _register() {
    String name = _nameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    // Cek validasi kosong
    if (name.isEmpty || email.isEmpty || password.isEmpty || _jurusan == null) {
      _showPopup(
        "PERINGATAN! ️",
        "Semua form wajib diisi, termasuk jurusan!",
        false,
      );
      return;
    }

    // Validasi email sederhana
    if (!email.contains("@") || !email.contains(".")) {
      _showPopup(
        "Email Tidak Valid ❌",
        "Masukkan email dengan format yang benar!",
        false,
      );
      return;
    }

    // Jika semua valid → sukses
    _showPopup(
      "Sukses ✅",
      "Akun berhasil dibuat untuk $name di jurusan $_jurusan",
      true,
    );
  }

  void _showPopup(String title, String message, bool success) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Row(
          children: [
            Icon(
              success ? Icons.check_circle : Icons.warning_amber_rounded,
              color: success ? Colors.green : Colors.red,
            ),
            const SizedBox(width: 8),
            Text(title, style: GoogleFonts.poppins()),
          ],
        ),
        content: Text(message, style: GoogleFonts.poppins(fontSize: 14)),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Tutup popup
              if (success) Navigator.pop(context); // Kembali ke Login
            },
            child: Text(
              success ? "Oke" : "Coba Lagi",
              style: GoogleFonts.poppins(color: success ? Colors.green : Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register Akun"),
        backgroundColor: const Color(0xFF6A11CB),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Nama Lengkap",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Dropdown jurusan
            DropdownButtonFormField<String>(
              value: _jurusan,
              items: _jurusanList
                  .map((jurusan) => DropdownMenuItem(
                value: jurusan,
                child: Text(jurusan),
              ))
                  .toList(),
              onChanged: (value) => setState(() => _jurusan = value),
              decoration: const InputDecoration(
                labelText: "Pilih Jurusan",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: _register,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6A11CB),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: Text("Daftar", style: GoogleFonts.poppins(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
