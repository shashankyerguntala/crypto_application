import 'package:hive_flutter/hive_flutter.dart';

class AuthLocalDataSource {
  final Box usersBox = Hive.box('usersBox');

  Future<void> saveUser(String email, String password) async {
    await usersBox.put(email, password);
  }

  String? getUserPassword(String email) {
    return usersBox.get(email);
  }

  Future<void> setCurrentUser(String email) async {
    await usersBox.put('currentUser', email);
  }

  String? getCurrentUser() {
    return usersBox.get('currentUser');
  }

  Future<void> clearCurrentUser() async {
    await usersBox.delete('currentUser');
  }
}
