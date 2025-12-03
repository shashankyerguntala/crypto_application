import 'package:final_l3/data/models/crypto_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavouriteLocalDataSource {
  final Box favouritesBox = Hive.box('favouritesBox');

  Future<void> saveFavourites(List<CryptoModel> coins) async {
    final jsonList = coins.map((c) => c.toJson()).toList();
    await favouritesBox.put('favourites', jsonList);
  }

  List<CryptoModel> getFavourites() {
    final raw = favouritesBox.get('favourites', defaultValue: []);
    if (raw is! List) {
      return [];
    }

    return raw
        .map((item) => CryptoModel.fromJson(Map<String, dynamic>.from(item)))
        .toList();
  }
}
