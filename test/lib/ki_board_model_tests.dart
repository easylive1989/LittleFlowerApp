import 'dart:math';

import 'package:little_flower_app/ki_board_model.dart';
import 'package:little_flower_app/ki_boards_database_api.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

void main() {
  group('KiBoardModel', () {
    var firebaseDatabaseApi;
    var kiBoardModel;

    setUp(() {
      firebaseDatabaseApi = MockFirebaseDatabaseApi();
      kiBoardModel = KiBoardModel(firebaseDatabaseApi);
    });

    test('add ki should update firebase database', () {
      kiBoardModel.boardId = 'boardId';

      kiBoardModel.addKi(Point(1, 1));

      verify(firebaseDatabaseApi.update('boardId',
          '{"blackKiList":[{"x":1,"y":1}],"whiteKiList":[],"isGameOver":false,"winner":0}'));
    });
  });
}

class MockFirebaseDatabaseApi extends Mock implements KiBoardsDatabaseApi {}
