import 'dart:async';

class UserService {
  /// Fungsi untuk menangani pendaftaran user
  /// Urutan parameter disesuaikan dengan Controller di View: (Nama, Email, Password)
  Future<bool> register(String name, String email, String password) async {
    try {
      // --- AREA SIMULASI ---
      // (Nanti di sini kamu ganti dengan logika Firebase atau API yang asli)
      
      // Kita pura-pura loading selama 2 detik
      await Future.delayed(const Duration(seconds: 2));
      
      print("Mencoba mendaftar...");
      print("Nama: $name");
      print("Email: $email");
      
      // Validasi sederhana (opsional)
      if (email.isEmpty || password.isEmpty || name.isEmpty) {
        return false;
      }
      // Anggap saja pendaftaran selalu berhasil
      return true; 
      
    } catch (e) {
      print("Terjadi error: $e");
      return false;
    }
  }
}