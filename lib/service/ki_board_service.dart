import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:little_flower_app/model/ki_board.dart';
import 'package:little_flower_app/repository/ki_board_repository.dart';
import 'package:random_string/random_string.dart';

@Injectable()
class KiBoardService {
  KiBoardRepository _localRepository;

  KiBoardService(KiBoardRepository repository)
      : _localRepository = repository;

  Future resetKiBoard(String boardId) async {
    await _createBoard(boardId);
  }

  Future<String> createNewBoard() async {
    var boardId = randomAlpha(5);
    await _createBoard(boardId);
    return boardId;
  }

  Future _createBoard(String boardId) async {
    var board = KiBoard(boardId: boardId);
    await saveBoard(board.boardId, board);
  }

  Future saveBoard(String boardId, KiBoard kiBoard) async {
    await _localRepository.saveKiBoard(boardId, kiBoard);
  }

  Future removeCurrentBoard(String boardId) async {
    await _localRepository.remove(boardId);
  }

  Future<KiBoard?> getBoard(String boardId) async {
    return await _localRepository.getKiBoard(boardId);
  }

  Future<List<KiBoard>> getAllBoards() async {
    return await _localRepository.getAllBoards();
  }
}
