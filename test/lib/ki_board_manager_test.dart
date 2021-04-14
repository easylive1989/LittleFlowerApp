import 'package:little_flower_app/IKiBoardRepository.dart';
import 'package:little_flower_app/ki_board.dart';
import 'package:little_flower_app/ki_board_manager.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

void main() {
  group('ki board manager tests', () {
    StubKiBoardManager kiBoardManager;
    String boardId = "boardId";
    MockKiBoardRepository mockKiBoardRepository;

    setUp(() {
      mockKiBoardRepository = MockKiBoardRepository();
      kiBoardManager = StubKiBoardManager(boardId, mockKiBoardRepository);
    });

    test('ki board manager can get current key board', () {
      expect(kiBoardManager.current, KiBoard());
    });

    // test('read board from repository when reset', () async {
    //   var kiBoard = KiBoard();
    //   kiBoard.addKi(Point(1, 1));
    //   when(mockKiBoardRepository.getKiBoard(any)).thenAnswer((realInvocation) {
    //     return Future.value(kiBoard);
    //   });
    //
    //   await kiBoardManager.resetKiBoard();
    //
    //   expect(kiBoardManager.current, kiBoard);
    // });
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
