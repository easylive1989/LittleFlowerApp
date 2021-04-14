import 'dart:convert';

import 'package:little_flower_app/IKiBoardRepository.dart';
import 'package:little_flower_app/ki_board.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceApi implements IKiBoardRepository {
  void saveKiBoard(String id, KiBoard kiBoard) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(id, jsonEncode(kiBoard.toJson()));
  }

  Future<KiBoard> getKiBoard(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.get(id);
    if (data == null) {
      return KiBoard();
    }
    return KiBoard.fromJson(jsonDecode(data));
  }
}
