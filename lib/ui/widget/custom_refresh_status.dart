import 'package:flutter/material.dart';

class CustomRefreshStatus extends StatelessWidget {
  final String dirAnimation;
  final String textRefreshStatus;

  const CustomRefreshStatus({
    super.key,
    required this.textRefreshStatus,
    required this.dirAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //.. Icons dalam bentuk animasi
              SizedBox(
                height: 35,
                child: Image.asset(
                  dirAnimation,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 4),
              //.. Text
              Text(
                textRefreshStatus,
                style: const TextStyle(fontSize: 10, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
