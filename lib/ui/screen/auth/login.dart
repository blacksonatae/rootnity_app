import 'package:flutter/material.dart';
import 'package:rootnity_app/services/auth_services.dart';
import 'package:rootnity_app/ui/screen/auth/register.dart';
import 'package:rootnity_app/ui/screen/home.dart';
import 'package:rootnity_app/ui/screen/layouts/layout.dart';
import 'package:rootnity_app/ui/widget/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  Map<String, dynamic>? errors;

  void _login() async {
    final result = await AuthServices().login(email.text, password.text);

    if (result != null && result['status'] == false) {
      setState(() {
        errors = result['errors'] ?? {};
      });
    }

    if (result != null && result['status'] == true) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => LayoutScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Background
            AspectRatio(
              aspectRatio: 1.25,
              child: Image.asset(
                "images/pexels-mdsnmdsnmdsn-1216345.jpg",
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  const Text(
                    "Login",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 30),
                  // Email
                  CustomTextField(
                    controller: email,
                    label: "Email",
                    errorText: errors?['email']?.first,
                  ),
                  const SizedBox(height: 30),
                  // Password
                  CustomTextField(
                    controller: password,
                    label: "Password",
                    isPassword: true,
                    errorText: errors?['password']?.first,
                  ),
                  const SizedBox(height: 30),
                  // Button Login
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                          const Color(0xFF181C14),
                        ),
                        foregroundColor:
                        WidgetStateProperty.all<Color>(Colors.white),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      onPressed: _login,
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  // Button untuk mengarah halaman register
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Belum ada akun? register",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF6EC207)),
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