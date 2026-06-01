import 'package:flutter/material.dart';
import 'package:toko_online/models/movie_model.dart';

class DetailMovieView extends StatelessWidget {
  // Menerima kiriman data objek film dari halaman sebelumnya
  final MovieModel movie; 

  const DetailMovieView({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title), // Menampilkan judul film di AppBar
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Menampilkan Gambar Poster Besar di Bagian Atas
            Container(
              width: double.infinity,
              height: 350,
              decoration: BoxDecoration(
                color: Colors.grey[200],
              ),
              child: movie.posterPath.isNotEmpty
                  ? Image.network(
                      movie.posterPath,
                      fit: BoxFit.contain,
                      errorBuilder: (c, e, s) => const Icon(Icons.movie, size: 100, color: Colors.grey),
                    )
                  : const Icon(Icons.movie, size: 100, color: Colors.grey),
            ),
            
            // 2. Konten Detail Informasi Film
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      SizedBox(width: 5),
                      Text(
                        "8.5 / 10", // Rating dummy penyenang estetika tugas
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 10),
                  const Text(
                    "Sinopsis Film:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Ini adalah halaman detail untuk film '${movie.title}'. Film ini memiliki kualitas gambar yang jernih dan alur cerita yang sangat menarik untuk ditonton bersama keluarga.",
                    style: const TextStyle(fontSize: 15, color: Colors.black87, height: 1.4),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}