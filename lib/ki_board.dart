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
      child: Consumer<KiBoardModel>(builder: (context, model, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: CustomPaint(
                size: Size(300, 300),
                painter: KiBoardPainter(
                  row: 15,
                  column: 15,
                  blackKiList: model.blackKiList,
                  whiteKiList: model.whiteKiList,
                  onTap: (x, y) {
                    Provider.of<KiBoardModel>(context, listen: false)
                        .addKi(Point(x, y));
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 100,
              child: Container(
                child: Visibility(
                  visible: model.isGameOver,
                  child: Column(
                    children: [
                      Text(
                        "White Wins",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      FlatButton(
                        onPressed: () =>
                            Provider.of<KiBoardModel>(context, listen: false)
                                .cleanUp(),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 5.0,
                            horizontal: 10.0,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text("Play Again"),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        );
      }),
    );
  }
}
