import 'dart:io'; // 1. TAMBAHAN: Diperlukan untuk fungsi HttpOverrides bypass SSL
import 'package:flutter/material.dart';
import 'package:toko_online/views/register_user_view.dart';
import 'package:toko_online/views/login_view.dart';
import 'package:toko_online/views/dashboard.dart';
import 'package:toko_online/views/movie_view.dart';
import 'package:toko_online/views/pesan_view.dart';

// 2. TAMBAHAN: Kelas khusus untuk membuka blokir sertifikat SSL sekolah yang bermasalah
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  // 3. TAMBAHAN: Mengaktifkan bypass pengamanan SSL tepat sebelum aplikasi dijalankan
  HttpOverrides.global = MyHttpOverrides();

  runApp(MaterialApp(
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