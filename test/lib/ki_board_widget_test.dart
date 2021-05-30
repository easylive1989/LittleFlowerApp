// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:little_flower_app/model/ki_board.dart';
import 'package:little_flower_app/model/ki_board_manager.dart';
import 'package:little_flower_app/widget/board_info_area.dart';
import 'package:little_flower_app/widget/ki_board_area.dart';
import 'package:little_flower_app/widget/ki_board_painter.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../fixture/fixtures.dart';

void main() {
  group('ki board widget', () {
    late KiBoardManager kiBoardManager;
    late MockKiBoardRepository mockKiBoardRepository;

    setUp(() async {
      mockKiBoardRepository = MockKiBoardRepository();
      kiBoardManager = KiBoardManager(mockKiBoardRepository);
      when(mockKiBoardRepository.getKiBoard(any))
          .thenAnswer((realInvocation) => Future.value(KiBoard()));
      await kiBoardManager.resetKiBoard();
    });

    testWidgets('show game id in ki board', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ChangeNotifierProvider(
              create: (context) => kiBoardManager,
              child: BoardInfoArea(kiBoardManager),
            ),
          ),
        ),
      );

      var formField = tester.widget<TextFormField>(
          find.byWidgetPredicate((widget) => widget is TextFormField));

      expect(find.byWidget(formField), findsOneWidget);
    });

    testWidgets('add ki should update repository', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ChangeNotifierProvider(
              create: (context) => kiBoardManager,
              child: KiBoardArea(kiBoardManager),
            ),
          ),
        ),
      );

      CustomPaint painter = tester.widget<CustomPaint>(find.byWidgetPredicate(
          (widget) =>
              widget is CustomPaint && widget.painter is KiBoardPainter));
      (painter.painter as KiBoardPainter).onTap?.call(1, 2);

      var expectedKiBoard = KiBoard();
      expectedKiBoard.addKi(Point(1, 2));

      verify(mockKiBoardRepository.saveKiBoard(any, expectedKiBoard));
    });
  });
}
