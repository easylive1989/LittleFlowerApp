import 'package:little_flower_app/model/game_visibility.dart';
import 'package:little_flower_app/model/ki_board.dart';
import 'package:little_flower_app/repository/ki_board_repository.dart';
import 'package:little_flower_app/repository/ki_board_repository_factory.dart';
import 'package:mockito/mockito.dart';

class MockKiBoardRepository extends Mock implements KiBoardRepository {
  @override
  Future saveKiBoard(String? boardId, KiBoard? kiBoard) =>
      super.noSuchMethod(Invocation.method(#saveKiBoard, [boardId, kiBoard]),
          returnValue: Future.value(),
          returnValueForMissingStub: Future.value());

  @override
  Future<KiBoard> getKiBoard(String? boardId) =>
      super.noSuchMethod(Invocation.method(#getKiBoard, [boardId]),
          returnValue: Future<KiBoard>.value(KiBoard()));

  @override
  Stream<KiBoard> onValue(String? boardId) => super.noSuchMethod(
        Invocation.method(#onValue, [boardId]),
        returnValue: Stream.fromIterable(List<KiBoard>.empty()),
        returnValueForMissingStub: Stream.fromIterable(List<KiBoard>.empty()),
      );
}

class MockKiBoardRepositoryFactory extends Mock
    implements KiBoardRepositoryFactory {
  @override
  KiBoardRepository get(GameVisibility? gameVisibility) =>
      super.noSuchMethod(Invocation.method(#get, [gameVisibility]),
          returnValue: MockKiBoardRepository(),
          returnValueForMissingStub: MockKiBoardRepository());
}
