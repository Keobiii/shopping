import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping/core/utils/sharedpreference.dart';
import 'package:shopping/main.dart';
import 'package:shopping/presentation/pages/login/register/LoginPage.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String? userToken;

  @override
  void initState() {
    super.initState();
    loadUserToken();
  }

  Future<void> loadUserToken() async {
    userToken = await getUserToken();
    setState(() {});
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Hello $userToken'),
            ElevatedButton(
              onPressed: () {
                logout();
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
