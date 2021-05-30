import 'dart:math';

import 'package:flutter/material.dart';
import 'package:little_flower_app/model/ki_board.dart';
import 'package:little_flower_app/model/ki_board_manager.dart';
import 'package:little_flower_app/widget/ki_board_painter.dart';
import 'package:provider/provider.dart';

class KiBoardWidget extends StatelessWidget {
  final KiBoardManager _kiBoardManager;
  KiBoardWidget(this._kiBoardManager);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        size: Size(300, 300),
        painter: KiBoardPainter(
          row: KiBoard.row,
          column: KiBoard.column,
          blackKiList: _kiBoardManager.current.blackKiList,
          whiteKiList: _kiBoardManager.current.whiteKiList,
          onTap: (x, y) {
            Provider.of<KiBoardManager>(context, listen: false)
                .current
                .addKi(Point(x, y));
          },
        ),
      ),
    );
  }
}
