import 'dart:math';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:little_flower_app/service/board_list_service.dart';
import 'package:little_flower_app/service/ki_board_service.dart';

@Injectable()
class KiBoardController extends ChangeNotifier {
  final KiBoardService _kiBoardService;
  final BoardListService _boardListService;

  KiBoardController({
    required BoardListService boardListService,
    required KiBoardService kiBoardService,
  })  : _kiBoardService = kiBoardService,
        _boardListService = boardListService;

  String get boardId => _kiBoardService.board.boardId;

  Future<List<String>> get allBoardId => _boardListService.allBoardIds;

  get board => _kiBoardService.board;

  Future removeCurrentBoard(String boardId) async {
    await _kiBoardService.removeCurrentBoard(boardId);
    var boardIdList = await _boardListService.allBoardIds;
    if (boardIdList.isNotEmpty) {
      await _kiBoardService.changeKiBoard(boardIdList.first);
    } else {
      await _kiBoardService.createNewBoard();
    }
    notifyListeners();
  }

  Future createBoard() async {
    await _kiBoardService.createNewBoard();
    notifyListeners();
  }

  Future resetKiBoard() async {
    await _kiBoardService.resetKiBoard();
    notifyListeners();
  }

  Future changeKiBoard(String boardId) async {
    await _kiBoardService.changeKiBoard(boardId);
    notifyListeners();
  }

  void addKi(Point<int> point) {
    _kiBoardService.addKi(point);
    notifyListeners();
  }
}
