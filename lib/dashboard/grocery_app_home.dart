import 'package:flutter/material.dart';
import 'home_view.dart';

class GroceryAppHome extends StatefulWidget {
  const GroceryAppHome({super.key});

  @override
  State<GroceryAppHome> createState() => _GroceryAppHomeState();
}

class _GroceryAppHomeState extends State<GroceryAppHome> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const Center(child: Text('Your data for this screen will appear here', style: TextStyle(fontSize: 18, color: Colors.grey))),
    const Center(child: Text('Your data for this screen will appear here', style: TextStyle(fontSize: 18, color: Colors.grey))),
    const Center(child: Text('Your data for this screen will appear here', style: TextStyle(fontSize: 18, color: Colors.grey))),
    const Center(child: Text('Your data for this screen will appear here', style: TextStyle(fontSize: 18, color: Colors.grey))),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 70,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.grey),
          onPressed: () {},
        ),
        title: Image.asset('assets/hamro2.png', height: 40),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.grey),
            onPressed: () {},
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, -3),
            ),
          ],
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Shops'),
            BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'My List'),
            BottomNavigationBarItem(icon: Icon(Icons.history), label: 'My History'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
          backgroundColor: Colors.transparent,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
          elevation: 0,
        ),
      ),
    );
  }
}
