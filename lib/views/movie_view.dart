import 'package:flutter/material.dart';
import 'package:toko_online/widgets/bottom_nav.dart'; // Nanti kita buat widget ini

class MovieView extends StatefulWidget {
  const MovieView({super.key});

  @override
  State<MovieView> createState() => MovieViewState();
}

class MovieViewState extends State<MovieView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: const Center(child: Text("Halaman Movie")),
      bottomNavigationBar: const BottomNav(1), // Index 1 untuk Movie
    );
  }
}