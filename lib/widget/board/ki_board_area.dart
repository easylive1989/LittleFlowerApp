import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:little_flower_app/model/ki_board.dart';
import 'package:little_flower_app/providers/current_board_provider.dart';
import 'package:little_flower_app/widget/board/ki_board_painter.dart';

class KiBoardArea extends ConsumerStatefulWidget {
  @override
  ConsumerState<KiBoardArea> createState() => _KiBoardAreaState();
}

class _KiBoardAreaState extends ConsumerState<KiBoardArea> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    var currentBoard = ref.watch(currentBoardProvider).kiBoard;
    return Center(
      child: GestureDetector(
        onTapDown: (_) => setState(() => _pressed = true),
        onTapUp: (_) => setState(() => _pressed = false),
        child: CustomPaint(
          size: Size(300, 300),
          painter: KiBoardPainter(
            row: KiBoard.row,
            column: KiBoard.column,
            blackKiList: currentBoard.blackKiList,
            whiteKiList: currentBoard.whiteKiList,
            onTap: !kIsWeb || _pressed
                ? (x, y) {
                    ref.read(currentBoardProvider).addKi(Point(x, y));
                    setState(() => _pressed = false);
                  }
                : null,
          ),
        ),
      ),
    );
  }
}
