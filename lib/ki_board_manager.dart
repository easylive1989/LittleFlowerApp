import 'package:flutter/cupertino.dart';
import 'package:little_flower_app/ki_board.dart';
import 'package:random_string/random_string.dart';

class KiBoardManager extends ChangeNotifier {
  KiBoard _current;

  KiBoard get current => _current;

  KiBoardManager() {
    updateKiBoard(KiBoard(getBoardId()));
  }

  void updateKiBoard(KiBoard kiBoard) {
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
