import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping/presentation/pages/login/register/SignUpPage.dart';
import 'package:shopping/presentation/widgets/bottom_navigation.dart';
import 'package:shopping/presentation/widgets/textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> loginUser() async {
    if (_emailController.text == "kerby@gmail.com" &&
        _passwordController.text == "123") {
      String userToken = "admin";
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_token', userToken);

      print("Token stored: $userToken");

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const BottomNavigationScreen()),
      );
    } else {
      // ScaffoldMessenger.of(
      //   context,
      // ).showSnackBar(SnackBar(content: Text("Invalid credentials")));

      String userToken = "user";
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_token', userToken);

      print("Token stored: $userToken");

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const BottomNavigationScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCFCFF),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Image.asset(
                  'assets/images/shopify-logo.png',
                  width: 150,
                ),
              ),
              SizedBox(height: 40),
              CustomTextFormField(
                controller: _emailController,
                labelText: 'Email',
                icon: Icons.person_outline_outlined,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.toString().isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              CustomTextFormField(
                controller: _passwordController,
                labelText: 'Password',
                icon: Icons.password_outlined,
                isPassword: true,
                keyboardType: TextInputType.visiblePassword,
                validator: (value) {
                  if (value == null || value.toString().isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  loginUser();
                },
                label: const Text(
                  'Login',
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFCFCFF),
                  side: const BorderSide(color: Colors.black, width: 1),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),

              SizedBox(height: 50),

              Row(
                children: [
                  Expanded(child: Divider(color: Colors.black, thickness: 1)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text("OR", style: const TextStyle(fontSize: 16)),
                  ),
                  Expanded(child: Divider(color: Colors.black, thickness: 1)),
                ],
              ),

              SizedBox(height: 20),

              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUpPage()),
                  );
                },
                label: const Text(
                  'Login with Google',
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
                icon: SizedBox(
                  height: 25,
                  width: 25,
                  child: SvgPicture.asset('assets/vectors/google.svg'),
                ),

                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFCFCFF),
                  side: const BorderSide(color: Colors.black, width: 1),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
