// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:little_flower_app/ki_board.dart';
import 'package:little_flower_app/ki_board_model.dart';
import 'package:little_flower_app/ki_boards_database_api.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

void main() {
  group('ki board', () {
    testWidgets('show game Id in ki board', (WidgetTester tester) async {
      var kiBoardModel = KiBoardModel(MockFirebaseDatabaseApi());
      kiBoardModel.boardId = "uuid";
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider(
            create: (context) => kiBoardModel,
            child: KiBoard(),
          ),
        ),
      );

      expect(find.text("uuid"), findsOneWidget);
    });
  });
}

class MockFirebaseDatabaseApi extends Mock implements KiBoardsDatabaseApi {}
