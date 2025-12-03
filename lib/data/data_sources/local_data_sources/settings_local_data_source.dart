import 'package:hive_flutter/hive_flutter.dart';

class SettingsLocalDataSource {
  final Box settingsBox = Hive.box('settingsBox');

  Future<void> saveIsDarkTheme({required bool isDark}) async {
    await settingsBox.put('isDarkTheme', isDark);
  }

  bool getIsDarkTheme() {
    return settingsBox.get('isDarkTheme', defaultValue: false);
  }
}
