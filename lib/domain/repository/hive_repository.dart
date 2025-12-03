import 'package:final_l3/data/models/crypto_model.dart';

abstract class HiveRepository {
  Future<void> saveUser(String email, String password);
  String? getUserPassword(String email);

  Future<void> saveFavourites(List<CryptoModel> coins);
  List<CryptoModel> getFavourites();

  Future<void> saveMarketCache(List<CryptoModel> coins);
  List<CryptoModel>? getMarketCache();

  Future<void> saveIsDark({required bool isDark});
  bool getIsDark();
}
