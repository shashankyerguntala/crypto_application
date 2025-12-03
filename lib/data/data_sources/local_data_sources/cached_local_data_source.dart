import 'package:hive_flutter/hive_flutter.dart';
import 'package:final_l3/data/models/crypto_model.dart';

class CacheLocalDataSource {
  final Box cacheBox = Hive.box('cacheBox');

  Future<void> saveMarketCache(List<CryptoModel> coins) async {
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
}
