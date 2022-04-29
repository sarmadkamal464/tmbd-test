import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  static const _storage =  FlutterSecureStorage();
  static const String _selectedFav = 'selected fav';


  static Future setFavorites(List<int> favorites) async {
    final value = json.encode(favorites);

    await _storage.write(key: _selectedFav, value: value);
  }

  static Future<List<int>> getFavorites() async {
    final value = await _storage.read(key: _selectedFav);

    return value == null ? null : List<int>.from(json.decode(value));
  }

  static void clearSelectedFav() async {
    await _storage.delete(key: _selectedFav);
  }

}
