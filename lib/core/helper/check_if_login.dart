import 'package:shared_preferences/shared_preferences.dart';

Future<bool> checkIfLoggedIn() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');
  final userId = prefs.getInt('userId');
  return token != null || userId != null;
}
