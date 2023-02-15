import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../actions/app_actions.dart';
import '../models/user.dart';
// import '../models/user.dart';
// import 'app_controller.dart';

class LoginController {
  String enteredEmail = "";
  String enteredPassword = "";
  final login = Login();

  validateEmailPassword(Map<String, dynamic>? data, AppActions action) {
    String? email = data?["email"] ?? "";
    final password = data?["password"] ?? "";
    bool isValid = false;
    if (email != null &&
        email.isNotEmpty &&
        password != null &&
        password.isNotEmpty) {
      enteredEmail = email;
      enteredPassword = password;
      isValid = true;
    }
    login.validateCredential(isValid);
  }

  onLoginClick(AppActions action) async {
    final user = await fetchUser(enteredEmail);
    if (user != null) {
      final pref = await SharedPreferences.getInstance();
      pref.setBool("is_login", true);
      // final jsonUser = user.toJson();
      // jsonUser["is_login"] = true;
      // jsonUser["message"] = "Login successfully...";
      login.loginSuccess(user);
      // AppController.triggerNativeMethod(action, jsonUser);
    } else {
      Map<String, dynamic> json = {};
      json["is_login"] = false;
      json["message"] =
          "Unable to login with given credential. Please make sure you've entered correct username and password";
      const message =
          "Unable to login with given credential. Please make sure you've entered correct username and password";
      login.loginFailed(message);
      // AppController.triggerNativeMethod(action, json);
    }
  }

  Future<User?> fetchUser(String email) async {
    final response =
        await http.get(Uri.parse('https://gorest.co.in/public/v2/users'));

    if (response.statusCode == 200) {
      List arrUsers = jsonDecode(response.body) ?? [];
      for (var value in arrUsers) {
        final user = User.fromJson(value);
        if (user.email?.toLowerCase() == email.toLowerCase()) {
          return user;
        }
      }
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
    return null;
  }
}
