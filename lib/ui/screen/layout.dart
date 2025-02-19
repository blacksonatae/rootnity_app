import 'package:flutter/material.dart';
import 'package:rootnity_app/core/themes.dart';
import 'package:rootnity_app/ui/screen/home.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(child: const HomeScreen())
          ],
        ),
      ),
    );
  }

  /*
  * Header */
  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // nama user or username
              Text(
                "Kazuya",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Themes.eerieBlack,
                ),
              ),
              // button untuk logout
              GestureDetector(
                onTap: () {
                  print("Logout Clicked !!!");
                },
                child: Icon(
                  Icons.arrow_drop_down_rounded,
                  color: Themes.eerieBlack,
                  size: 30,
                ),
              )
            ],
          ),
          GestureDetector(
            onTap: () {
              print("Add Button Clicked !!!");
            },
            child: Icon(
              Icons.add_circle_outline,
              color: Themes.eerieBlack,
            ),
          ),
        ],
      ),
    );
  }
}
