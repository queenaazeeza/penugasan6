class UserLogin {
  int? id;
  String? name;
  String? email;
  String? token;
  String? role; // Tambahan jika API mengembalikan data role

  UserLogin({this.id, this.name, this.email, this.token, this.role});

  factory UserLogin.fromJson(Map<String, dynamic> json) {
    return UserLogin(
      id: json['id'],
      name: json['name'] ?? json['nama_user'], // Fleksibel membaca field dari API
      email: json['email'],
      token: json['token'],
      role: json['role'], // Tambahan pembacaan role
    );
  }

  // Mengubah object menjadi Map agar bisa disimpan sebagai JSON String
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'token': token,
      'role': role,
    };
  }
}