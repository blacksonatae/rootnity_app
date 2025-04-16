import 'package:flutter/material.dart';
import 'package:rootnity_app/core/theme/colors.dart';
import 'package:rootnity_app/core/utils/helpers/navigator_helper.dart';
import 'package:rootnity_app/ui/screens/auth/auth_layout.dart';
import 'package:rootnity_app/ui/screens/auth/register.dart';
import 'package:rootnity_app/ui/widgets/custom_elevated_button.dart';
import 'package:rootnity_app/ui/widgets/custom_text_field.dart';

//.. Login Screens
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //.. fungsi untuk login
  void _login() async {}

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      title: "Login",
      body: [
        const SizedBox(height: 30),
        //.. Email
        CustomTextField(
          controller: emailController,
          label: "Email",
        ),
        const SizedBox(height: 30),
        //.. Password
        CustomTextField(
          controller: passwordController,
          label: "Password",
          isPassword: true,
        ),
        const SizedBox(height: 35),
        //.. Button Login
        CustomElevatedButton(
          nameButton: "Login",
          onPressed: () => _login(),
        ),
        const SizedBox(height: 30),
        //.. Button untuk mengarah halaman register
        GestureDetector(
          onTap: () => NavigatorHelper.push(context, const Register()),
          child: const Text(
            "Belum punya akun? Daftar di sini",
            style: TextStyle(color: RootColors.kellyGreen, fontWeight: FontWeight.w400),
          ), //.. Register
        ),
      ],
    );
  }
}
