import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:little_flower_app/model/ki_board.dart';
import 'package:little_flower_app/repository/ki_board_repository.dart';
import 'package:little_flower_app/service/ki_board_service.dart';

final kiBoardsProvider =
    StateNotifierProvider<KiBoardState, List<KiBoard>>((ref) {
  var repository = ref.watch(kiBoardRepositoryProvider);
  var service = ref.watch(kiBoardServiceProvider);
  return KiBoardState(repository, service);
});

class KiBoardState extends StateNotifier<List<KiBoard>> {
  final KiBoardRepository _repository;
  final KiBoardService _service;

  KiBoardState(KiBoardRepository repository, KiBoardService service)
      : _repository = repository,
        _service = service,
        super([]) {
    loadBoards();
  }

  Future<void> loadBoards() async {
    state = await _repository.getAllBoards();
    if (state.isEmpty) {
      await createBoard();
    }
  }

  Future<void> createBoard() async {
    await _service.createBoard();
    loadBoards();
  }

  Future<void> removeCurrentBoard(String boardId) async {
    await _service.removeBoard(boardId);
    await loadBoards();
  }
}
