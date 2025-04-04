import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.white,
          ),

          Positioned(
            bottom: -10,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/contour_bg_1.png',
              fit: BoxFit.fitWidth,
            ),
          ),

          Center(child: Text('Explore...')),
        ],
      ),
    );
  }
}
