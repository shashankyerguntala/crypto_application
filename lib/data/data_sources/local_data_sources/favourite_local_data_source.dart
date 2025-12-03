import 'package:hive_flutter/hive_flutter.dart';

class FavouriteLocalDataSource {
  final Box favouritesBox = Hive.box('favouritesBox');

  Future<void> saveFavourites(List<String> ids) async {
    await favouritesBox.put('coinIds', ids);
  }

  List<String> getFavourites() {
    final raw = favouritesBox.get('coinIds', defaultValue: <String>[]);
    return List<String>.from(raw);
  }
}
