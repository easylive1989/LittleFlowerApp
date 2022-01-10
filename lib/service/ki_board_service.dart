import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:little_flower_app/model/ki_board.dart';
import 'package:little_flower_app/repository/ki_board_repository.dart';
import 'package:little_flower_app/repository/ki_board_repository_factory.dart';
import 'package:random_string/random_string.dart';

@Injectable()
class KiBoardService extends ChangeNotifier {
  KiBoard get board => _board;

  Future<List<String>> get allOtherBoardIds async =>
      (await _getBoardIdList()).where((id) => id != _board.boardId).toList();

  Future<List<String>> get allBoardIds async => await _getBoardIdList();

  late KiBoard _board = KiBoard(boardId: "not exist");

  KiBoardRepository _localRepository;

  KiBoardService(KiBoardRepositoryFactory kiBoardRepositoryFactory)
      : _localRepository = kiBoardRepositoryFactory.local();

  Future<List<String>> _getBoardIdList() async {
    return await _localRepository.getBoardIds();
  }

  Future resetKiBoard({boardId}) async {
    if (boardId == null) {
      _createNewBoard(boardId);
      notifyListeners();
      return;
    }
    var board = await _localRepository.getKiBoard(boardId);
    if (board == null) {
      _createNewBoard(boardId);
    } else {
      _board = board;
    }
    notifyListeners();
  }

  void _createNewBoard(boardId) {
    _board = KiBoard(boardId: boardId ?? getBoardId());
    _saveBoard(_board.boardId, _board);
  }

  Future addKi(Point<int> point) async {
    _board.addKi(point);
    await _saveBoard(_board.boardId, _board);
    notifyListeners();
  }

  Future _saveBoard(String boardId, KiBoard kiBoard) async {
    await _localRepository.saveKiBoard(boardId, kiBoard);
  }

  String getBoardId() {
    return randomAlpha(5);
  }

  Future removeCurrentBoard() async {
    await _localRepository.remove(_board.boardId);
    var boardIdList = await _getBoardIdList();
    await resetKiBoard(
      boardId: boardIdList.isNotEmpty ? boardIdList.first : null,
    );
  }
}
