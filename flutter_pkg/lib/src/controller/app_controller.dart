import 'package:flutter/services.dart';
import 'package:flutter_pkg/src/controller/counter_controller.dart';
import 'package:flutter_pkg/src/controller/login_controller.dart';
import 'dashboard_controller.dart';
import 'splash_controller.dart';

class AppController {
  static const platform = MethodChannel('com.bytes.fast');

  AppController() {
    SplashController();
    LoginController();
    DashboardController();
    CounterController();
  }
}
