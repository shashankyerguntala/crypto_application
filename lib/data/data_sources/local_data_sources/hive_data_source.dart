import 'package:hive_flutter/hive_flutter.dart';
import 'package:final_l3/data/models/crypto_model.dart';

class HiveLocalService {
  final Box usersBox = Hive.box('usersBox');
  final Box favouritesBox = Hive.box('favouritesBox');
  final Box cacheBox = Hive.box('cacheBox');
  final Box settingsBox = Hive.box('settingsBox');

  Future<void> saveUser(String email, String password) async {
    await usersBox.put(email, password);
  }

  String? getUserPassword(String email) {
    return usersBox.get(email) as String?;
  }

  Future<void> saveFavourites(List<String> coinIds) async {
    await favouritesBox.put('coinIds', coinIds);
  }

  List<String> getFavourites() {
    final list = favouritesBox.get('coinIds', defaultValue: <String>[]) as List;
    return List<String>.from(list);
  }

  Future<void> saveCoinCache(List<CryptoModel> coins) async {
    final jsonList = coins.map((c) => c.toJson()).toList();
    await cacheBox.put('market', jsonList);
  }

  List<CryptoModel>? getMarketCache() {
    final data = cacheBox.get('market');
    if (data == null) {
      return null;
    }

    final list = data as List;
    return list
        .map((e) => CryptoModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<void> saveIsDarkTheme({required bool isDark}) async {
    await settingsBox.put('isDarkTheme', isDark);
  }

  bool getIsDarkTheme() {
    return settingsBox.get('isDarkTheme', defaultValue: false) as bool;
  }
}
