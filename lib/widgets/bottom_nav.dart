import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomNav extends StatefulWidget {
  final int activePage;
  const BottomNav(this.activePage, {super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  String role = "";

  @override
  void initState() {
    super.initState();
    getRole();
  }

  // Menyesuaikan pembacaan role sesuai database login Anda
  void getRole() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userDataString = preferences.getString('user_data');
    if (userDataString != null) {
      final userData = jsonDecode(userDataString);
      setState(() {
        role = userData['role'] ?? "user";
      });
    }
  }

  void getLink(int index) {
    if (role == 'admin') {
      if (index == 0) {
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else if (index == 1) {
        Navigator.pushReplacementNamed(context, '/movie');
      }
    } else {
      // Jika role bukan admin (misal: user / kasir)
      if (index == 0) {
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else if (index == 1) {
        Navigator.pushReplacementNamed(context, '/pesan');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.green, // Disamakan dengan tema hijau dashboard Anda
      unselectedItemColor: Colors.grey,
      currentIndex: widget.activePage,
      onTap: (index) => getLink(index),
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(role == 'admin' ? Icons.movie : Icons.message),
          label: role == 'admin' ? 'Movie' : 'Pesan',
        ),
      ],
    );
  }
}