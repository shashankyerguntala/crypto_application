import 'package:final_l3/data/models/crypto_model.dart';
import 'package:final_l3/domain/repository/hive_repository.dart';

class HiveUseCase {
  final HiveRepository repo;

  HiveUseCase(this.repo);

  Future<void> saveUser(String email, String pass) =>
      repo.saveUser(email, pass);

  String? getUserPassword(String email) => repo.getUserPassword(email);

  Future<void> setCurrentUser(String email) => repo.setCurrentUser(email);

  String? getCurrentUser() => repo.getCurrentUser();

  Future<void> saveFavourites(String email, List<CryptoModel> coins) =>
      repo.saveFavourites(email, coins);

  List<CryptoModel> getFavourites(String email) => repo.getFavourites(email);

  Future<void> saveMarketCache(List<CryptoModel> coins) =>
      repo.saveCoinCache(coins);

  List<CryptoModel>? getMarketCache() => repo.getCoinCache();

  Future<void> saveTheme({required bool isDark}) =>
      repo.saveIsDark(isDark: isDark);

  bool getTheme() => repo.getIsDark();

  Future<void> clearCurrentUser() => repo.clearCurrentUser();
}
