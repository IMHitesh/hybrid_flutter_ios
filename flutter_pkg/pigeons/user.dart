import 'package:pigeon/pigeon.dart';

class User {
  String? email;
  String? name;

  User(this.email, this.name);
}

@HostApi()
abstract class UserAuthentication {
  void loginSuccess(User user);
  void loginFailed(String message);
}
