import 'package:shared_preferences/shared_preferences.dart';

int isDarkMode=1;
Future<int> isDark() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isDarkMode = prefs.getInt('isDarkMode') as int;
  //print("is darkmode from serivce: $isDarkMode");
  return isDarkMode;
}
