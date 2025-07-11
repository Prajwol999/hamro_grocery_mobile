import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hamro_grocery_mobile/feature/auth/presentation/view/profile_detail_screen.dart'; // Import the new detail screen
import 'package:hamro_grocery_mobile/feature/auth/presentation/view_model/profile_view_model/profile_state.dart';
import 'package:hamro_grocery_mobile/feature/auth/presentation/view_model/profile_view_model/profile_view_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(24.0),
          alignment: Alignment.center,
          // Wrap the Column with a BlocBuilder to get the latest state
          child: BlocBuilder<ProfileViewModel, ProfileState>(
            builder: (context, state) {
              // Use the authEntity from the state, with fallbacks for safety
              final user = state.authEntity;

              return Column(
                children: [
                  const SizedBox(height: 30),
                  // Logo
                  const Text(
                    'Hamro Grocery',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'YourLogoFont',
                    ),
                  ),
                  const SizedBox(height: 30),
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Color(0xFFE0E0E0),
                    child: Icon(Icons.person, size: 60, color: Colors.white),
                  ),
                  const SizedBox(height: 16),

                  // --- DYNAMIC DATA ---
                  Text(
                    // Display the user's full name from the state
                    'Hello, ${user?.fullName ?? 'User'}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    // Display the user's email from the state
                    user?.email ?? 'user@email.com',
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),

                  // --- END DYNAMIC DATA ---
                  const SizedBox(height: 40),

                  // Menu Buttons
                  _ProfileMenuButton(
                    text: 'Profile',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => BlocProvider.value(
                                // Provide the existing ViewModel to the new screen
                                value: context.read<ProfileViewModel>(),
                                child: const ProfileDetailScreen(),
                              ),
                        ),
                      );
                    },
                  ),
                  _ProfileMenuButton(
                    text: 'Delivery Address',
                    onPressed: () {},
                  ),
                  _ProfileMenuButton(text: 'Support Center', onPressed: () {}),
                  _ProfileMenuButton(text: 'Legal Policy', onPressed: () {}),

                  const SizedBox(height: 30),

                  // Logout Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD9534F), // Red color
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Logout',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

// Reusable button widget for the menu items
class _ProfileMenuButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const _ProfileMenuButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4CAF50), // Green color
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            text,
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
