import 'package:flutter/material.dart';
import 'package:toko_online/views/register_user_view.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => RegisterUserView(),
    },
  ));
}