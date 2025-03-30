import 'package:flutter/material.dart';
import 'package:rootnity_app/services/api/auth_services.dart';
import 'package:rootnity_app/ui/layout/base_layout.dart';
import 'package:rootnity_app/ui/screen/auth/auth_layout.dart';
import 'package:rootnity_app/ui/widget/custom_elevated_button.dart';
import 'package:rootnity_app/ui/widget/custom_text_field.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false; //.. Variabel untuk menampung status loading

  Map<String, dynamic>? errors; //.. Variabel untuk menampung error

  //.. Fungsi untuk melakukan login
  void _login() async {
    setState(() {
      isLoading = true;
      errors = null;
    });

    final response = await AuthServices.login(
      emailController.text,
      passwordController.text,
    );

    setState(() {
      isLoading = false;
      if (response['status']) {
        //.. Jika login berhasil, arahkan ke halaman base layout
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BaseLayout(),
          ),
        );
      } else {
        errors = response['errors'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      title: "Login",
      backgroundImageUri: "images/pexels-mdsnmdsnmdsn-1216345.jpg",
      body: [
        const SizedBox(height: 30),
        //.. Email
        CustomTextField(
          controller: emailController,
          label: "Email",
          errorText: errors?['email']?.first,
        ),
        //.. Password
        CustomTextField(
          controller: passwordController,
          label: "Password",
          isPassword: true,
          errorText: errors?['password']?.first,
        ),
        //.. Button Login
        CustomElevatedButton(
          nameButton: "Login",
          onPressed: () => _login(),
        ),
      ],
    );
  }
}
