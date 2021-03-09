import 'dart:math';

import 'package:little_flower_app/ki_board_model.dart';
import 'package:little_flower_app/ki_boards_database_api.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

void main() {
  group('KiBoardModel', () {
    test('add ki should update firebase database', () {
      var firebaseDatabaseApi = MockFirebaseDatabaseApi();
      var kiBoardModel = StubKiBoardModel('boardId', firebaseDatabaseApi);
      kiBoardModel.addKi(Point(1, 1));
      verify(firebaseDatabaseApi.update('boardId',
          '{"blackKiList":[{"x":1,"y":1}],"whiteKiList":[],"isGameOver":false,"winner":0}'));
    });
  });
}

class StubKiBoardModel extends KiBoardModel {
  String _boardId;
  StubKiBoardModel(this._boardId, KiBoardsDatabaseApi firebaseDatabaseApi)
      : super(firebaseDatabaseApi);

  @override
  String getBoardId() {
    return _boardId;
  }
}

class MockFirebaseDatabaseApi extends Mock implements KiBoardsDatabaseApi {}
