import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/data/providers/cart_provider.dart';
import 'package:shopping/data/providers/favorite_provider.dart';
import 'package:shopping/presentation/state/bloc/cart_bloc.dart';
import 'package:shopping/presentation/state/bloc/favorite_bloc.dart';
import 'package:shopping/presentation/widgets/google_navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // ChangeNotifierProvider(create: (_) => FavoriteProvider()),
        // ChangeNotifierProvider(create: (_) => CartProvider())
        BlocProvider(create: (_) => FavoriteBloc()),
        BlocProvider(create: (_) => CartBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: const BottomNavigationScreen(),
        home: GoogleNavigation(),
      ),
    );
  }
}
