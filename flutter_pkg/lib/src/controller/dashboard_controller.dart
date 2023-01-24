import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../actions/app_actions.dart';
import 'app_controller.dart';
import 'package:http/http.dart' as http;

class DashboardController {
  logoutClick(Map<String, dynamic>? data, AppActions action) async{
    final pref = await SharedPreferences.getInstance();
    pref.setBool("is_login", false);
    AppController.triggerNativeMethod(action, {"is_logout": true});
  }

  getDashboardData(AppActions action) async{
    final users = await fetchUsers();
    AppController.triggerNativeMethod(action, {"data": users});
  }

  Future<List<dynamic>> fetchUsers() async {
    final response = await http.get(Uri.parse('https://gorest.co.in/public/v2/users'));
    List<dynamic> arrUser = [];
    if (response.statusCode == 200) {
      List arrUsers = jsonDecode(response.body) ?? [];
      for (var value in arrUsers) {
        arrUser.add(value);        
      }
    }
    return arrUser;
  }
}
