import 'package:pigeon/pigeon.dart';

class User {
  int? id;
  String? email;
  String? name;
  String? gender;
  String? status;

  User(this.id, this.email, this.name, this.gender, this.status);
}

@HostApi()
abstract class Login {
  void loginSuccess(User user);
  void loginFailed(String message);
  void validateCredential(bool isValid);
}

@HostApi()
abstract class Splash {  
  void onAuthStatusChange(bool isLogin);
}

// @FlutterApi()
// abstract class UserAuthenticationFlutter {
//   void doLogin(String email, String password);  
// }
