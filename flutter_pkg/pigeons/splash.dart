import 'package:pigeon/pigeon.dart';

@HostApi()
abstract class Splash {  
  void onAuthStatusChange(bool isLogin);
}

@FlutterApi()
abstract class SplashInteractor {
  void getAuthStatus();  
}
