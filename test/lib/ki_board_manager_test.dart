import 'dart:math';

import 'package:little_flower_app/model/game_visibility.dart';
import 'package:little_flower_app/model/ki_board.dart';
import 'package:little_flower_app/model/ki_board_manager.dart';
import 'package:little_flower_app/repo/ki_board_repository.dart';
import 'package:little_flower_app/repo/ki_board_repository_factory.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../fixture/fixtures.dart';

@GenerateMocks([KiBoardRepository])
void main() {
  late StubKiBoardManager kiBoardManager;
  late MockKiBoardRepository mockKiBoardRepository;
  late MockKiBoardRepositoryFactory mockKiBoardRepositoryFactory;
  String boardId = "boardId";

  void _givenKiBoard(KiBoard kiBoard) {
    when(mockKiBoardRepository.getKiBoard(any)).thenAnswer((realInvocation) {
      return Future.value(kiBoard);
    });
  }

  group('ki board manager tests', () {
    setUp(() {
      mockKiBoardRepository = MockKiBoardRepository();
      mockKiBoardRepositoryFactory = MockKiBoardRepositoryFactory();
      when(mockKiBoardRepositoryFactory.get(any))
          .thenReturn(mockKiBoardRepository);
      kiBoardManager =
          StubKiBoardManager(boardId, mockKiBoardRepositoryFactory);
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

    test('enable game visibility', () {
      kiBoardManager.enablePublic(true);

      expect(kiBoardManager.visibility, GameVisibility.public);
      verify(mockKiBoardRepositoryFactory.get(GameVisibility.public));
    });
  });
}

class StubKiBoardManager extends KiBoardManager {
  String boardId;

  StubKiBoardManager(
      this.boardId, KiBoardRepositoryFactory kiBoardRepositoryFactory)
      : super(kiBoardRepositoryFactory);

  @override
  String getBoardId() {
    return boardId;
  }
}
