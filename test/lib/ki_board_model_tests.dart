import 'dart:math';

import 'package:little_flower_app/ki_board_model.dart';
import 'package:little_flower_app/ki_boards_database_api.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

void main() {
  group('KiBoardModel', () {
    MockFirebaseDatabaseApi firebaseDatabaseApi;
    KiBoardModel kiBoardModel;

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

    test('connect five same ki should be game over', () {
      kiBoardModel.addKi(Point(1, 1));
      kiBoardModel.addKi(Point(2, 1));
      kiBoardModel.addKi(Point(1, 2));
      kiBoardModel.addKi(Point(2, 2));
      kiBoardModel.addKi(Point(1, 3));
      kiBoardModel.addKi(Point(2, 3));
      kiBoardModel.addKi(Point(1, 4));
      kiBoardModel.addKi(Point(2, 4));
      kiBoardModel.addKi(Point(1, 5));

      expect(kiBoardModel.isGameOver, true);
    });
  });
}

class MockFirebaseDatabaseApi extends Mock implements KiBoardsDatabaseApi {}
