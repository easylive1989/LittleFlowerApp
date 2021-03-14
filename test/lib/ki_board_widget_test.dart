// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:little_flower_app/ki_board.dart';
import 'package:little_flower_app/ki_board_manager.dart';
import 'package:little_flower_app/ki_board_painter.dart';
import 'package:little_flower_app/ki_board_widget.dart';
import 'package:little_flower_app/ki_boards_database_api.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

void main() {
  group('ki board widget', () {
    String boardId = 'boardId';
    KiBoardManager kiBoardManager;

    setUp(() {
      kiBoardManager = KiBoardManager();
      kiBoardManager.updateKiBoard(KiBoard(boardId));
    });

    testWidgets('show game Id in ki board', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ChangeNotifierProvider(
              create: (context) => kiBoardManager,
              child: KiBoardWidget(),
            ),
          ),
        ),
      );

      var formField = tester.widget<EditableText>(find.text(boardId));

      expect(find.byWidget(formField), findsOneWidget);
    });

    testWidgets('add ki should update firebase database',
        (WidgetTester tester) async {
      var mockFirebaseDatabaseApi = MockFirebaseDatabaseApi();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ChangeNotifierProvider(
              create: (context) => kiBoardManager,
              child:
                  KiBoardWidget(kiBoardsDatabaseApi: mockFirebaseDatabaseApi),
            ),
          ),
        ),
      );

      CustomPaint painter = tester.widget<CustomPaint>(find.byWidgetPredicate(
          (widget) =>
              widget is CustomPaint && widget.painter is KiBoardPainter));
      (painter.painter as KiBoardPainter).onTap(1, 2);

      var expectedKiBoard = KiBoard(boardId);
      expectedKiBoard.addKi(Point(1, 2));
      verify(mockFirebaseDatabaseApi.update(expectedKiBoard));
    });
  });
}

class MockFirebaseDatabaseApi extends Mock implements KiBoardsDatabaseApi {}
