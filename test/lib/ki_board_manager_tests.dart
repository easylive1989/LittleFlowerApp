import 'package:little_flower_app/ki_board_manager.dart';
import 'package:little_flower_app/ki_board_model.dart';
import 'package:test/test.dart';

void main() {
  group('ki board manager tests', () {
    StubKiBoardManager kiBoardManager;
    String boardId = "boardId";

    setUp(() {
      kiBoardManager = StubKiBoardManager();
    });

    test('ki board manager can get current key board', () {
      kiBoardManager.boardId = boardId;

      expect(kiBoardManager.current, KiBoardModel(boardId));
    });
  });
}

class StubKiBoardManager extends KiBoardManager {
  String boardId;

  @override
  String getBoardId() {
    return boardId;
  }
}
