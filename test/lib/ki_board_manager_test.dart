import 'dart:async';
import 'dart:math';

import 'package:little_flower_app/model/ki_board.dart';
import 'package:little_flower_app/service/ki_board_service.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../fixture/fixtures.dart';

late KiBoardService kiBoardService;
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
      kiBoardService = KiBoardService(mockKiBoardRepositoryFactory);
    });

    test('update board when public board change', () async {
      await givenRemoteBoardReset(KiBoard(boardId: boardId));

      var kiBoard = [Point(1, 1)];
      whenRemoteBoardChange(getBoard(points: kiBoard));

      await Future.delayed(Duration(milliseconds: 100), () {
        expect(kiBoardService.board, getBoard(points: kiBoard));
      });

      await streamController.close();
    });

    test('load all board ids', () async {
      givenBoardIds(["abc", "cde"]);

      // await kiBoardService.getBoardIds();

      expect(await kiBoardService.allOtherBoardIds, ["abc", "cde"]);
    });

    test('remove private board', () async {
      givenBoardIdsLoad(["abc", "cde"]);
      await kiBoardService.resetKiBoard(boardId: boardId);

      await kiBoardService.removeCurrentBoard();

      expect(kiBoardService.board.boardId, "abc");
      expect(await kiBoardService.allOtherBoardIds, ["cde"]);
      verify(mockLocalRepository.remove(boardId));
      verifyNever(mockRemoteRepository.remove(any));
    });
  });
}

Future<void> givenRemoteBoardReset(KiBoard kiBoard) async {
  givenRemoteController();
  givenRemoteBoard(kiBoard);
  await kiBoardService.resetKiBoard(boardId: boardId);
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
  // await kiBoardService.getBoardIds();
}

KiBoard getBoard({
  List<Point<int>> points = const [],
}) {
  var kiBoard = KiBoard(boardId: boardId);
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
