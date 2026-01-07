import 'package:super_quest/data/datasource/local_game_save_data_source.dart';
import 'package:super_quest/data/models/game_save.dart';

class GameSaveRepository {
  final LocalGameSaveDataSource local;

  GameSaveRepository(this.local);

  Future<void> save(GameSave progress) async {
    await local.save(progress);
  }

  Future<GameSave?> load() async {
    return await local.load();
  }

  Future<void> clear() async {
    await local.clear();
  }
}
