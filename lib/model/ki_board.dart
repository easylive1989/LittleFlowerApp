import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:little_flower_app/model/game_over_checker.dart';
import 'package:little_flower_app/model/ki.dart';

import 'game_visibility.dart';

class KiBoard {
  static int row = 15;
  static int column = 15;

  List<Point<int>> _blackKiList = [];
  List<Point<int>> _whiteKiList = [];

  List<Point<int>> get blackKiList => List.from(_blackKiList);

  List<Point<int>> get whiteKiList => List.from(_whiteKiList);

  GameVisibility gameVisibility = GameVisibility.private;

  KiBoard();

  KiBoard._(
    List<Point<int>> blackKiList,
    List<Point<int>> whiteKiList,
    GameVisibility gameVisibility,
  ) {
    _blackKiList.addAll(blackKiList);
    _whiteKiList.addAll(whiteKiList);
    this.gameVisibility = gameVisibility;
  }

  Ki get winner =>
      _blackKiList.length > _whiteKiList.length ? Ki.black : Ki.white;

  void addKi(Point<int> point) {
    if (_blackKiList.contains(point) ||
        _whiteKiList.contains(point) ||
        isGameOver()) {
      return;
    }

    _getKiList(_getKi()).add(point);
  }

  bool isGameOver() {
    if (blackKiList.isEmpty && whiteKiList.isEmpty) {
      return false;
    }

    if (blackKiList.length == whiteKiList.length) {
      return GameOverChecker(whiteKiList, row, column)
          .isGameOver(whiteKiList.last);
    } else {
      return GameOverChecker(blackKiList, row, column)
          .isGameOver(blackKiList.last);
    }
  }

  void cleanUp() {
    _blackKiList.clear();
    _whiteKiList.clear();
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
      "gameVisibility": gameVisibility,
    };
  }

  @override
  bool operator ==(Object other) {
    return other is KiBoard &&
        listEquals(blackKiList, other.blackKiList) &&
        listEquals(whiteKiList, other.whiteKiList);
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
      json["gameVisibility"],
    );
  }
}
