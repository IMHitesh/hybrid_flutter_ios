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
abstract class Dashboard {
  void onLogout(bool isLogout, String message);  
  void onUserFetch(List<User>? users, String message);
}