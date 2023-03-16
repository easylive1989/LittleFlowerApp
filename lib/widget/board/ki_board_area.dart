import 'dart:math';

import 'package:flutter/material.dart';
import 'package:little_flower_app/controller/ki_board_controller.dart';
import 'package:little_flower_app/model/ki_board.dart';
import 'package:little_flower_app/widget/board/ki_board_painter.dart';
import 'package:provider/provider.dart';

class KiBoardArea extends StatefulWidget {
  @override
  State<KiBoardArea> createState() => _KiBoardAreaState();
}

class _KiBoardAreaState extends State<KiBoardArea> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    var controller = context.watch<KiBoardController>();
    return Center(
      child: GestureDetector(
        onTapDown: (_) => setState(() => _pressed = true),
        onTapUp: (_) => setState(() => _pressed = false),
        child: CustomPaint(
          size: Size(300, 300),
          painter: KiBoardPainter(
            row: KiBoard.row,
            column: KiBoard.column,
            blackKiList: controller.board.blackKiList,
            whiteKiList: controller.board.whiteKiList,
            onTap: _pressed
                ? (x, y) {
                    context.read<KiBoardController>().addKi(Point(x, y));
                    setState(() => _pressed = false);
                  }
                : null,
          ),
        ),
      ),
    );
  }
}
