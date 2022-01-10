import 'dart:async';
import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:little_flower_app/model/ki_board.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ki_board_repository.dart';

@Injectable()
class PreferenceApi implements KiBoardRepository {
  Future saveKiBoard(String id, KiBoard kiBoard) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(id, jsonEncode(kiBoard.toJson()));
  }

  Future<KiBoard?> getKiBoard(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.get(id);
    if (data == null) {
      return null;
    }
    return KiBoard.fromJson(jsonDecode(data.toString()));
  }

  @override
  Future<List<String>> getBoardIds() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getKeys().toList();
  }

  @override
  Future remove(String boardId) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.remove(boardId);
  }
}
