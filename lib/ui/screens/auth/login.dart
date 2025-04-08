import 'package:flutter/material.dart';
import 'package:rootnity_app/services/controller/auth_services.dart';
import 'package:rootnity_app/ui/screens/auth/auth_base_layout.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController email = new TextEditingController();
  final TextEditingController password = new TextEditingController();

  Map<String, dynamic>? errors; //.. Variabel mengampung error

  //.. Fungsi untuk register
  void _register() async {
    var result = await AuthServices.login(email.text, password.text, context);
  }

  @override
  Widget build(BuildContext context) {
    return AuthBaseLayout(
      title: "Login",
      backgroundImagesUri: "",
      body: [],
    );
  }
}
