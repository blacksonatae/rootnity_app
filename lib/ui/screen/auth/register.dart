import 'package:flutter/material.dart';
import 'package:rootnity_app/ui/screen/auth/auth_layout.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  Map<String, dynamic>? errors; //.. errors

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      title: "Register",
      backgroundImagesUri: "images/pexels-mdsnmdsnmdsn-1216345.jpg",
      body: [],
    );
  }
}
