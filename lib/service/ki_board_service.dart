import 'dart:async';
import 'dart:math';

import 'package:injectable/injectable.dart';
import 'package:little_flower_app/model/ki_board.dart';
import 'package:little_flower_app/repository/ki_board_repository.dart';
import 'package:random_string/random_string.dart';

@Injectable()
class KiBoardService {
  KiBoard get board => _board;

  late KiBoard _board = KiBoard(boardId: "not exist");

  KiBoardRepository _kiBoardRepository;

  KiBoardService(KiBoardRepository kiBoardRepositoryFactory)
      : _kiBoardRepository = kiBoardRepositoryFactory;

  Future resetKiBoard() async {
    await _createBoard(_board.boardId);
  }

  Future createNewBoard() async {
    await _createBoard(randomAlpha(5));
  }

  Future _createBoard(String boardId) async {
    _board = KiBoard(boardId: boardId);
    await _saveBoard(_board.boardId, _board);
  }

  Future addKi(Point<int> point) async {
    _board.addKi(point);
    await _saveBoard(_board.boardId, _board);
  }

  Future _saveBoard(String boardId, KiBoard kiBoard) async {
    await _kiBoardRepository.saveKiBoard(boardId, kiBoard);
  }

  Future removeCurrentBoard(String boardId) async {
    await _kiBoardRepository.remove(_board.boardId);
  }

  Future changeKiBoard(String boardId) async {
    var board = await _kiBoardRepository.getKiBoard(boardId);
    if (board == null) {
      _createBoard(boardId);
    } else {
      _board = board;
    }
  }
}
