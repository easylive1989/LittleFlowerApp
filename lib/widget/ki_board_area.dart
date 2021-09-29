import 'dart:math';

import 'package:flutter/material.dart';
import 'package:little_flower_app/model/ki_board.dart';
import 'package:little_flower_app/service/ki_board_service.dart';
import 'package:little_flower_app/widget/ki_board_painter.dart';
import 'package:provider/provider.dart';

class KiBoardArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var kiBoardManager = context.watch<KiBoardService>();
    return Center(
      child: CustomPaint(
        size: Size(300, 300),
        painter: KiBoardPainter(
          row: KiBoard.row,
          column: KiBoard.column,
          blackKiList: kiBoardManager.board.blackKiList,
          whiteKiList: kiBoardManager.board.whiteKiList,
          onTap: (x, y) {
            context.read<KiBoardService>().addKi(Point(x, y));
          },
        ),
      ),
    );
  }
}
