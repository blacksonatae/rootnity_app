import 'package:flutter/material.dart';
import 'package:rootnity_app/core/theme/theme_app.dart';
import 'package:rootnity_app/services/controller/auth_services.dart';
import 'package:rootnity_app/ui/screens/auth/auth_base_layout.dart';
import 'package:rootnity_app/ui/screens/auth/register.dart';
import 'package:rootnity_app/ui/screens/main_screen.dart';
import 'package:rootnity_app/ui/widgets/custom_elevated_button.dart';
import 'package:rootnity_app/ui/widgets/custom_text_field.dart';

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
  void _login() async {
    var result = await AuthServices.login(email.text, password.text, context);

    print(result);

    if (result['status'] == false) {
      setState(() {
        errors = result['errors'] ?? {};
      });
    }

    if (result['status'] == true) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const MainScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthBaseLayout(
      title: "Login",
      backgroundImagesUri: "images/pexels-mdsnmdsnmdsn-1216345.jpg",
      body: [
        const SizedBox(height: 30),
        //.. Email
        CustomTextField(
          controller: email,
          label: "Email",
          errorText: errors?['email']?.first,
        ),
        //.. Password
        const SizedBox(height: 20),
        CustomTextField(
          controller: password,
          label: "Password",
          isPassword: true,
          errorText: errors?['password']?.first,
        ),
        const SizedBox(height: 20),
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
        )
      ],
    );
  }
}
