import 'package:flutter_pkg/src/models/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends SplashInteractor{
  final splash = Splash();

  SplashController() {
    SplashInteractor.setup(this);
  }
  
  @override
  void getAuthStatus() async{
    final pref = await SharedPreferences.getInstance();
    final isLogin = pref.getBool("is_login") ?? false;
    splash.onAuthStatusChange(isLogin);
  }  
}
