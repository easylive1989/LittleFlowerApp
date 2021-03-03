import 'dart:math';

import 'package:flutter/material.dart';
import 'package:little_flower_app/ki.dart';

class KiBoardModel extends ChangeNotifier {
  List<Point<int>> _blackKiList = [];
  List<Point<int>> _whiteKiList = [];
  bool _isGameOver = false;

  List<Point<int>> get blackKiList => List.from(_blackKiList);
  List<Point<int>> get whiteKiList => List.from(_whiteKiList);
  bool get isGameOver => _isGameOver;

  void addKi(Point<int> point) {
    if (_blackKiList.contains(point) ||
        _whiteKiList.contains(point) ||
        _isGameOver) {
      return;
    }
    var ki = _getKi();
    if (ki == Ki.black) {
      _blackKiList.add(point);
    }
    if (ki == Ki.white) {
      _whiteKiList.add(point);
    }

    _isGameOver = _checkGameOver(ki, point);
    notifyListeners();
  }

  void cleanUp() {
    _blackKiList.clear();
    _whiteKiList.clear();
    _isGameOver = false;
    notifyListeners();
  }

  Ki _getKi() {
    return (_blackKiList.length + _whiteKiList.length) % 2 == 0
        ? Ki.black
        : Ki.white;
  }

  bool _checkGameOver(Ki ki, Point lastMove) {
    var verticalCount = _verify(
        ki,
        lastMove,
        (point) => Point(point.x + 1, point.y),
        (point) => Point(point.x - 1, point.y));
    if (verticalCount >= 5) {
      return true;
    }

    var horizontalCount = _verify(
        ki,
        lastMove,
        (point) => Point(point.x, point.y + 1),
        (point) => Point(point.x, point.y - 1));
    if (horizontalCount >= 5) {
      return true;
    }

    var slopeCount = _verify(
        ki,
        lastMove,
        (point) => Point(point.x + 1, point.y + 1),
        (point) => Point(point.x - 1, point.y - 1));
    if (slopeCount >= 5) {
      return true;
    }

    var antiSlopeCount = _verify(
        ki,
        lastMove,
        (point) => Point(point.x + 1, point.y - 1),
        (point) => Point(point.x - 1, point.y + 1));
    if (antiSlopeCount >= 5) {
      return true;
    }
    return false;
  }

  int _verify(Ki ki, Point point, Point Function(Point) nextPositiveFn,
      Point Function(Point) nextNegativeFn) {
    if (point.x < 0 || point.y < 0 || point.x > 15 || point.y > 15) {
      return 0;
    }

    var kiList = ki == Ki.black ? blackKiList : whiteKiList;
    if (kiList.contains(point)) {
      print("check ${point.x}, ${point.y}");
      return 1 +
          (nextPositiveFn == null
              ? 0
              : _verify(ki, nextPositiveFn(point), nextPositiveFn, null)) +
          (nextNegativeFn == null
              ? 0
              : _verify(ki, nextNegativeFn(point), null, nextNegativeFn));
    } else {
      return 0;
    }
  }
}
