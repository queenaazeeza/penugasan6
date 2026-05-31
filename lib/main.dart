import 'package:flutter/material.dart';
import 'package:toko_online/views/register_user_view.dart';

// Tambahkan import untuk halaman-halaman yang lain di sini
import 'package:toko_online/views/login_view.dart';
import 'package:toko_online/views/dashboard.dart';
import 'package:toko_online/views/movie_view.dart';
import 'package:toko_online/views/pesan_view.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false, // Menghilangkan banner "DEBUG" merah di pojok kanan atas HP
    initialRoute: '/', // Aplikasi pertama kali dibuka akan memunculkan halaman Register
    routes: {
      '/': (context) => const RegisterUserView(),
      '/login': (context) => const LoginView(),
      '/dashboard': (context) => const DashboardView(),
      
      // Langkah 2: Menambahkan rute baru untuk menu Bottom Navigation Bar
      '/movie': (context) => const MovieView(),
      '/pesan': (context) => const PesanView(),
    },
  ));
}