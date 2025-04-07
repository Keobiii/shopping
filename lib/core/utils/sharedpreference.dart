import 'package:shared_preferences/shared_preferences.dart';

Future<String?> getUserToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('user_token');
}
