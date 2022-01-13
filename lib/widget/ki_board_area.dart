import 'dart:math';

import 'package:flutter/material.dart';
import 'package:little_flower_app/controller/ki_board_controller.dart';
import 'package:little_flower_app/model/ki_board.dart';
import 'package:little_flower_app/widget/ki_board_painter.dart';
import 'package:provider/provider.dart';

class KiBoardArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var controller = context.watch<KiBoardController>();
    return Center(
      child: CustomPaint(
        size: Size(300, 300),
        painter: KiBoardPainter(
          row: KiBoard.row,
          column: KiBoard.column,
          blackKiList: controller.board.blackKiList,
          whiteKiList: controller.board.whiteKiList,
          onTap: (x, y) {
            context.read<KiBoardController>().addKi(Point(x, y));
          },
        ),
      ),
    );
  }
}
