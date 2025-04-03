import 'package:shopping/presentation/pages/HomePage.dart';
import 'package:shopping/presentation/pages/SearchPage.dart';
import 'package:shopping/presentation/pages/SettingsPage.dart';
import 'package:shopping/presentation/pages/ShopPage.dart';
import 'package:shopping/presentation/pages/WishlistPage.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class GoogleNavigation extends StatefulWidget {
  const GoogleNavigation({super.key});

  @override
  _GoogleNavigationState createState() => _GoogleNavigationState();
}

class _GoogleNavigationState extends State<GoogleNavigation> {
  int _selectedIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          HomePage(),
          ShopPage(),
          WishlistPage(),
          SettingsPage(),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
          child: GNav(
            backgroundColor: Colors.black,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey.shade800,
            gap: 8,
            padding: EdgeInsets.all(16),
            tabs: [
              GButton(icon: Icons.home_outlined, text: 'Home'),
              GButton(icon: Icons.shopping_basket_outlined, text: 'Shop'),
              GButton(icon: Icons.favorite_border, text: 'Wishlist'),
              GButton(icon: Icons.settings, text: 'Settings'),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: _onTabTapped,
          ),
        ),
      ),
    );
  }
}
