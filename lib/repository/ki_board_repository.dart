import 'dart:async';
import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:little_flower_app/entity/ki_board.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Injectable()
class KiBoardRepository {
  final SharedPreferences _prefs;

  KiBoardRepository({
    required SharedPreferences sharedPreferences,
  }) : _prefs = sharedPreferences;

  Future saveKiBoard(String id, KiBoard kiBoard) async {
    await _prefs.setString(id, jsonEncode(kiBoard.toJson()));
  }

  Future<KiBoard?> getKiBoard(String id, {int? gg}) async {
    var data = _prefs.get(id);
    if (data == null) {
      return null;
    }
    return KiBoard.fromJson(jsonDecode(data.toString()));
  }

  Future<List<String>> getBoardIds() async {
    return _prefs.getKeys().toList();
  }

  Future remove(String boardId) async {
    _prefs.remove(boardId);
  }
}
