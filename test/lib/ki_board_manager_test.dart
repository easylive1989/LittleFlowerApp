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
late StreamController<KiBoard> streamController;
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

    test('reset a exist public board', () async {
      givenRemoteBoard(KiBoard());

      await kiBoardManager.resetKiBoard(boardId: boardId);

      expect(kiBoardManager.board, KiBoard());
      expect(kiBoardManager.visibility, GameVisibility.public);
      verify(mockRemoteRepository.onValue(boardId));
    });

    test('reset a non-exist private board', () async {
      givenLocalBoard(null);

      await kiBoardManager.resetKiBoard(boardId: boardId);

      expect(kiBoardManager.board, KiBoard());
      expect(kiBoardManager.visibility, GameVisibility.private);
      verifyNever(mockRemoteRepository.onValue(boardId));
    });

    test('reset a exist private board', () async {
      var kiBoard = getBoard(points: [Point(1, 1)]);
      givenLocalBoard(kiBoard);

      await kiBoardManager.resetKiBoard(boardId: boardId);

      expect(kiBoardManager.board, kiBoard);
      expect(kiBoardManager.visibility, GameVisibility.private);
      verifyNever(mockRemoteRepository.onValue(boardId));
    });

    test('toggle a private game should change to public', () async {
      await kiBoardManager.resetKiBoard(boardId: boardId);

      kiBoardManager.enablePublic();

      expect(kiBoardManager.visibility, GameVisibility.public);
      verify(mockRemoteRepository.onValue(boardId));
    });

    test('toggle a public game should remain in public', () async {
      await kiBoardManager.resetKiBoard(boardId: boardId);

      kiBoardManager.enablePublic();
      kiBoardManager.enablePublic();

      expect(kiBoardManager.visibility, GameVisibility.public);
      verify(mockRemoteRepository.onValue(boardId)).called(1);
    });

    test('update board when public board change', () async {
      await givenRemoteBoardReset(KiBoard());

      var kiBoard = [Point(1, 1)];
      whenRemoteBoardChange(getBoard(points: kiBoard));

      await Future.delayed(Duration(milliseconds: 100), () {
        expect(kiBoardManager.board, getBoard(points: kiBoard));
      });

      await streamController.close();
    });

    test('load all board ids', () async {
      givenBoardIds(["abc", "cde"]);

      await kiBoardManager.loadBoardIds();

      expect(kiBoardManager.allBoardIds, ["abc", "cde"]);
    });

    test('remove private board', () async {
      givenBoardIdsLoad(["abc", "cde"]);
      await kiBoardManager.resetKiBoard(boardId: boardId);

      await kiBoardManager.removeCurrentBoard();

      expect(kiBoardManager.boardId, "abc");
      expect(kiBoardManager.allBoardIds, ["cde"]);
      verify(mockLocalRepository.remove(boardId));
      verifyNever(mockRemoteRepository.remove(any));
    });
  });
}

Future<void> givenRemoteBoardReset(KiBoard kiBoard) async {
  givenRemoteController();
  givenRemoteBoard(kiBoard);
  await kiBoardManager.resetKiBoard(boardId: boardId);
}

void whenRemoteBoardChange(KiBoard kiBoard) {
  streamController.add(kiBoard);
}

void givenRemoteController() {
  streamController = StreamController<KiBoard>();
  when(mockRemoteRepository.onValue(any))
      .thenAnswer((realInvocation) => streamController.stream);
}

Future<void> givenBoardIdsLoad(List<String> boardIds) async {
  givenBoardIds(boardIds);
  await kiBoardManager.loadBoardIds();
}

KiBoard getBoard({
  List<Point<int>> points = const [],
}) {
  var kiBoard = KiBoard();
  for (var point in points) {
    kiBoard.addKi(point);
  }
  return kiBoard;
}

void givenLocalBoard(KiBoard? kiBoard) {
  when(mockLocalRepository.getKiBoard(any)).thenAnswer((realInvocation) {
    return Future.value(kiBoard);
  });
}

void givenRemoteBoard(KiBoard? board) {
  when(mockRemoteRepository.getKiBoard(any))
      .thenAnswer((realInvocation) => Future.value(board));
}

void givenBoardIds(List<String> list) {
  when(mockLocalRepository.getBoardIds()).thenAnswer((_) => Future.value(list));
}
