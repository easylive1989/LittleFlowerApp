import 'dart:math';

import 'package:little_flower_app/model/ki_board.dart';
import 'package:little_flower_app/model/ki_board_manager.dart';
import 'package:little_flower_app/repo/IKiBoardRepository.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

void main() {
  StubKiBoardManager kiBoardManager;
  String boardId = "boardId";
  MockKiBoardRepository mockKiBoardRepository;

  void _givenKiBoard(KiBoard kiBoard) {
    when(mockKiBoardRepository.getKiBoard(any)).thenAnswer((realInvocation) {
      return Future.value(kiBoard);
    });
  }

  group('ki board manager tests', () {
    setUp(() {
      mockKiBoardRepository = MockKiBoardRepository();
      kiBoardManager = StubKiBoardManager(boardId, mockKiBoardRepository);
    });

    test('ki board manager can get current key board', () async {
      _givenKiBoard(KiBoard());
      await kiBoardManager.resetKiBoard();
      expect(kiBoardManager.current, KiBoard());
    });

    test('read board from repository when reset', () async {
      var kiBoard = KiBoard();
      kiBoard.addKi(Point(1, 1));
      _givenKiBoard(kiBoard);

      await kiBoardManager.resetKiBoard();

      expect(kiBoardManager.current, kiBoard);
    });
  });
}

class StubKiBoardManager extends KiBoardManager {
  String boardId;

  StubKiBoardManager(this.boardId, MockKiBoardRepository mockKiBoardRepository)
      : super(mockKiBoardRepository);

  @override
  String getBoardId() {
    return boardId;
  }
}

class MockKiBoardRepository extends Mock implements IKiBoardRepository {}
