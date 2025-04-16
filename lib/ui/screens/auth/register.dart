import 'package:flutter/material.dart';
import 'package:rootnity_app/core/theme/colors.dart';
import 'package:rootnity_app/core/utils/helpers/navigator_helper.dart';
import 'package:rootnity_app/ui/screens/auth/auth_layout.dart';
import 'package:rootnity_app/ui/screens/auth/login.dart';
import 'package:rootnity_app/ui/widgets/custom_elevated_button.dart';
import 'package:rootnity_app/ui/widgets/custom_text_field.dart';

//.. Register Screen
class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  //.. Fungsi untuk register
  void _register() async {}

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      title: "Register",
      body: [
        const SizedBox(height: 25),
        //.. Name
        CustomTextField(
          controller: nameController,
          label: "Name",
        ),
        const SizedBox(height: 20),
        //.. Email
        CustomTextField(
          controller: emailController,
          label: "Email",
        ),
        const SizedBox(height: 20),
        //.. Password
        CustomTextField(
          controller: passwordController,
          label: "Password",
          isPassword: true,
        ),
        const SizedBox(height: 20),
        //.. Confirm Password
        CustomTextField(
          controller: confirmPasswordController,
          label: "Confirm Password",
          isPassword: true,
        ),
        const SizedBox(height: 20),
        //.. Button Login
        CustomElevatedButton(
          nameButton: "Login",
          onPressed: () => _register(),
        ),
        const SizedBox(height: 20),
        //.. Button untuk mengarah halaman register
        GestureDetector(
          onTap: () => NavigatorHelper.push(context, const Login()),
          child: const Text(
            "Sudah punya akun? Login di sini",
            style: TextStyle(
                color: RootColors.kellyGreen, fontWeight: FontWeight.w400),
          ), //.. Register
        ),
      ],
    );
  }
}
