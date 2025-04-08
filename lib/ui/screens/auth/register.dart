import 'package:flutter/material.dart';
import 'package:rootnity_app/services/controller/auth_services.dart';
import 'package:rootnity_app/ui/screens/auth/auth_base_layout.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController name = new TextEditingController();
  final TextEditingController email = new TextEditingController();
  final TextEditingController password = new TextEditingController();
  final TextEditingController confirmPassword = new TextEditingController();

  Map<String, dynamic>? errors; //.. Variabel mengampung error

  //.. Fungsi untuk register
  void _register() async {
    var result = await AuthServices.register(
        name.text, email.text, password.text, confirmPassword.text, context);
  }

  @override
  Widget build(BuildContext context) {
    return AuthBaseLayout(
      title: "Register",
      backgroundImagesUri: "",
      body: [],
    );
  }
}
