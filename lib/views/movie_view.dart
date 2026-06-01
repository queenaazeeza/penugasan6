import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toko_online/detail_movie_view.dart';
import 'package:toko_online/models/movie_model.dart';
import 'detail_movie_view.dart';
import 'package:toko_online/widgets/bottom_nav.dart';

class MovieView extends StatefulWidget {
  const MovieView({super.key});

  @override
  State<MovieView> createState() => MovieViewState();
}

class MovieViewState extends State<MovieView> {
  List<MovieModel>? film;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getFilm();
  }

  Future<void> getFilm() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userDataString = prefs.getString('user_data');

      if (userDataString != null) {
        final userData = jsonDecode(userDataString);
        String token = userData['token'] ?? ''; 

        final response = await http.get(
          // 2. PERBAIKAN: Melengkapkan endpoint URL sesuai dengan Postman Anda yang sukses tadi
          Uri.parse('http://192.168.1.13/user/getmovie'), 
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );

        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);
          if (responseData['status'] == true || responseData['data'] != null) {
            final List<dynamic> dataFilmMentah = responseData['data'];
            setState(() {
              film = dataFilmMentah.map((json) => MovieModel.fromJson(json)).toList();
              isLoading = false;
            });
          }
        } else {
          throw Exception("Server merespon dengan kode: ${response.statusCode}");
        }
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal memuat film: ${e.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie List"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : film == null || film!.isEmpty
              ? const Center(child: Text("Tidak ada data film."))
              : ListView.builder(
                  itemCount: film!.length,
                  itemBuilder: (context, index) {
                    final currentMovie = film![index];
                    
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailMovieView(movie: currentMovie),
                            ),
                          );
                        },
                        leading: currentMovie.posterPath.isNotEmpty
                            ? Image.network(
                                currentMovie.posterPath,
                                width: 50,
                                fit: BoxFit.cover,
                                errorBuilder: (c, e, s) => const Icon(Icons.movie, size: 50),
                              )
                            : const Icon(Icons.movie, size: 50),
                        title: Text(
                          currentMovie.title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: const Text("Klik untuk melihat detail film"),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                      ),
                    );
                  },
                ),
      bottomNavigationBar: const BottomNav(1),
    );
  }
}