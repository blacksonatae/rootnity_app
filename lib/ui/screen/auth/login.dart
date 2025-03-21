import 'package:flutter/material.dart';
import 'package:rootnity_app/service/controller/auth_services.dart';
import 'package:rootnity_app/ui/layout/base_layout.dart';
import 'package:rootnity_app/ui/screen/auth/auth_layout.dart';
import 'package:rootnity_app/ui/screen/auth/register.dart';
import 'package:rootnity_app/ui/widget/custom_elevated_button.dart';
import 'package:rootnity_app/ui/widget/custom_text_field.dart';
import 'package:rootnity_app/core/theme_app.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Map<String, dynamic>? errors; //.. errors

  //.. Login
  void _login() async {
    final result = await AuthServices.login(emailController.text, passwordController.text, context);

    if (result['status'] == false) {
      setState(() {
        errors = result['errors'] ?? {};
      });
    }
    
    if (result['status'] == true) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const BaseLayout()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      title: "Login",
      backgroundImagesUri: "images/pexels-mdsnmdsnmdsn-1216345.jpg",
      body: [
        const SizedBox(height: 30),
        //.. Email
        CustomTextField(
          controller: emailController,
          label: "Email",
          errorText: errors?['email']?.first,
        ),
        const SizedBox(height: 30),
        //.. Password
        CustomTextField(
          controller: passwordController,
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
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RegisterScreen(),
            ),
          ),
          child: const Text(
            "Belum ada akun? register",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: ThemeApp.kellyGreen,
            ),
          ),
        ),
      ],
    );
  }
}
