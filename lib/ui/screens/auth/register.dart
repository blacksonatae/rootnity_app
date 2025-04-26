import 'package:flutter/material.dart';
import 'package:rootnity_app/core/theme/colors.dart';
import 'package:rootnity_app/core/utils/helpers/navigator_helper.dart';
import 'package:rootnity_app/services/controller/auth_services.dart';
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

  //.. Variabel untuk mengampung error dari API
  Map<String, dynamic>? errors = {};

  //.. Fungsi untuk register
  void _register() async {
    var result = await AuthServices.register(
        nameController.text,
        emailController.text,
        passwordController.text,
        confirmPasswordController.text,
        context);

    //.. Kondisi jika status true maka akan diarahkan ke halaman main
    if (result['status'] == 'true') {}

    if(result['status'] == false) {
      setState(() {
        errors = result['errors'] ?? {};
      });
    }
  }

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
          errorText: errors?['name']?.first,
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
          errorText: errors?['confirm_password']?.first,
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
