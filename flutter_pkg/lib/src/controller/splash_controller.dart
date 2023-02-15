import 'package:flutter_pkg/src/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../actions/app_actions.dart';

class SplashController {
  final splash = Splash();
  
  getAuthStatus(Map<String, dynamic>? data, AppActions action) async {
    final pref = await SharedPreferences.getInstance();
    final isLogin = pref.getBool("is_login") ?? false;
    splash.onAuthStatusChange(isLogin);    
  }
}
