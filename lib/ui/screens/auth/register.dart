import 'package:flutter/material.dart';
import 'package:rootnity_app/core/theme/theme_app.dart';
import 'package:rootnity_app/services/controller/auth_services.dart';
import 'package:rootnity_app/ui/screens/auth/auth_base_layout.dart';
import 'package:rootnity_app/ui/screens/auth/login.dart';
import 'package:rootnity_app/ui/screens/main_screen.dart';
import 'package:rootnity_app/ui/widgets/custom_elevated_button.dart';
import 'package:rootnity_app/ui/widgets/custom_text_field.dart';

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
      title: "Register",
      backgroundImagesUri: "images/pexels-mdsnmdsnmdsn-1216345.jpg",
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
          errorText: errors?['email']?.first,
        ),
        const SizedBox(height: 20),
        //.. Password
        CustomTextField(
          controller: password,
          label: "Password",
          isPassword: true,
          errorText: errors?['password']?.first,
        ),
        const SizedBox(height: 20),
        //.. Confirm Password
        CustomTextField(
          controller: confirmPassword,
          label: "Confirm Password",
          isPassword: true,
          errorText: errors?['confirm_passsword']?.first,
        ),
        const SizedBox(height: 20),
        //.. Button Register
        CustomElevatedButton(
          nameButton: "Register",
          onPressed: () => _register(),
        ),
        //.. Button untuk mengarah halaman login
        const SizedBox(height: 20),
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ),
          ),
          child: const Text(
            "Sudah ada akun? login",
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
