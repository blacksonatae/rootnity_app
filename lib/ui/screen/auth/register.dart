import 'package:flutter/material.dart';
import 'package:rootnity_app/services/auth_services.dart';
import 'package:rootnity_app/ui/screen/auth/auth_layout.dart';
import 'package:rootnity_app/ui/screen/auth/login.dart';
import 'package:rootnity_app/ui/screen/layouts/layout.dart';
import 'package:rootnity_app/ui/widget/custom_elevated_button.dart';
import 'package:rootnity_app/ui/widget/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  Map<String, dynamic>? errors; //.. errors

  //.. Method Register
  void _register() async {
    final result = await AuthServices
        .register(name.text, email.text, password.text, confirmPassword.text, context);

    if (result['status'] == false) {
      setState(() {
        errors = result['errors'] ?? {};
      });
    }

    if (result['status'] == true) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LayoutScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      title: "Register",
      backgroundImages: "images/pexels-mdsnmdsnmdsn-1216345.jpg",
      body: [
        const SizedBox(height: 25),
        //.. Name
        CustomTextField(
          controller: name,
          label: "Name",
          errorText: errors?['name']?.first,
        ),
        const SizedBox(height: 20),
        //.. Email
        CustomTextField(
          controller: email,
          label: "Email",
          errorText: errors?['email'].first,
        ),
        const SizedBox(height: 20),
        //.. Password
        CustomTextField(
          controller: password,
          label: "Password",
          errorText: errors?['password']?.first,
        ),
        const SizedBox(height: 20),
        //.. Confirm Password
        CustomTextField(
          controller: confirmPassword,
          label: "Confirm Password",
          errorText: errors?['confirm_passsword']?.first,
        ),
        const SizedBox(height: 20),
        //.. Button Login
        CustomElevatedButton(
          nameButton: "Register",
          onPressed: () => _register(),
        ),
        const SizedBox(height: 20),
        //.. Button untuk mengarah halaman register
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
            );
          },
          child: const Text(
            "Belum ada akun? register",
            style: TextStyle(
                fontWeight: FontWeight.w400, color: Color(0xFF6EC207)),
          ),
        )
      ],
    );
  }
}
