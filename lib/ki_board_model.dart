import 'dart:math';

import 'package:flutter/material.dart';
import 'package:little_flower_app/ki.dart';

class KiBoardModel extends ChangeNotifier {
  List<Point<int>> _blackKiList = [];
  List<Point<int>> _whiteKiList = [];

  List<Point<int>> get blackKiList => List.from(_blackKiList);
  List<Point<int>> get whiteKiList => List.from(_whiteKiList);

  void addKi(Point<int> point) {
    if (_blackKiList.contains(point) || _whiteKiList.contains(point)) {
      return;
    }
    var ki = (_blackKiList.length + _whiteKiList.length) % 2 == 0
        ? Ki.black
        : Ki.white;
    if (ki == Ki.black) {
      _blackKiList.add(point);
    }
    if (ki == Ki.white) {
      _whiteKiList.add(point);
    }
    notifyListeners();
  }
}
