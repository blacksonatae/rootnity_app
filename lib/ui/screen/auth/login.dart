import 'package:flutter/material.dart';
import 'package:rootnity_app/ui/screen/auth/auth_layout.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Map<String, dynamic>? errors; //.. errors

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      title: "Login",
      backgroundImagesUri: "images/pexels-mdsnmdsnmdsn-1216345.jpg",
      body: [],
    );
  }
}
