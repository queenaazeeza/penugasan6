import 'package:flutter/material.dart';
import 'package:toko_online/widgets/bottom_nav.dart';

class PesanView extends StatefulWidget {
  const PesanView({super.key});

  @override
  State<PesanView> createState() => PesanViewState();
}

class PesanViewState extends State<PesanView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pesan"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: const Center(child: Text("Halaman Pesan")),
      bottomNavigationBar: const BottomNav(2), // Index 2 untuk Pesan
    );
  }
}