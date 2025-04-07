import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping/data/providers/cart_provider.dart';
import 'package:shopping/data/providers/favorite_provider.dart';
import 'package:shopping/presentation/pages/login/register/LoginPage.dart';
import 'package:shopping/presentation/pages/login/register/SignUpPage.dart';
import 'package:shopping/presentation/state/bloc/cart_bloc.dart';
import 'package:shopping/presentation/state/bloc/favorite_bloc.dart';
import 'package:shopping/presentation/state/bloc/product_bloc.dart';
import 'package:shopping/presentation/widgets/bottom_navigation.dart';
import 'package:shopping/presentation/widgets/google_navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget _currentScreen = Scaffold(
    body: Center(child: CircularProgressIndicator()),
  );

  @override
  void initState() {
    super.initState();
    checkCredentials();
  }

  Future<void> checkCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final String? userToken = prefs.getString('user_token');
    print("Token in Main: " + userToken.toString());

    setState(() {
      _currentScreen =
          (userToken == null || userToken.isEmpty)
              ? LoginPage()
              : BottomNavigationScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => FavoriteBloc()),
        BlocProvider(create: (_) => CartBloc()),
        BlocProvider(create: (_) => ProductBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(textTheme: GoogleFonts.merriweatherTextTheme()),
        home: _currentScreen,
      ),
    );
  }
}
