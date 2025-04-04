import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shopping/presentation/widgets/textfield.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: BackButton()),
      backgroundColor: const Color(0xFFFCFCFF),
      body: SingleChildScrollView(
        child: Center(
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
                  labelText: 'First Name',
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
                  labelText: 'Last Name',
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
                  onPressed: () {},
                  label: const Text(
                    'Sign Up',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
