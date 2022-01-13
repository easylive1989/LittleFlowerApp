import 'dart:async';
import 'dart:math';

import 'package:injectable/injectable.dart';
import 'package:little_flower_app/model/ki_board.dart';
import 'package:little_flower_app/repository/ki_board_repository.dart';
import 'package:little_flower_app/repository/ki_board_repository_factory.dart';
import 'package:random_string/random_string.dart';

@Injectable()
class KiBoardService {
  KiBoard get board => _board;

  late KiBoard _board = KiBoard(boardId: "not exist");

  KiBoardRepository _localRepository;

  KiBoardService(KiBoardRepositoryFactory kiBoardRepositoryFactory)
      : _localRepository = kiBoardRepositoryFactory.local();

  Future resetKiBoard() async {
    _createNewBoard(getBoardId());
  }

  void _createNewBoard(String boardId) {
    _board = KiBoard(boardId: boardId);
    _saveBoard(_board.boardId, _board);
  }

  Future addKi(Point<int> point) async {
    _board.addKi(point);
    await _saveBoard(_board.boardId, _board);
  }

  Future _saveBoard(String boardId, KiBoard kiBoard) async {
    await _localRepository.saveKiBoard(boardId, kiBoard);
  }

  String getBoardId() {
    return randomAlpha(5);
  }

  Future removeCurrentBoard(String boardId) async {
    await _localRepository.remove(_board.boardId);
  }

  Future changeKiBoard(String boardId) async {
    var board = await _localRepository.getKiBoard(boardId);
    if (board == null) {
      _createNewBoard(boardId);
    } else {
      _board = board;
    }
  }
}
