import 'package:flutter/material.dart';

class AlertMessage {
  // Gunakan static agar bisa dipanggil tanpa inisialisasi ulang: AlertMessage.showAlert(...)
  static void showAlert(BuildContext context, String message, bool status) {
    Color warnafill;
    Color warnagaris;

    // Menentukan warna berdasarkan status
    if (status) {
      warnafill = Colors.green[200]!; // Tambahkan ! untuk memastikan tidak null
      warnagaris = Colors.green;
    } else {
      warnafill = Colors.pink[200]!; 
      warnagaris = Colors.red;
    }

    // Bersihkan SnackBar yang mungkin masih menggantung agar tidak bertumpuk
    ScaffoldMessenger.of(context).removeCurrentSnackBar();

    final snackBar = SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      duration: const Duration(seconds: 3), // Atur durasi tampil
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: warnafill,
          border: Border.all(color: warnagaris, width: 2),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 2.0,
              blurRadius: 8.0,
              offset: Offset(2, 4),
            ),
          ],
          borderRadius: BorderRadius.circular(8), // Sedikit lebih melengkung agar modern
        ),
        child: Row(
          children: [
            Icon(
              status ? Icons.check_circle : Icons.error, 
              color: status ? Colors.green[800] : Colors.red[800],
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.black87, 
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close, size: 18, color: Colors.black54),
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            ),
          ],
        ),
      ),
    );

    // Menampilkan SnackBar
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}