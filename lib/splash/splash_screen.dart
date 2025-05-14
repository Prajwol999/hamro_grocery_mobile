import 'package:flutter/material.dart';
import '../common/color_extension.dart'; // Update with actual path

class SplashScreen extends StatelessWidget {
   const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'assets/images/welcom_bg.png',
            fit: BoxFit.cover,
          ),
          // Foreground content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App logo
              Image.asset(
                'assets/images/hamro.png',
                width: 150,
              ),
              const SizedBox(height: 20),
              // Text message
              Text(
                'Avoid the Line and\nShop from Home',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: TColor.primaryText,
                  shadows: [
                    Shadow(
                      offset: Offset(1, 1),
                      blurRadius: 2,
                      color: Colors.black26,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              // Illustration
              Image.asset(
                'assets/images/queuepager.png',
                width: 250,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
