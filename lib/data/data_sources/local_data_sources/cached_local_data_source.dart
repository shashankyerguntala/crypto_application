import 'package:hive_flutter/hive_flutter.dart';
import 'package:final_l3/data/models/crypto_model.dart';

class CacheLocalDataSource {
  final Box cacheBox = Hive.box('cacheBox');

  Future<void> saveCoinCache(List<CryptoModel> coins) async {
    final jsonList = coins.map((coin) => coin.toJson()).toList();
    await cacheBox.put('coin', jsonList);
  }

  List<CryptoModel>? getCoinCache() {
    final data = cacheBox.get('coin');
    if (data == null) {
      return null;
    }

    final list = data as List;
    return list
        .map((e) => CryptoModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }
}
