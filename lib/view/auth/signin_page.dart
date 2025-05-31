import 'package:flutter/material.dart';
import 'package:hamro_grocery_mobile/view/auth/dashboard/grocery_app_home.dart';


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
      setState(() => _isEmailValid = false);
      _showSnackBar("Please enter a valid email address", Colors.red);
      return;
    }

    if (password.length < 8) {
      setState(() => _isPasswordValid = false);
      _showSnackBar("Password should be at least 8 characters", Colors.red);
      return;
    }

    if (email == "admin@gmail.com" && password == "admin123") {
      _showSnackBar("Sign in successful", Colors.green);

      _emailController.clear();
      _passwordController.clear();
      _emailFocusNode.unfocus();
      _passwordFocusNode.unfocus();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const GroceryAppHome()),
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
    final media = MediaQuery.of(context).size;
    final paddingH = media.width * 0.06;
    final fontSize = media.width * 0.045;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            _emailFocusNode.unfocus();
            _passwordFocusNode.unfocus();
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: paddingH),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: media.height * 0.06),
                Center(
                  child: Image.asset(
                    'assets/hamro2.png',
                    height: media.width * 0.2,
                  ),
                ),
                SizedBox(height: media.height * 0.04),
                Text(
                  "Welcome Back!",
                  style: TextStyle(
                    fontSize: media.width * 0.07,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: media.height * 0.01),
                Text(
                  "Sign in to continue shopping",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: fontSize,
                  ),
                ),
                SizedBox(height: media.height * 0.04),

                /// Email
                _buildEmailField(),

                SizedBox(height: media.height * 0.025),

                /// Password
                _buildPasswordField(),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ForgotPassword()),
                    ),
                    child: const Text("Forgot Password?", style: TextStyle(color: Colors.blue)),
                  ),
                ),

                SizedBox(height: media.height * 0.03),

                /// Sign In Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _signIn,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: media.height * 0.02),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: fontSize),
                    ),
                    child: const Text("SIGN IN"),
                  ),
                ),

                SizedBox(height: media.height * 0.04),
                Center(child: Text("Or sign in with", style: TextStyle(color: Colors.black54, fontSize: fontSize))),
                SizedBox(height: media.height * 0.02),

                /// Social Buttons
                Row(
                  children: [
                    Expanded(child: _buildSocialButton("Facebook", Icons.facebook)),
                    const SizedBox(width: 10),
                    Expanded(child: _buildSocialButton("Google", null, imagePath: "assets/google.png")),
                  ],
                ),

                SizedBox(height: media.height * 0.04),

                /// Signup Prompt
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account? ", style: TextStyle(color: Colors.black54, fontSize: fontSize)),
                    TextButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignUpPage()),
                      ),
                      child: Text("Sign up here", style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize, color: Colors.blue)),
                    )
                  ],
                ),

                SizedBox(height: media.height * 0.02),

                /// Social Media Icons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () => _launchURL('https://www.instagram.com'),
                      icon: Image.asset('assets/insta_logo.png', height: media.width * 0.08),
                    ),
                    SizedBox(width: media.width * 0.1),
                    IconButton(
                      onPressed: () => _launchURL('https://www.facebook.com'),
                      icon: Image.asset('assets/fb_logo.png', height: media.width * 0.08),
                    ),
                  ],
                ),

                SizedBox(height: media.height * 0.03),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      keyboardType: TextInputType.emailAddress,
      maxLength: 50,
      onChanged: (value) => setState(() {
        _isEmailValid = value.isEmpty ? true : _isValidEmail(value.trim());
      }),
      decoration: _inputDecoration(
        label: "Email Address",
        icon: Icons.email_outlined,
        isValid: _isEmailValid,
        errorText: "Please enter a valid email",
      ),
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      obscureText: _obscurePassword,
      maxLength: 12,
      onChanged: (value) => setState(() {
        _isPasswordValid = value.isEmpty ? true : value.length >= 6;
      }),
      decoration: _inputDecoration(
        label: "Password",
        icon: Icons.lock_outline,
        isValid: _isPasswordValid,
        errorText: "Password must be at least 6 characters",
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
            color: Colors.black54,
          ),
          onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String label,
    required IconData icon,
    required bool isValid,
    required String errorText,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.black54),
      prefixIcon: Icon(icon, color: Colors.black54),
      suffixIcon: suffixIcon,
      errorText: isValid ? null : errorText,
      errorStyle: const TextStyle(color: Colors.redAccent),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: isValid ? Colors.grey.shade300 : Colors.redAccent),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: isValid ? Colors.blue : Colors.redAccent),
        borderRadius: BorderRadius.circular(12),
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  Widget _buildSocialButton(String label, IconData? icon, {String? imagePath}) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: icon != null
          ? Icon(icon, color: Colors.black87)
          : Image.asset(imagePath!, height: 20, width: 20),
      label: Text(label, style: const TextStyle(color: Colors.black87)),
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Colors.black26),
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}