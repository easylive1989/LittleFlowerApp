import 'dart:async';
import 'dart:math';

import 'package:little_flower_app/model/game_visibility.dart';
import 'package:little_flower_app/model/ki_board.dart';
import 'package:little_flower_app/model/ki_board_manager.dart';
import 'package:little_flower_app/repository/ki_board_repository_factory.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../fixture/fixtures.dart';

late StubKiBoardManager kiBoardManager;
late MockKiBoardRepository mockKiBoardRepository;
late MockKiBoardRepositoryFactory mockKiBoardRepositoryFactory;
String boardId = "boardId";
void main() {
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
      await givenKiBoard(KiBoard());
      expect(kiBoardManager.board, KiBoard());
    });

    test('read board from repository when reset', () async {
      var kiBoard = KiBoard();
      kiBoard.addKi(Point(1, 1));
      await givenKiBoard(kiBoard);

      expect(kiBoardManager.board, kiBoard);
    });

    test('enable game visibility', () async {
      await givenKiBoard(KiBoard());

      kiBoardManager.enablePublic(true);

      expect(kiBoardManager.visibility, GameVisibility.public);
      verify(mockKiBoardRepositoryFactory.get(GameVisibility.public));
    });

    test('update board when board id change', () async {
      var streamController = StreamController<KiBoard>();
      when(mockKiBoardRepository.onValue(any))
          .thenAnswer((realInvocation) => streamController.stream);
      await givenKiBoard(KiBoard());

      var kiBoard = KiBoard();
      kiBoard.addKi(Point(1, 1));
      streamController.add(kiBoard);

      await Future.delayed(Duration(milliseconds: 100), () {
        expect(kiBoardManager.board, kiBoard);
      });

      await streamController.close();
    });
  });
}

Future givenKiBoard(KiBoard kiBoard) async {
  when(mockKiBoardRepository.getKiBoard(any)).thenAnswer((realInvocation) {
    return Future.value(kiBoard);
  });
  await kiBoardManager.resetKiBoard();
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
