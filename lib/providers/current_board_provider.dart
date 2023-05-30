import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:little_flower_app/model/ki_board.dart';
import 'package:little_flower_app/providers/boards_provider.dart';
import 'package:little_flower_app/repository/ki_board_repository.dart';

final currentBoardProvider =
    StateNotifierProvider<CurrentBoardState, KiBoard>((ref) {
  var kiBoards = ref.watch(kiBoardsProvider);
  var repository = ref.watch(kiBoardRepositoryProvider);
  return CurrentBoardState(kiBoards, repository);
});

class CurrentBoardState extends StateNotifier<KiBoard> {
  final List<KiBoard> boards;
  final KiBoardRepository _repository;

  CurrentBoardState(
    this.boards,
    KiBoardRepository repository,
  )   : _repository = repository,
        super(boards.isNotEmpty ? boards.first : KiBoard(boardId: "123"));

  void changeBoard(String id) {
    state = boards.firstWhere((board) => board.boardId == id);
  }

  Future<void> resetBoard() async {
    var board = KiBoard(boardId: state.boardId);
    await _repository.saveKiBoard(state.boardId, board);
  }

  Future<void> saveBoard() async {
    await _repository.saveKiBoard(state.boardId, state);
  }
}
