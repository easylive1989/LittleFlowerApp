import 'dart:math';

import 'package:flutter/material.dart';
import 'package:little_flower_app/model/ki_board.dart';
import 'package:little_flower_app/model/ki_board_manager.dart';
import 'package:little_flower_app/widget/ki_board_painter.dart';
import 'package:provider/provider.dart';

class KiBoardArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var kiBoardManager = context.watch<KiBoardManager>();
    return Center(
      child: CustomPaint(
        size: Size(300, 300),
        painter: KiBoardPainter(
          row: KiBoard.row,
          column: KiBoard.column,
          blackKiList: kiBoardManager.board.blackKiList,
          whiteKiList: kiBoardManager.board.whiteKiList,
          onTap: (x, y) {
            context.read<KiBoardManager>().addKi(Point(x, y));
          },
        ),
      ),
    );
  }
}
