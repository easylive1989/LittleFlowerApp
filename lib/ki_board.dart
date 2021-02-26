import 'dart:math';

import 'package:flutter/material.dart';
import 'package:little_flower_app/ki_board_model.dart';
import 'package:little_flower_app/ki_board_painter.dart';
import 'package:provider/provider.dart';

class KiBoard extends StatelessWidget {
  final Function(int x, int y) onTap;

  KiBoard({this.onTap});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => KiBoardModel(),
      child: Center(
        child: Consumer<KiBoardModel>(
          builder: (context, model, child) {
            return CustomPaint(
              size: Size(300, 300),
              painter: KiBoardPainter(
                blackKiList: model.blackKiList,
                whiteKiList: model.whiteKiList,
                onTap: (x, y) {
                  Provider.of<KiBoardModel>(context, listen: false)
                      .addKi(Point(x, y));
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
