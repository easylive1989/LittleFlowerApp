import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:little_flower_app/model/ki_board.dart';
import 'package:little_flower_app/repository/ki_board_repository.dart';
import 'package:random_string/random_string.dart';

final boardIdsProvider =
    StateNotifierProvider<BoardIdsState, List<String>>((ref) {
  return BoardIdsState(ref);
});

class BoardIdsState extends StateNotifier<List<String>> {
  final Ref ref;

  BoardIdsState(this.ref) : super([]) {
    loadBoards();
  }

  Future<void> loadBoards() async {
    state = await _repository.getAllBoardIds();
    if (state.isEmpty) {
      await createBoard();
    }
  }

  Future<String> createBoard() async {
    var boardId = randomAlpha(5);
    var board = KiBoard(boardId: boardId);
    await _repository.saveKiBoard(boardId, board);
    await loadBoards();
    return boardId;
  }

  Future<void> removeCurrentBoard(String boardId) async {
    await _repository.remove(boardId);
    await loadBoards();
  }

  KiBoardRepository get _repository => ref.read(kiBoardRepositoryProvider);
}
