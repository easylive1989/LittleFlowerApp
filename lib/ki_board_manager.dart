import 'package:flutter/material.dart';
import 'package:little_flower_app/ki_board.dart';
import 'package:random_string/random_string.dart';

class KiBoardManager extends ChangeNotifier {
  KiBoard _current;
  KiBoard get current => _current;

  String _boardId;
  String get boardId => _boardId;

  KiBoardManager() {
    updateKiBoard(getBoardId(), KiBoard());
  }

  void updateKiBoard(String boardId, KiBoard kiBoard) {
    _boardId = boardId;
    _current?.removeListener(notify);
    _current = kiBoard..addListener(notify);
  }

  void notify() {
    notifyListeners();
  }

  String getBoardId() {
    return randomAlpha(5);
  }
}
