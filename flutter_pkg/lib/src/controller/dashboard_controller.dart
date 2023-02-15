import 'dart:convert';

import 'package:flutter_pkg/src/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../actions/app_actions.dart';
import 'package:http/http.dart' as http;

import '../models/dashboard.dart';

class DashboardController {
  final dashboard = Dashboard();

  logoutClick(Map<String, dynamic>? data, AppActions action) async {
    final pref = await SharedPreferences.getInstance();
    pref.setBool("is_login", false);
    dashboard.onLogout(true, "Logout successfull");
  }

  getDashboardData(AppActions action) async {
    final users = await fetchUsers();
    dashboard.onUserFetch(users, "Success");    
  }

  Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse('https://gorest.co.in/public/v2/users'));
    List<User> arrUser = [];
    if (response.statusCode == 200) {
      List arrUsers = jsonDecode(response.body) ?? [];
      for (var value in arrUsers) {
        final user = User.fromJson(value);
        arrUser.add(user);
      }
    }
    return arrUser;
  }
}
