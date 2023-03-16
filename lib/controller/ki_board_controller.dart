import 'dart:math';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:little_flower_app/model/ki_board.dart';
import 'package:little_flower_app/service/ki_board_service.dart';

@Injectable()
class KiBoardController extends ChangeNotifier {
  final KiBoardService _kiBoardService;

  List<KiBoard> _boards = [];
  late KiBoard _board;

  KiBoardController({
    required KiBoardService kiBoardService,
  }) : _kiBoardService = kiBoardService;

  List<String> get boardIds => _boards.map((board) => board.boardId).toList();

  KiBoard get board => _board;

  Future removeCurrentBoard() async {
    await _kiBoardService.removeBoard(_board.boardId);
    _boards = await _kiBoardService.getAllBoards();
    if (_boards.isNotEmpty) {
      _board = _boards.first;
      notifyListeners();
      return;
    }

    await createBoard();
    notifyListeners();
  }

  Future createBoard() async {
    var boardId = await _kiBoardService.createNewBoard();
    _board = (await _kiBoardService.getBoard(boardId))!;
    _boards = await _kiBoardService.getAllBoards();
    notifyListeners();
  }

  Future resetKiBoard() async {
    await _kiBoardService.resetKiBoard(_board.boardId);
    _board = (await _kiBoardService.getBoard(_board.boardId))!;
    _boards = await _kiBoardService.getAllBoards();
    notifyListeners();
  }

  Future changeKiBoard(String boardId) async {
    _board = _boards.firstWhere((board) => board.boardId == boardId);
    notifyListeners();
  }

  void addKi(Point<int> point) {
    _board.addKi(point);
    _kiBoardService.saveBoard(_board.boardId, _board);
    notifyListeners();
  }
}
