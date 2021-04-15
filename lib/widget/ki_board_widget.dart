import 'dart:math';

import 'package:flutter/material.dart';
import 'package:little_flower_app/model/ki_board.dart';
import 'package:little_flower_app/model/ki_board_manager.dart';
import 'package:little_flower_app/widget/ki_board_painter.dart';
import 'package:provider/provider.dart';

class KiBoardWidget extends StatelessWidget {
  KiBoardWidget();

  @override
  Widget build(BuildContext context) {
    return Consumer<KiBoardManager>(
      builder: (context, model, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              padding: EdgeInsets.only(bottom: 30),
              child: TextFormField(
                key: ValueKey(model.boardId),
                textAlign: TextAlign.center,
                initialValue: model.boardId,
                onFieldSubmitted: (text) async =>
                    await Provider.of<KiBoardManager>(context, listen: false)
                        .resetKiBoard(boardId: text),
              ),
            ),
            Center(
              child: CustomPaint(
                size: Size(300, 300),
                painter: KiBoardPainter(
                  row: KiBoard.row,
                  column: KiBoard.column,
                  blackKiList: model.current.blackKiList,
                  whiteKiList: model.current.whiteKiList,
                  onTap: (x, y) {
                    Provider.of<KiBoardManager>(context, listen: false)
                        .current
                        .addKi(Point(x, y));
                  },
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 30),
              child: Visibility(
                visible: model.current.isGameOver,
                child: Column(
                  children: [
                    Text(
                      "${model.current.winner} Wins",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextButton(
                      onPressed: () async => await Provider.of<KiBoardManager>(
                              context,
                              listen: false)
                          .resetKiBoard(),
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
            )
          ],
        );
      },
    );
  }
}
