import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:little_flower_app/game_over_checker.dart';
import 'package:little_flower_app/ki.dart';

class KiBoard extends ChangeNotifier {
  static int row = 15;
  static int column = 15;

  final String boardId;

  List<Point<int>> _blackKiList = [];
  List<Point<int>> _whiteKiList = [];
  bool _isGameOver = false;

  Ki _winner = Ki.black;

  KiBoard(this.boardId);

  List<Point<int>> get blackKiList => List.from(_blackKiList);

  List<Point<int>> get whiteKiList => List.from(_whiteKiList);

  bool get isGameOver => _isGameOver;

  String get winnerKi => _winner.toString().split(".").last.toUpperCase();

  void addKi(Point<int> point) {
    if (_blackKiList.contains(point) ||
        _whiteKiList.contains(point) ||
        _isGameOver) {
      return;
    }

    var ki = _getKi();
    _getKiList(ki).add(point);

    _isGameOver =
        GameOverChecker(_getKiList(ki), row, column).isGameOver(point);
    if (_isGameOver) {
      _winner = ki;
    }

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

  List<Point<int>> _getKiList(Ki ki) =>
      ki == Ki.black ? _blackKiList : _whiteKiList;

  Map<String, dynamic> toJson() {
    var pointToJson = (point) => {"x": point.x, "y": point.y};
    return {
      'blackKiList': _blackKiList.map((point) => pointToJson(point)).toList(),
      'whiteKiList': _whiteKiList.map((point) => pointToJson(point)).toList(),
      'isGameOver': _isGameOver,
      'winner': _winner.index
    };
  }

  @override
  bool operator ==(Object other) {
    return other is KiBoard &&
        boardId == other.boardId &&
        listEquals(blackKiList, other.blackKiList) &&
        listEquals(whiteKiList, other.whiteKiList) &&
        isGameOver == other.isGameOver &&
        winnerKi == other.winnerKi;
  }

  @override
  int get hashCode {
    return 0;
  }
}
