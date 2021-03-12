import 'dart:math';

import 'package:flutter/material.dart';
import 'package:little_flower_app/ki_board.dart';
import 'package:little_flower_app/ki_board_painter.dart';
import 'package:little_flower_app/ki_boards_database_api.dart';
import 'package:provider/provider.dart';

class KiBoardWidget extends StatelessWidget {
  final KiBoardsDatabaseApi kiBoardsDatabaseApi;

  KiBoardWidget({this.kiBoardsDatabaseApi});

  @override
  Widget build(BuildContext context) {
    return Consumer<KiBoard>(builder: (context, model, child) {
      return Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 100,
            child: Container(
              width: 100,
              child: TextFormField(
                textAlign: TextAlign.center,
                initialValue: model.boardId,
              ),
            ),
          ),
          Center(
            child: CustomPaint(
              size: Size(300, 300),
              painter: KiBoardPainter(
                row: KiBoard.row,
                column: KiBoard.column,
                blackKiList: model.blackKiList,
                whiteKiList: model.whiteKiList,
                onTap: (x, y) {
                  Provider.of<KiBoard>(context, listen: false)
                      .addKi(Point(x, y));
                  kiBoardsDatabaseApi?.update(model);
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
                      "${model.winner} Wins",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextButton(
                      onPressed: () =>
                          Provider.of<KiBoard>(context, listen: false)
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
    });
  }
}
