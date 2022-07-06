import 'package:flutter/material.dart';
import 'package:little_flower_app/entity/ki_board.dart';
import 'package:little_flower_app/widget/ki_board_painter.dart';

class KiBoardArea extends StatelessWidget {
  const KiBoardArea({
    Key? key,
    required this.kiBoard,
  }) : super(key: key);

  final KiBoard kiBoard;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        size: Size(300, 300),
        painter: KiBoardPainter(
          row: KiBoard.row,
          column: KiBoard.column,
          blackKiList: kiBoard.blackKiList,
          whiteKiList: kiBoard.whiteKiList,
          onTap: (x, y) {
            // context.read<KiBoardController>().addKi(Point(x, y));
          },
        ),
      ),
    );
  }
}
