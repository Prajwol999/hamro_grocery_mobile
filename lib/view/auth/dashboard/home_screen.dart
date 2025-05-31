import 'package:flutter/material.dart';
import 'category_card.dart';
import 'product_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search bar
          _buildSearchBar(),

          // Shop By Category
          _buildSectionHeader('Shop By Category', onTap: () {}),
          SizedBox(
            height: 130,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                CategoryCard(title: 'Fruits & Vegetables', imageUrl: 'assets/fresh_fruits.png'),
                CategoryCard(title: 'Meat & Seafood', imageUrl: 'assets/beef_bone.png'),
                CategoryCard(title: 'Dairy & Eggs', imageUrl: 'assets/dairy_eggs.png'),
                CategoryCard(title: 'Bakery & sweets', imageUrl: 'assets/bakery_snacks.png'),
                CategoryCard(title: 'Beverages', imageUrl: 'assets/beverages.png'),
              ],
            ),
          ),

          const SizedBox(height: 24.0),

          // Latest Added
          _buildSectionHeader('Latest added', onTap: () {}),
          SizedBox(
            height: 340,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                ProductCard(name: 'Godawari Rice', price: '1300', unit: '20kg', imageUrl: 'assets/rice.png'),
                ProductCard(name: 'Cooking oil', price: '250', unit: '0.5L', imageUrl: 'assets/cooking_oil.png'),
                ProductCard(name: 'Orange juice', price: '50', unit: '0.25L', imageUrl: 'assets/orange_juice.png'),
                ProductCard(name: 'Eggs', price: '120', unit: '6 pc', imageUrl: 'assets/dairy_eggs.png'),
                ProductCard(name: 'Sprite can', price: '260', unit: '2.25 ltr', imageUrl: 'assets/sprite_can.png'),
                ProductCard(name: 'Mayonnaise', price: '456', unit: '2 pc', imageUrl: 'assets/mayonnaise.png'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.only(bottom: 24.0),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: 'Search for groceries...',
          hintStyle: TextStyle(color: Colors.grey),
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
        ),
        style: TextStyle(color: Colors.black87),
      ),
    );
  }

  Widget _buildSectionHeader(String title, {required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
          TextButton(
            onPressed: onTap,
            child: const Text(
              'View all',
              style: TextStyle(color: Colors.green, fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
