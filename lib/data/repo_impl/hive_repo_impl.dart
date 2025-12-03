import 'package:final_l3/data/data_sources/local_data_sources/auth_local_data_source.dart';
import 'package:final_l3/data/data_sources/local_data_sources/cached_local_data_source.dart';
import 'package:final_l3/data/data_sources/local_data_sources/favourite_local_data_source.dart';
import 'package:final_l3/data/data_sources/local_data_sources/settings_local_data_source.dart';
import 'package:final_l3/data/models/crypto_model.dart';
import 'package:final_l3/domain/repository/hive_repository.dart';

class HiveRepositoryImpl implements HiveRepository {
  final AuthLocalDataSource auth;
  final FavouriteLocalDataSource favourites;
  final CacheLocalDataSource cache;
  final SettingsLocalDataSource settings;

  HiveRepositoryImpl({
    required this.auth,
    required this.favourites,
    required this.cache,
    required this.settings,
  });

  @override
  Future<void> saveUser(String email, String password) {
    return auth.saveUser(email, password);
  }

  @override
  String? getUserPassword(String email) {
    return auth.getUserPassword(email);
  }

  @override
  Future<void> saveFavourites(List<CryptoModel> coins) {
    return favourites.saveFavourites(coins);
  }

  @override
  List<CryptoModel> getFavourites() {
    return favourites.getFavourites();
  }

  @override
  Future<void> saveMarketCache(List<CryptoModel> coins) {
    return cache.saveCoinCache(coins);
  }

  @override
  List<CryptoModel>? getMarketCache() {
    return cache.getCoinCache();
  }

  @override
  bool getIsDark() {
    return settings.getIsDarkTheme();
  }

  @override
  Future<void> saveIsDark({required bool isDark}) {
    return settings.saveIsDarkTheme(isDark: isDark);
  }
}
