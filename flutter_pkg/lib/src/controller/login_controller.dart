import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class LoginController extends LoginInteractor {
  String enteredEmail = "";
  String enteredPassword = "";
  final login = Login();

  LoginController() {
    LoginInteractor.setup(this);
  }

  @override
  void doLogin(String email, String password) async {
    final user = await fetchUser(enteredEmail);
    if (user != null) {
      final pref = await SharedPreferences.getInstance();
      pref.setBool("is_login", true);
      login.loginSuccess(user);
    } else {
      const message =
          "Unable to login with given credential. Please make sure you've entered correct username and password";
      login.loginFailed(message);
    }
    return null;
  }

  @override
  void validateCredential(String email, String password) {
    bool isValid = false;
    if (email.isNotEmpty && password.isNotEmpty) {
      enteredEmail = email;
      enteredPassword = password;
      isValid = true;
    }
    login.validateCredential(isValid);
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
