import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toko_online/models/response_data_map.dart'; 
import 'package:toko_online/services/url.dart' as url; 

class UserService {
  // 1. Fungsi Register (Sudah diperbaiki agar tidak TypeError saat error API muncul)
  static Future<ResponseDataMap> registerUser(Map<String, dynamic> data) async {
    var uri = Uri.parse("${url.BaseUrl}/auth/register");
    try {
      var response = await http.post(uri, body: data);
      if (response.statusCode == 200) {
        var dataJson = json.decode(response.body);
        if (dataJson["status"] == true) {
          return ResponseDataMap(
            status: true,
            message: "Berhasil register user",
            data: dataJson,
          );
        } else {
          // JIKA BACKEND MENGIRIMKAN ERROR BERBENTUK MAP/OBJECT (Validator Laravel)
          var message = "";
          if (dataJson["message"] is Map) {
            for (String key in dataJson["message"].keys) {
              message += dataJson["message"][key][0].toString() + "\n";
            }
          } else {
            message = dataJson["message"] ?? "Gagal register";
          }

          return ResponseDataMap(
            status: false,
            message: message,
          );
        }
      } else {
        return ResponseDataMap(
          status: false,
          message: "Gagal register dengan code error ${response.statusCode}",
        );
      }
    } catch (e) {
      return ResponseDataMap(
        status: false,
        message: "Terjadi kesalahan jaringan: $e",
      );
    }
  }

  // 2. Fungsi Login 
  static Future<ResponseDataMap> login(String email, String password) async {
    var uri = Uri.parse("${url.BaseUrl}/auth/login"); 
    
    try {
      var response = await http.post(uri, body: {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        var dataJson = json.decode(response.body);

        if (dataJson["status"] == true) {
          var userData = dataJson["data"];
          
          if (dataJson["authorisation"] != null) {
            userData["token"] = dataJson["authorisation"]["token"];
          }

          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('user_data', jsonEncode(userData));

          return ResponseDataMap(
            status: true,
            message: "Login Berhasil!",
            data: dataJson,
          );
        } else {
          return ResponseDataMap(
            status: false,
            message: dataJson["message"] ?? "Email dan password salah",
          );
        }
      } else {
        return ResponseDataMap(
          status: false,
          message: "Gagal login: Error ${response.statusCode}",
        );
      }
    } catch (e) {
      return ResponseDataMap(
        status: false,
        message: "Terjadi kesalahan koneksi: $e",
      );
    }
  }
}