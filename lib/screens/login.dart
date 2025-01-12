import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  void login() {

  }
  @override
  Widget build(BuildContext context) {
    // mendapatkan ukuran layar masing-masing hp
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          Image.asset(
            'images/pexels-mdsnmdsnmdsn-1216345.jpg',
            width: screenWidth,
            height: screenHeight * 0.4,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 20),

          // Kontent Form Login
          Padding(
            padding: EdgeInsets.all(30.0),
            child: Column(
              children: [
                const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 35),
                const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        )
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        )
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: login,
                      style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(Color(0xFF181C14)), // Warna hitam
                          foregroundColor: WidgetStateProperty.all<Color>(Colors.white), // Warna teks putih
                          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              )
                          )
                      ),
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500
                        ),
                        textAlign: TextAlign.center,
                      )
                  ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: Text(
                    'Belum menambahkan akun, register',
                    style: TextStyle(
                      color: Color(0xFF6EC207),
                      decoration: TextDecoration.none,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
