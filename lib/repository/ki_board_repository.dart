import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:little_flower_app/model/ki_board.dart';
import 'package:shared_preferences/shared_preferences.dart';

final kiBoardRepositoryProvider = Provider<KiBoardRepository>((ref){
  return KiBoardRepository();
}) ;

@Injectable()
class KiBoardRepository {
  Future saveKiBoard(KiBoard kiBoard) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(kiBoard.boardId, jsonEncode(kiBoard.toJson()));
  }

  Future<KiBoard?> getKiBoard(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.get(id);
    if (data == null) {
      return null;
    }
    return KiBoard.fromJson(jsonDecode(data.toString()));
  }

  Future<List<String>> getAllBoardIds() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getKeys().toList();
  }

  Future remove(String boardId) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.remove(boardId);
  }
}
