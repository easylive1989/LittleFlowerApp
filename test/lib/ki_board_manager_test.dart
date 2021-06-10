import 'dart:async';
import 'dart:math';

import 'package:little_flower_app/model/game_visibility.dart';
import 'package:little_flower_app/model/ki_board.dart';
import 'package:little_flower_app/model/ki_board_manager.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../fixture/fixtures.dart';

late KiBoardManager kiBoardManager;
late MockKiBoardRepository mockLocalRepository;
late MockKiBoardRepository mockRemoteRepository;
late MockKiBoardRepositoryFactory mockKiBoardRepositoryFactory;
String boardId = "boardId";
void main() {
  group('ki board manager tests', () {
    setUp(() {
      mockLocalRepository = MockKiBoardRepository();
      mockRemoteRepository = MockKiBoardRepository();
      mockKiBoardRepositoryFactory = MockKiBoardRepositoryFactory();
      when(mockKiBoardRepositoryFactory.local())
          .thenReturn(mockLocalRepository);
      when(mockKiBoardRepositoryFactory.remote())
          .thenReturn(mockRemoteRepository);
      kiBoardManager = KiBoardManager(mockKiBoardRepositoryFactory);
    });

    test('ki board manager can get current key board', () async {
      await resetKiBoard(KiBoard(), boardId);
      expect(kiBoardManager.board, KiBoard());
    });

    test('read board from repository when reset', () async {
      var kiBoard = KiBoard();
      kiBoard.addKi(Point(1, 1));
      await resetKiBoard(kiBoard, boardId);

      expect(kiBoardManager.board, kiBoard);
    });

    test('enable game visibility', () async {
      await resetKiBoard(KiBoard(), boardId);

      givenBoardPublic();

      expect(kiBoardManager.visibility, GameVisibility.public);
      verify(mockRemoteRepository.onValue(boardId));
    });

    test('update board when public board change', () async {
      var streamController = StreamController<KiBoard>();
      when(mockRemoteRepository.onValue(any))
          .thenAnswer((realInvocation) => streamController.stream);
      await resetKiBoard(KiBoard(), boardId);
      givenBoardPublic();

      var kiBoard = KiBoard();
      kiBoard.addKi(Point(1, 1));
      streamController.add(kiBoard);

      await Future.delayed(Duration(milliseconds: 100), () {
        expect(kiBoardManager.board, kiBoard);
      });

      await streamController.close();
    });

    test('reset board should reload board ids', () async {
      givenBoardIds(["abc", "cde"]);
      await kiBoardManager.loadBoardIds();
      await resetKiBoard(null, boardId);

      expect(kiBoardManager.allBoardIds, ["abc", "cde"]);
    });

    test('load all board id', () async {
      givenBoardIds(["abc", "cde"]);

      await kiBoardManager.loadBoardIds();

      expect(kiBoardManager.allBoardIds, ["abc", "cde"]);
    });

    test('remove board', () async {
      givenBoardIds(["abc", "cde"]);
      await kiBoardManager.loadBoardIds();
      await resetKiBoard(KiBoard(), boardId);

      await kiBoardManager.removeBoard(boardId);

      expect(kiBoardManager.boardId, "abc");
      verify(mockLocalRepository.remove(boardId));
    });
  });
}

void givenBoardIds(List<String> list) {
  when(mockLocalRepository.getBoardIds()).thenAnswer((_) => Future.value(list));
}

void givenBoardPublic() {
  kiBoardManager.enablePublic(true);
}

Future resetKiBoard(KiBoard? kiBoard, String boardId) async {
  when(mockLocalRepository.getKiBoard(any)).thenAnswer((realInvocation) {
    return Future.value(kiBoard);
  });
  await kiBoardManager.resetKiBoard(boardId: boardId);
}
