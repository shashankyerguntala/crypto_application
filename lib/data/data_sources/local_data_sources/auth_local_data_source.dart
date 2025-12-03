import 'package:hive_flutter/hive_flutter.dart';

class AuthLocalDataSource {
  final Box usersBox = Hive.box('usersBox');

  Future<void> saveUser(String email, String password) async {
    await usersBox.put(email, password);
  }

  String? getUserPassword(String email) {
    return usersBox.get(email);
  }
}
