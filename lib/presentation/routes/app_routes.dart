import 'package:shopping/presentation/pages/HomePage.dart';
import 'package:shopping/presentation/pages/SearchPage.dart';
import 'package:shopping/presentation/pages/SettingsPage.dart';
import 'package:shopping/presentation/pages/ShopPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppRoutes {
  static const String home = '/home';
  static const String shop = '/shop';
  static const String search = '/search';
  static const String settings = '/settings';

  static Route<dynamic> generateRoute(RouteSettings Rsettings) {
    switch (Rsettings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case shop:
        return MaterialPageRoute(builder: (_) => const ShopPage());
      case search:
        return MaterialPageRoute(builder: (_) => const SearchPage());
      case settings:
        return MaterialPageRoute(builder: (_) => const SettingsPage());
      default:
        return MaterialPageRoute(builder: (_) => const HomePage());
    }
  }
}