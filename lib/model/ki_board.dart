import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:little_flower_app/model/game_over_checker.dart';
import 'package:little_flower_app/model/ki.dart';

class KiBoard {
  static int row = 15;
  static int column = 15;

  List<Point<int>> _blackKiList = [];
  List<Point<int>> _whiteKiList = [];
  List<Point<int>> get blackKiList => List.from(_blackKiList);
  List<Point<int>> get whiteKiList => List.from(_whiteKiList);

  bool _isGameOver = false;
  bool get isGameOver => _isGameOver;

  KiBoard();

  KiBoard._(
    List<Point<int>> blackKiList,
    List<Point<int>> whiteKiList,
    bool isGameOver,
  ) {
    _blackKiList.addAll(blackKiList);
    _whiteKiList.addAll(whiteKiList);
    _isGameOver = isGameOver;
  }

  Ki get winner =>
      _blackKiList.length > _whiteKiList.length ? Ki.black : Ki.white;

  void addKi(Point<int> point) {
    if (_blackKiList.contains(point) ||
        _whiteKiList.contains(point) ||
        _isGameOver) {
      return;
    }

    var kiList = _getKiList(_getKi())..add(point);

    _isGameOver = GameOverChecker(kiList, row, column).isGameOver(point);
  }

  void cleanUp() {
    _blackKiList.clear();
    _whiteKiList.clear();
    _isGameOver = false;
  }

  Ki _getKi() {
    return (_blackKiList.length + _whiteKiList.length) % 2 == 0
        ? Ki.black
        : Ki.white;
  }

  List<Point<int>> _getKiList(Ki ki) =>
      ki == Ki.black ? _blackKiList : _whiteKiList;

  Map<String, dynamic> toJson() {
    var pointToJson = (point) => {"x": point.x, "y": point.y};
    return {
      "blackKiList": _blackKiList.map((point) => pointToJson(point)).toList(),
      "whiteKiList": _whiteKiList.map((point) => pointToJson(point)).toList(),
      "isGameOver": _isGameOver,
    };
  }

  @override
  bool operator ==(Object other) {
    return other is KiBoard &&
        listEquals(blackKiList, other.blackKiList) &&
        listEquals(whiteKiList, other.whiteKiList) &&
        isGameOver == other.isGameOver &&
        winner == other.winner;
  }

  @override
  int get hashCode {
    return 0;
  }

  factory KiBoard.fromJson(Map<String, dynamic> json) {
    var toPointList = (json) => List<Point<int>>.from(json.map((e) =>
        Point<int>(
            int.parse(e["x"].toString()), int.parse(e["y"].toString()))));
    return KiBoard._(
      toPointList(json["blackKiList"]),
      toPointList(json["whiteKiList"]),
      json["isGameOver"],
    );
  }
}
