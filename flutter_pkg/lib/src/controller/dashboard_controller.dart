import 'dart:convert';
import 'package:flutter_pkg/src/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../models/dashboard.dart';

class DashboardController extends DashboardInteractor {
  final dashboard = Dashboard();

  DashboardController() {
    DashboardInteractor.setup(this);
  }

  @override
  void fetchUserList() async {
    final users = await fetchUsers();
    dashboard.fetchUserListSuccess(users, "Success");
  }

   @override
  void onLogout() async{
    final pref = await SharedPreferences.getInstance();
    pref.setBool("is_login", false);
    dashboard.onLogoutResponse(true, "Logout successfull");
  }

  Future<List<User>> fetchUsers() async {
    final response =
        await http.get(Uri.parse('https://gorest.co.in/public/v2/users'));
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
