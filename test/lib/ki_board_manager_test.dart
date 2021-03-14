import 'package:little_flower_app/ki_board.dart';
import 'package:little_flower_app/ki_board_manager.dart';
import 'package:test/test.dart';

void main() {
  group('ki board manager tests', () {
    StubKiBoardManager kiBoardManager;
    String boardId = "boardId";

    setUp(() {
      kiBoardManager = StubKiBoardManager(boardId);
    });

    test('ki board manager can get current key board', () {
      kiBoardManager.boardId = boardId;

      expect(kiBoardManager.current, KiBoard(boardId));
    });
  });
}

class StubKiBoardManager extends KiBoardManager {
  String boardId;

  StubKiBoardManager(this.boardId);

  @override
  String getBoardId() {
    return boardId;
  }
}
