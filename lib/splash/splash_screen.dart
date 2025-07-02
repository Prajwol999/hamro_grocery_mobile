import 'package:flutter/material.dart';
import "package:hamro_grocery_mobile/splash/welcome_view.dart";

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    fireOpenApp();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    _animationController.forward();
  }

  void fireOpenApp() async {
    await Future.delayed(const Duration(seconds: 3));
    startApp();
  }

  void startApp() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const WelcomeView()),
      (route) => false,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: Image.asset(
                "assets/bg.jpg",
                fit: BoxFit.cover,
              ),
            ),

            // Semi-transparent overlay
            Container(
              color: Colors.black.withOpacity(0.5),
            ),

            // Main Content
            Center(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: media.width * 0.08),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Logo
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: media.width * 0.5,
                            maxHeight: media.width * 0.5,
                          ),
                          child: Image.asset(
                            "assets/hamro2.png",
                            fit: BoxFit.contain,
                          ),
                        ),

                        SizedBox(height: media.height * 0.04),

                        // Tagline
                        Text(
                          "Your online grocery app\nwhere you can find everything you need.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: media.width * 0.045,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            height: 1.4,
                          ),
                        ),

                        SizedBox(height: media.height * 0.05),

                        // Loading Indicator
                        const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3,
                        ),

                        SizedBox(height: media.height * 0.05),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
