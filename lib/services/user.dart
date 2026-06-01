import 'dart:convert';
import 'package:http/http.dart' as http;

// Class pembungkus data hasil respons login dari Postman
class LoginResult {
  final bool status;
  final String message;
  final String token;
  final Map<String, dynamic>? user;

  LoginResult({
    required this.status,
    required this.message,
    required this.token,
    this.user,
  });
}

class UserService {
  static Future<LoginResult> login(String email, String password) async {
    try {
      // URL disesuaikan dengan domain utama Postman Anda
      final response = await http.post(
        Uri.parse('https://learn.smktelkom-mlg.sch.id/api'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      final responseData = jsonDecode(response.body);

      // Jika server membalas status true (Berhasil Login)
      if (response.statusCode == 200 && responseData['status'] == true) {
        return LoginResult(
          status: true,
          message: responseData['message'] ?? 'Login Berhasil',
          token: responseData['token'] ?? '', // Mengambil teks token panjang JWT
          user: responseData['user'],
        );
      } else {
        return LoginResult(
          status: false,
          message: responseData['message'] ?? 'Email atau Password salah',
          token: '',
        );
      }
    } catch (e) {
      return LoginResult(
        status: false,
        message: 'Gagal terhubung ke server: ${e.toString()}',
        token: '',
      );
    }
  }

  static Future registerUser(Map<String, String?> data) async {}
}