import 'package:flutter/material.dart';
import 'package:rootnity_app/services/auth_services.dart';
import 'package:rootnity_app/ui/screen/auth/auth_layout.dart';
import 'package:rootnity_app/ui/screen/auth/login.dart';
import 'package:rootnity_app/ui/screen/layout/layout.dart';
import 'package:rootnity_app/ui/widget/custom_elevated_button.dart';
import 'package:rootnity_app/ui/widget/custom_text_field.dart';
import 'package:rootnity_app/core/theme_app.dart';

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

  //.. Register
  void _register() async {
    final result = await AuthServices.register(nameController.text, emailController.text, passwordController.text, confirmPasswordController.text, context);

    if (result['status'] == false) {
      setState(() {
        errors = result['errors'] ?? {};
      });
    }

    if (result['status'] == true) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const LayoutScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      title: "Register",
      backgroundImagesUri: "images/pexels-mdsnmdsnmdsn-1216345.jpg",
      body: [
        const SizedBox(height: 25),
        //.. Name
        CustomTextField(
          controller: nameController,
          label: "Name",
          errorText: errors?['name']?.first,
        ),
        const SizedBox(height: 20),
        //.. Email
        CustomTextField(
          controller: emailController,
          label: "Email",
          errorText: errors?['email']?.first,
        ),
        const SizedBox(height: 20),
        //.. Password
        CustomTextField(
          controller: passwordController,
          label: "Password",
          isPassword: true,
          errorText: errors?['password']?.first,
        ),
        const SizedBox(height: 20),
        //.. Confirm Password
        CustomTextField(
          controller: confirmPasswordController,
          label: "Confirm Password",
          isPassword: true,
          errorText: errors?['confirm_password']?.first,
        ),
        const SizedBox(height: 20),
        //.. Button Register
        CustomElevatedButton(
          nameButton: "Register",
          onPressed: () => _register(),
        ),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
          ),
          child: const Text(
            "Belum ada akun? login",
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
