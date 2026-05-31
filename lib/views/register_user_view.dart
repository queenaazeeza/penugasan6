import 'package:flutter/material.dart';
import 'package:toko_online/services/user.dart';
import 'package:toko_online/widgets/alert.dart';

class RegisterUserView extends StatefulWidget {
  const RegisterUserView({super.key});

  @override
  State<RegisterUserView> createState() => _RegisterUserViewState();
}

class _RegisterUserViewState extends State<RegisterUserView> {
  UserService user = UserService(); 
  final formkey = GlobalKey<FormState>();

  
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  
  
  List roleChoice = ["Pembeli", "Penjual"]; 
  String? role;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar Akun Toko Online"),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                Text("Form Pendaftaran", 
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                TextFormField(
                  controller: email,
                  decoration: InputDecoration(label: Text("Email")),
                  validator: (value) => value!.isEmpty ? 'Email harus diisi' : null,
                ),
                DropdownButtonFormField(
                  hint: Text("Daftar sebagai..."),
                  value: role,
                  items: roleChoice.map((r) => DropdownMenuItem(value: r, child: Text(r))).toList(),
                  onChanged: (value) => setState(() => role = value.toString()),
                  validator: (value) => value == null ? "Role harus dipilih" : null,
                ),
                TextFormField(
                  controller: password,
                  obscureText: true,
                  decoration: InputDecoration(label: Text("Password")),
                  validator: (value) => value!.isEmpty ? 'Password harus diisi' : null,
                ),
                SizedBox(height: 20),
                MaterialButton(
                  color: Colors.blueAccent,
                  child: Text("Register", style: TextStyle(color: Colors.white)),
                  onPressed: () async {
                    if (formkey.currentState!.validate()) {
                      var data = {
                        "email": email.text,
                        "role": role,
                        "password": password.text,
                    
                      };

                      var result = await UserService.registerUser(data);
                      
                      if (result.status == true) {
                       email.clear(); password.clear();
                        setState(() { role = null; });
                        AlertMessage.showAlert(context, result.message, true);
                      } else {
                        AlertMessage.showAlert(context, result.message, false);
                      }
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}