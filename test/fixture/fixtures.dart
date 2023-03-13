import 'package:little_flower_app/model/ki_board.dart';
import 'package:little_flower_app/repository/ki_board_repository.dart';
import 'package:mockito/mockito.dart';

class MockKiBoardRepository extends Mock implements KiBoardRepository {
  @override
  Future remove(String? boardId) =>
      super.noSuchMethod(Invocation.method(#remove, [boardId]),
          returnValue: Future.value(),
          returnValueForMissingStub: Future.value());

  @override
  Future saveKiBoard(String? boardId, KiBoard? kiBoard) =>
      super.noSuchMethod(Invocation.method(#saveKiBoard, [boardId, kiBoard]),
          returnValue: Future.value(),
          returnValueForMissingStub: Future.value());

  @override
  Future<KiBoard?> getKiBoard(String? boardId) =>
      super.noSuchMethod(Invocation.method(#getKiBoard, [boardId]),
          returnValue: Future.value(null),
          returnValueForMissingStub: Future.value(null));

  @override
  Stream<KiBoard> onValue(String? boardId) => super.noSuchMethod(
        Invocation.method(#onValue, [boardId]),
        returnValue: Stream.fromIterable(List<KiBoard>.empty()),
        returnValueForMissingStub: Stream.fromIterable(List<KiBoard>.empty()),
      );

  @override
  Future<List<String>> getBoardIds() => super.noSuchMethod(
        Invocation.method(#getBoardIds, []),
        returnValue: Future.value(List<String>.empty()),
        returnValueForMissingStub: Future.value(List<String>.empty()),
      );
}