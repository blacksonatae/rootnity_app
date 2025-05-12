import 'package:flutter/material.dart';
import 'package:rootnity_app/core/theme/colors.dart';
import 'package:rootnity_app/core/utils/helpers/navigator_helper.dart';
import 'package:rootnity_app/data/controllers/users_controller.dart';
import 'package:rootnity_app/ui/screens/auth/auth_layout.dart';
import 'package:rootnity_app/ui/screens/auth/login.dart';
import 'package:rootnity_app/ui/screens/main_screen.dart';
import 'package:rootnity_app/ui/widgets/custom_elevated_button.dart';
import 'package:rootnity_app/ui/widgets/custom_text_field.dart';

//.. Register
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
  Map<String, dynamic>? errors;

  //.. Fungsi untuk register
  void _register() async {
    var result = await UsersController.register(
        nameController.text,
        emailController.text,
        passwordController.text,
        confirmPasswordController.text,
        context);

    //.. Kondisi jika status true maka akan diarahkan ke halaman main screen
    if (result['status'] == true) {
      NavigatorHelper.pushReplacement(context, const MainScreen());
    }

    //.. Kondisi jika status false maka akan menampilkan error dan tidak dapat mengarah ke halaman main
    if (result['status'] == false) {
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
          label: "Nama Pengguna",
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
        const SizedBox(height: 30),
        //.. Button Login
        CustomElevatedButton(
          nameButton: "Register",
          onPressed: () => _register(),
        ),
        const SizedBox(height: 20),
        //.. Button untuk mengarah ke halaman register
        GestureDetector(
          onTap: () => NavigatorHelper.push(context, const Login()),
          child: const Text(
            "Sudah punya akun? Login di sini",
            style: TextStyle(
                color: RootColors.kellyGreen, fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }
}
