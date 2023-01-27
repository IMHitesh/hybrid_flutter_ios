import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pkg/src/app_config/app_config.dart';
import 'package:flutter_pkg/src/controller/counter_controller.dart';
import '../actions/app_actions.dart';
import 'dashboard_controller.dart';
import 'login_controller.dart';
import 'splash_controller.dart';

class AppController {
  static const platform = MethodChannel('com.bytes.fast');
  late final LoginController _loginController = LoginController();
  late final DashboardController _dashboardController = DashboardController();
  late final SplashController _splashController = SplashController();
  late CounterController _counterController;

  AppController() {
    platform.setMethodCallHandler(_receiveFromHost);
  }

  Future<void> _receiveFromHost(MethodCall call) async {
    try {
      final data = await getData(call.arguments);
      final action = AppActions.values.byName(call.method);

      switch (action) {
        case AppActions.appConfig:
          Config.setupAppConfig(data);
          break;
        case AppActions.loginClick:
          _loginController.onLoginClick(action);
          break;
        case AppActions.validateLoginCred:
          _loginController.validateEmailPassword(data, action);
          break;
        case AppActions.logoutClick:
          _dashboardController.logoutClick(data, action);
          break;
        case AppActions.getAuthStatus:
          _splashController.getAuthStatus(data, action);
          break;
        case AppActions.getDashboardData:
          _dashboardController.getDashboardData(action);
          break;
        case AppActions.countDownInit:
          _counterController = CounterController();
          break;
        case AppActions.timerPauseOrChangeOrPause:
          _counterController.onTimerStartClick(action);
          break;        
      }
    } on PlatformException catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<Map<String, dynamic>?> getData(String? data) async {
    if (data != null) {
      Map<String, dynamic> jsonData = json.decode(data);
      return jsonData;
    }
    return null;
  }

  static void triggerNativeMethod(
      AppActions action, Map<String, dynamic>? data) async {
    debugPrint(
        "✅✅✅ Flutter to Native - Action: ${action.toString()}\n\n Data: $data");
    platform.invokeMethod<String>(action.name, data);
  }
}
