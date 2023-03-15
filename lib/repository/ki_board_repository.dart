import 'dart:async';
import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:little_flower_app/model/ki_board.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Injectable()
class KiBoardRepository {
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

  Future<List<KiBoard>> getAllBoards() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return [for (final id in prefs.getKeys()) (await getKiBoard(id))!];
  }

  Future remove(String boardId) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.remove(boardId);
  }
}
