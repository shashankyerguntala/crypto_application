import 'package:final_l3/data/models/crypto_model.dart';
import 'package:final_l3/domain/repository/hive_repository.dart';

class HiveUseCase {
  final HiveRepository repo;

  HiveUseCase(this.repo);

  Future<void> saveUser(String email, String pass) =>
      repo.saveUser(email, pass);

  String? getUserPassword(String email) => repo.getUserPassword(email);

  Future<void> saveFavourites(List<CryptoModel> coins) =>
      repo.saveFavourites(coins);

  List<CryptoModel> getFavourites() => repo.getFavourites();

  Future<void> saveMarketCache(List<CryptoModel> coins) =>
      repo.saveMarketCache(coins);

  List<CryptoModel>? getMarketCache() => repo.getMarketCache();

  Future<void> saveTheme({required bool isDark}) =>
      repo.saveIsDark(isDark: isDark);

  bool getTheme() => repo.getIsDark();
}
