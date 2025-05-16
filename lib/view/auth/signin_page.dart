import 'package:flutter/material.dart';
import 'package:hamro_grocery_mobile/view/auth/dashboard_view.dart';
import 'package:hamro_grocery_mobile/view/auth/forgot_password.dart';
import 'signup_page.dart';
import 'package:url_launcher/url_launcher.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  bool _isPasswordValid = true;
  bool _isEmailValid = true;
  bool _obscurePassword = true;

  void _signIn() {
  final email = _emailController.text.trim();
  final password = _passwordController.text;

  if (email.isEmpty || password.isEmpty) {
    _showSnackBar("Please fill in all fields", Colors.red);
    return;
  }

  if (!_isValidEmail(email)) {
    setState(() {
      _isEmailValid = false;
    });
    _showSnackBar("Please enter a valid email address", Colors.red);
    return;
  }

  if (password.length < 8) {
    setState(() {
      _isPasswordValid = false;
    });
    _showSnackBar("Password should be at least 8 characters", Colors.red);
    return;
  }

  if (email == "admin@gmail.com" && password == "admin123") {
    _showSnackBar("Sign in successful", Colors.lightBlueAccent);

    _emailController.clear();
    _passwordController.clear();

    _emailFocusNode.unfocus();
    _passwordFocusNode.unfocus();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const DashboardView()),
    );
  } else {
    _showSnackBar("Invalid email or password", Colors.red);
  }
}

  

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  void _showSnackBar(String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: Center(
          heightFactor: 1,
          child: Text(
            message,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      _showSnackBar("Could not open the URL", Colors.red);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 51, 67, 39),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            _emailFocusNode.unfocus();
            _passwordFocusNode.unfocus();
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 25.0), // More balanced horizontal padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50), // Increased top spacing
                Center(
                  child: Image.asset(
                    'assets/hamro2.png',
                    height: 80, // Slightly smaller and cleaner
                  ),
                ),
                const SizedBox(height: 30), // Increased spacing
                const Text(
                  "Welcome Back!", // More inviting text
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white), // Slightly smaller font
                ),
                const SizedBox(height: 8),
                const Text(
                  "Sign in to continue shopping", // More descriptive subtitle
                  style: TextStyle(color: Colors.white70, fontSize: 16), // Slightly larger subtitle
                ),
                const SizedBox(height: 40), // Increased spacing before fields

                // Email Field
                TextFormField(
                  controller: _emailController,
                  focusNode: _emailFocusNode,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(color: Colors.white),
                  maxLength: 50,
                  buildCounter: (_, {required currentLength, required isFocused, maxLength}) => null,
                  onChanged: (value) {
                    setState(() {
                      _isEmailValid = value.isEmpty ? true : _isValidEmail(value.trim());
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "Email Address", // More specific label
                    labelStyle: const TextStyle(color: Colors.white70),
                    prefixIcon: const Icon(Icons.email_outlined, color: Colors.white70), // More modern icon
                    errorText: _isEmailValid ? null : "Please enter a valid email", // Clearer error message
                    errorStyle: const TextStyle(color: Colors.redAccent),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: _isEmailValid ? Colors.white30 : Colors.redAccent),
                      borderRadius: BorderRadius.circular(12), // Rounded borders
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: _isEmailValid ? Colors.white : Colors.redAccent),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),

                const SizedBox(height: 20),

                // Password Field
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  focusNode: _passwordFocusNode,
                  style: const TextStyle(color: Colors.white),
                  maxLength: 12,
                  buildCounter: (_, {required currentLength, required isFocused, maxLength}) => null,
                  onChanged: (value) {
                    setState(() {
                      _isPasswordValid = value.isEmpty ? true : value.length >= 6;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: const TextStyle(color: Colors.white70),
                    prefixIcon: const Icon(Icons.lock_outline, color: Colors.white70), // More modern icon
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined, // More modern icons
                        color: Colors.white70,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    errorText: _isPasswordValid ? null : "Password must be at least 6 characters", // Clearer error
                    errorStyle: const TextStyle(color: Colors.redAccent),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: _isPasswordValid ? Colors.white30 : Colors.redAccent),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: _isPasswordValid ? Colors.white : Colors.redAccent),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),

                const SizedBox(height: 15), // Slightly reduced spacing

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton( // Using TextButton for better semantics
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ForgotPassword()),
                    ),
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(height: 30), // Increased spacing before button

                SizedBox( // Using SizedBox to control width for better aesthetics
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _signIn,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF2A4759),
                      padding: const EdgeInsets.symmetric(vertical: 18), // Slightly increased padding
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Consistent rounding
                      textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16), // Slightly larger text
                    ),
                    child: const Text("SIGN IN"),
                  ),
                ),

                const SizedBox(height: 30),

                const Center(child: Text("Or sign in with", style: TextStyle(color: Colors.white60))),
                const SizedBox(height: 15),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Evenly space social buttons
                  children: [
                    Expanded( // Make buttons take equal width
                      child: OutlinedButton.icon( // Using OutlinedButton for a cleaner look
                        onPressed: () {},
                        icon: const Icon(Icons.facebook, color: Colors.white), // White icon
                        label: const Text("Facebook", style: TextStyle(color: Colors.white)),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.white30),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: Image.asset(
                          "assets/google.png",
                          height: 20,
                          width: 20,
                        ),
                        label: const Text("Google", style: TextStyle(color: Colors.white)),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.white30),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? ", style: TextStyle(color: Colors.white60)),
                    TextButton( // Using TextButton for better semantics
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignUpPage()),
                      ),
                      child: const Text("Sign up here", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                    )
                  ],
                ),

                const SizedBox(height: 30),

                // Instagram and Facebook logos (moved to the bottom with different styling)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () => _launchURL('https://www.instagram.com'),
                      icon: Image.asset(
                        'assets/insta_logo.png',
                        height: 30,
                        width: 30,
                      ),
                    ),
                    const SizedBox(width: 30),
                    IconButton(
                      onPressed: () => _launchURL('https://www.facebook.com'),
                      icon: Image.asset(
                        'assets/fb_logo.png',
                        height: 30,
                        width: 30,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20), // Add some bottom padding
              ],
            ),
          ),
        ),
      ),
    );
  }
}