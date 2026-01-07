import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_quest/data/models/game_save.dart';

class LocalGameSaveDataSource {
  static const _key = 'game_save';

  Future<void> save(GameSave progress) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _key,
      jsonEncode(progress.toJson()),
    );
  }

  Future<GameSave?> load() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);

    if (jsonString == null) return null;

    return GameSave.fromJson(
      jsonDecode(jsonString),
    );
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
