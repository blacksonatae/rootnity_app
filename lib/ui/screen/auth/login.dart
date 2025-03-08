import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rootnity_app/services/auth_services.dart';
import 'package:rootnity_app/ui/screen/auth/auth_layout.dart';
import 'package:rootnity_app/ui/screen/auth/register.dart';
import 'package:rootnity_app/ui/screen/layouts/layout.dart';
import 'package:rootnity_app/ui/widget/custom_elevated_button.dart';
import 'package:rootnity_app/ui/widget/custom_text_field.dart';
import 'package:rootnity_app/ui/widget/custom_toast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  Map<String, dynamic>? errors; // .. errors

  //.. Method login
  void _login() async {
    final result = await AuthServices().login(email.text, password.text);

    if (result != null && result['status'] == false) {
      setState(() {
        errors = result['errors'] ?? {};
      });
      if (result['errors-type'] == 'mains') {
        CustomToast.show(context,
            "Terjadi kesalahan, silahkan hubungin customer services", 'error');
      }
    }

    if (result != null && result['status'] == true) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LayoutScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      title: "Login",
      backgroundImages: "images/pexels-mdsnmdsnmdsn-1216345.jpg",
      body: [
        const SizedBox(height: 30),
        //.. Email
        CustomTextField(
          controller: email,
          label: "Email",
          errorText: errors?['email']?.first,
        ),
        const SizedBox(height: 30),
        //.. Password
        CustomTextField(
          controller: password,
          label: "Password",
          isPassword: true,
          errorText: errors?['password']?.first,
        ),
        const SizedBox(height: 30),
        //.. Button Login
        CustomElevatedButton(
          nameButton: "Login",
          onPressed: () => _login(),
        ),
        const SizedBox(height: 20),
        //.. Button untuk mengarah halaman register
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
                fontWeight: FontWeight.w400, color: Color(0xFF6EC207)),
          ),
        ),
      ],
    );
  }
}
