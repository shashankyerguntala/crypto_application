import 'package:final_l3/data/models/crypto_model.dart';

abstract class HiveRepository {
  Future<void> saveUser(String email, String password);
  String? getUserPassword(String email);

  Future<void> setCurrentUser(String email);
  String? getCurrentUser();

  Future<void> saveFavourites(String email, List<CryptoModel> coins);
  List<CryptoModel> getFavourites(String email);

  Future<void> saveCoinCache(List<CryptoModel> coins);
  List<CryptoModel>? getCoinCache();

  Future<void> saveIsDark({required bool isDark});
  bool getIsDark();

  Future<void> clearCurrentUser();
}
