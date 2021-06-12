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

    test('reset a exist private board', () async {
      givenRemoteBoard(null);
      await resetKiBoard(KiBoard(), boardId);
      expect(kiBoardManager.board, KiBoard());
      expect(kiBoardManager.visibility, GameVisibility.private);
    });

    test('reset a exist public board', () async {
      givenRemoteBoard(KiBoard());
      await resetKiBoard(KiBoard(), boardId);
      expect(kiBoardManager.board, KiBoard());
      expect(kiBoardManager.visibility, GameVisibility.public);
      verify(mockRemoteRepository.onValue(boardId));
    });

    test('reset a non-exist private board', () async {
      await resetKiBoard(null, boardId);
      expect(kiBoardManager.board, KiBoard());
    });

    test('read board from repository when reset', () async {
      var kiBoard = KiBoard();
      kiBoard.addKi(Point(1, 1));
      await resetKiBoard(kiBoard, boardId);

      expect(kiBoardManager.board, kiBoard);
    });

    test('toggle a private game should change to public', () async {
      await resetKiBoard(KiBoard(), boardId);

      kiBoardManager.enablePublic();

      expect(kiBoardManager.visibility, GameVisibility.public);
      verify(mockRemoteRepository.onValue(boardId));
    });

    test('toggle a public game should remain in public', () async {
      await resetKiBoard(KiBoard(), boardId);

      kiBoardManager.enablePublic();
      kiBoardManager.enablePublic();

      expect(kiBoardManager.visibility, GameVisibility.public);
      verify(mockRemoteRepository.onValue(boardId)).called(1);
    });

    test('update board when public board change', () async {
      var streamController = StreamController<KiBoard>();
      when(mockRemoteRepository.onValue(any))
          .thenAnswer((realInvocation) => streamController.stream);
      await resetKiBoard(KiBoard(), boardId);
      kiBoardManager.enablePublic();

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

    test('remove private board', () async {
      givenBoardIds(["abc", "cde"]);
      await kiBoardManager.loadBoardIds();
      await resetKiBoard(KiBoard(), boardId);

      await kiBoardManager.removeCurrentBoard();

      expect(kiBoardManager.boardId, "abc");
      expect(kiBoardManager.allBoardIds, ["cde"]);
      verify(mockLocalRepository.remove(boardId));
      verifyNever(mockRemoteRepository.remove(any));
    });
  });
}

void givenRemoteBoard(KiBoard? board) {
  when(mockRemoteRepository.getKiBoard(any))
      .thenAnswer((realInvocation) => Future.value(board));
}

void givenBoardIds(List<String> list) {
  when(mockLocalRepository.getBoardIds()).thenAnswer((_) => Future.value(list));
}

Future resetKiBoard(KiBoard? kiBoard, String boardId) async {
  when(mockLocalRepository.getKiBoard(any)).thenAnswer((realInvocation) {
    return Future.value(kiBoard);
  });
  await kiBoardManager.resetKiBoard(boardId: boardId);
}
