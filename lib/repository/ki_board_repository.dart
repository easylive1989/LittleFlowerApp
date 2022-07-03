import 'dart:async';
import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:little_flower_app/entity/ki_board.dart';
import 'package:little_flower_app/repository/shared_preference_access_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Injectable()
class KiBoardRepository {
  final SharedPreferences _prefs;

  KiBoardRepository({
    required SharedPreferences sharedPreferences,
  }) : _prefs = sharedPreferences;

  Future saveKiBoard(String id, KiBoard kiBoard) async {
    try {
      await _prefs.setString(id, jsonEncode(kiBoard.toJson()));
    } catch (e) {
      throw SharedPreferenceAccessException();
    }
  }

  Future<KiBoard?> getKiBoard(String id) async {
    try {
      var data = _prefs.get(id);
      if (data == null) {
        return null;
      }
      return KiBoard.fromJson(jsonDecode(data.toString()));
    } catch (e) {
      throw SharedPreferenceAccessException();
    }
  }

  Future<List<String>> getBoardIds() async {
    return _prefs.getKeys().toList();
  }

  Future remove(String boardId) async {
    _prefs.remove(boardId);
  }
}
