import 'package:shared_preferences/shared_preferences.dart';

import '../actions/app_actions.dart';
import 'app_controller.dart';

class SplashController {
  getAuthStatus(Map<String, dynamic>? data, AppActions action) async {
    final pref = await SharedPreferences.getInstance();
    final isLogin = pref.getBool("is_login") ?? false;
    AppController.triggerNativeMethod(action, {"is_login": isLogin});
  }
}
