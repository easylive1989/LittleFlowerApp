import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:little_flower_app/model/ki_board.dart';
import 'package:little_flower_app/providers/board_ids_provider.dart';
import 'package:little_flower_app/repository/ki_board_repository.dart';

final currentBoardProvider =
    StateNotifierProvider<CurrentBoardState, KiBoard>((ref) {
  var boardIds = ref.watch(boardIdsProvider);
  return CurrentBoardState(boardIds, ref);
});

class CurrentBoardState extends StateNotifier<KiBoard> {
  final Ref ref;

  CurrentBoardState(List<String> boardIds, this.ref) : super(KiBoard.empty()) {
    _loadFirstBoard(boardIds);
  }

  Future<void> changeBoard(String id) async {
    state = (await _repository.getKiBoard(id))!;
  }

  Future<void> resetBoard() async {
    var board = KiBoard(boardId: state.boardId);
    await _repository.saveKiBoard(state.boardId, board);
  }

  Future<void> saveBoard() async {
    await _repository.saveKiBoard(state.boardId, state);
  }

  void _loadFirstBoard(List<String> boardIds) async {
    if (boardIds.isNotEmpty) {
      var id = ref.read(boardIdsProvider).first;
      await changeBoard(id);
    }
  }

  KiBoardRepository get _repository => ref.read(kiBoardRepositoryProvider);
}
