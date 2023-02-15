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

@FlutterApi()
abstract class LoginInteractor {
  void doLogin(String email, String password);
  void validateCredential(String email, String password);
}
