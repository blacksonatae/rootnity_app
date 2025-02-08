import 'package:flutter/material.dart';
import 'package:rootnity_app/screen/Custom/custom_text_field.dart';
import 'package:rootnity_app/services/auth_services.dart';
import 'login.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController namaPengguna = new TextEditingController();
  final TextEditingController email = new TextEditingController();
  final TextEditingController password = new TextEditingController();
  final TextEditingController confirmPassword = new TextEditingController();

  bool obscurePasswordText = true;
  bool obscureConfirmPasswordText = true;

  void _register() async {
    await AuthService().register(
      namaPengguna.text,
      email.text,
      password.text,
      confirmPassword.text,
    );
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
                      controller: namaPengguna, label: 'Nama Pengguna'),
                  const SizedBox(height: 15),
                  // Email
                  CustomTextField(
                    controller: email,
                    label: 'Email',
                  ),
                  const SizedBox(height: 15),
                  // Password
                  CustomTextField(
                    controller: password,
                    label: 'Password',
                    isPassword: true,
                  ),
                  const SizedBox(height: 15),
                  // Confirm Password
                  CustomTextField(
                    controller: confirmPassword,
                    label: 'Confirm Password',
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
