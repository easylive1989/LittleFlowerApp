import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:little_flower_app/model/ki_board.dart';
import 'package:little_flower_app/providers/boards_provider.dart';

final currentBoardProvider =
    StateNotifierProvider<CurrentBoardState, KiBoard>((ref) {
  var kiBoards = ref.watch(kiBoardsProvider);
  return CurrentBoardState(kiBoards);
});

class CurrentBoardState extends StateNotifier<KiBoard> {
  final List<KiBoard> boards;

  // TODO
  CurrentBoardState(this.boards)
      : super(boards.isNotEmpty ? boards.first : KiBoard(boardId: "123"));

  void changeBoard(String id) {
    state = boards.firstWhere((board) => board.boardId == id);
  }

  Future<void> resetBoard() async {}
}
