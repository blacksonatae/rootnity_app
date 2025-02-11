import 'package:flutter/material.dart';
import 'package:rootnity_app/ui/screens/auth/login.dart';

import '../../../services/auth_services.dart';
import '../../widget/custom_text_field.dart';
import '../layout.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  Map<String, dynamic>? errors;

  void _register() async {
    final result = await AuthServices().register(
      name.text,
      email.text,
      password.text,
      confirmPassword.text
    );

    if (result != null && result['status'] == false) {
      print("Terjadi kesalahan, user tidak bisa masuk ke halaman screen");
      setState(() {
        errors = result['errors'] ?? {};
      });
    }

    if (result != null && result['status'] == true) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LayoutsScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Background Images
            AspectRatio(
              aspectRatio: 1.25,
              child: Image.asset(
                'images/pexels-pixabay-247599.jpg',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 5), // dikasih jarak

            // Konten form login
            Padding(
              padding: EdgeInsets.all(30.0),
              child: Column(
                children: [
                  const Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Nama Pengguna
                  CustomTextField(
                    controller: name,
                    label: 'Nama Pengguna',
                    errorText: errors?['name']?.first,
                  ),
                  const SizedBox(height: 15),

                  // Email
                  CustomTextField(
                    controller: email,
                    label: 'Email',
                    errorText: errors?['email']?.first,
                  ),
                  const SizedBox(height: 15),
                  // Password

                  CustomTextField(
                    controller: password,
                    label: 'Password',
                    errorText: errors?['password']?.first,
                    isPassword: true,
                  ),
                  const SizedBox(height: 15),

                  // Confirm Password
                  CustomTextField(
                    controller: confirmPassword,
                    label: 'Confirm Password',
                    errorText: errors?['confirm_password']?.first,
                    isPassword: true,
                  ),

                  // Tombol Register
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        _register();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF181C14),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "Register",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    },
                    child: Text(
                      "Sudah ada akun ? login",
                      style: TextStyle(
                          color: Color(0xFF6EC207),
                          decoration: TextDecoration.none),
                    ),
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
