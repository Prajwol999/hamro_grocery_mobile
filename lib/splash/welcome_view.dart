import 'package:flutter/material.dart';
import 'package:hamro_grocery_mobile/feature/auth/presentation/view/signin_page.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isTablet = constraints.maxWidth >= 600;

            return Stack(
              children: [
                // Background Image
                Positioned.fill(
                  child: Image.asset(
                    "assets/welcom_bg.png",
                    fit: BoxFit.cover,
                  ),
                ),

                // Get Started Button
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: media.width * (isTablet ? 0.15 : 0.08),
                      right: media.width * (isTablet ? 0.15 : 0.08),
                      bottom: media.height * (isTablet ? 0.08 : 0.06),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignInPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: EdgeInsets.symmetric(
                            vertical: media.height * (isTablet ? 0.03 : 0.018),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 3,
                        ),
                        child: Text(
                          'Get Started',
                          style: TextStyle(
                            fontSize: media.width * (isTablet ? 0.035 : 0.045),
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
