import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping/main.dart';
import 'package:shopping/presentation/pages/HomePage.dart';
import 'package:shopping/presentation/pages/ProductFormPage.dart';
import 'package:shopping/presentation/pages/SearchPage.dart';
import 'package:shopping/presentation/pages/SettingsPage.dart';
import 'package:shopping/presentation/pages/ShopPage.dart';
import 'package:shopping/presentation/pages/WishlistPage.dart';
import 'package:shopping/presentation/pages/product/view_product.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  _BottomNavigationScreenState createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int _currentIndex = 0;
  List<Widget> _pages = [];
  String? userToken;

  @override
  void initState() {
    super.initState();
    loadUserToken();
  }

  Future<void> loadUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    userToken = prefs.getString('user_token');

    setState(() {
      _pages = [
        HomePage(),
        ShopPage(),
        WishlistPage(),
        if (userToken == "admin") ViewProduct(),
        SettingsPage(),
      ];
    });
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: Colors.black,
          indicatorColor: const Color.fromARGB(
            255,
            169,
            169,
            169,
          ).withOpacity(0.2),
          labelTextStyle: WidgetStateProperty.all(
            TextStyle(
              fontSize: 14,
              height: 1.5,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          iconTheme: WidgetStateProperty.resolveWith((state) {
            if (state.contains(WidgetState.selected)) {
              return IconThemeData(color: Colors.white);
            }
            return IconThemeData(color: Colors.grey);
          }),
        ),
        child: NavigationBar(
          height: 80,
          selectedIndex: _currentIndex,
          onDestinationSelected: _onTabTapped,
          destinations: [
            const NavigationDestination(
              icon: Icon(IconsaxPlusBold.home),
              label: 'Home',
            ),
            const NavigationDestination(
              icon: Icon(IconsaxPlusBold.shop),
              label: 'Shop',
            ),
            const NavigationDestination(
              icon: Icon(IconsaxPlusBold.heart),
              label: 'Wishlist',
            ),
            if (userToken == "admin")
              const NavigationDestination(
                icon: Icon(IconsaxPlusBold.additem),
                label: 'Add',
              ),
            const NavigationDestination(
              icon: Icon(Icons.person_3_outlined),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
