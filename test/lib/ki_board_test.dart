import 'dart:math';

import 'package:little_flower_app/model/ki.dart';
import 'package:little_flower_app/model/ki_board.dart';
import 'package:test/test.dart';

String boardId = "boardId";
void main() {
  group('KiBoardModel', () {
    late KiBoard kiBoardModel;

    setUp(() {
      kiBoardModel = KiBoard(boardId: boardId);
    });
    test('add ki when ki board is empty should add black ki', () {
      kiBoardModel.addKi(Point(1, 1));

      expect(kiBoardModel.blackKiList.contains(Point(1, 1)), true);
    });

    test('add ki when last ki is black should add white ki', () {
      kiBoardModel.addKi(Point(1, 1));
      kiBoardModel.addKi(Point(1, 2));

      expect(kiBoardModel.whiteKiList.contains(Point(1, 2)), true);
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

      expect(kiBoardModel.isGameOver(), true);
      expect(kiBoardModel.winner, Ki.black);
    });

    test('convert json to ki board', () {
      kiBoardModel.addKi(Point(1, 1));
      kiBoardModel.addKi(Point(1, 2));
      var json = kiBoardModel.toJson();

      KiBoard actualKiBoard = KiBoard.fromJson(json);

      expect(actualKiBoard, kiBoardModel);
    });
  });
}
