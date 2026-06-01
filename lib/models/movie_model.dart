class MovieModel {
  final int id;
  final String title;
  final String posterPath;

  MovieModel({required this.id, required this.title, required this.posterPath});

  // Fungsi untuk mengubah data JSON mentah dari Postman menjadi objek Flutter
  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      posterPath: json['poster_path'] ?? '', 
    );
  }
}