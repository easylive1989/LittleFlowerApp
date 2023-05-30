import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:little_flower_app/model/ki_board.dart';
import 'package:little_flower_app/repository/ki_board_repository.dart';
import 'package:random_string/random_string.dart';

final kiBoardsProvider =
    StateNotifierProvider<KiBoardState, List<KiBoard>>((ref) {
  var repository = ref.watch(kiBoardRepositoryProvider);
  return KiBoardState(repository);
});

class KiBoardState extends StateNotifier<List<KiBoard>> {
  final KiBoardRepository _repository;

  KiBoardState(KiBoardRepository repository)
      : _repository = repository,
        super([]) {
    loadBoards();
  }

  Future<void> loadBoards() async {
    state = await _repository.getAllBoards();
    if (state.isEmpty) {
      await createBoard();
    }
  }

  Future<String> createBoard() async {
    var boardId = randomAlpha(5);
    var board = KiBoard(boardId: boardId);
    await _repository.saveKiBoard(boardId, board);
    state = await _repository.getAllBoards();
    return boardId;
  }

  Future<void> removeCurrentBoard(String boardId) async {
    await _repository.remove(boardId);
    await loadBoards();
  }
}
