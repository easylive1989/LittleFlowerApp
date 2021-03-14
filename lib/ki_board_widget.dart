import 'dart:math';

import 'package:flutter/material.dart';
import 'package:little_flower_app/ki_board.dart';
import 'package:little_flower_app/ki_board_manager.dart';
import 'package:little_flower_app/ki_board_painter.dart';
import 'package:little_flower_app/ki_boards_database_api.dart';
import 'package:provider/provider.dart';

class KiBoardWidget extends StatelessWidget {
  final KiBoardsDatabaseApi kiBoardsDatabaseApi;

  KiBoardWidget({this.kiBoardsDatabaseApi});

  @override
  Widget build(BuildContext context) {
    return Consumer<KiBoardManager>(builder: (context, model, child) {
      return Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 100,
            child: Container(
              width: 100,
              child: TextFormField(
                textAlign: TextAlign.center,
                initialValue: model.current.boardId,
              ),
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
                  kiBoardsDatabaseApi?.update(model.current);
                },
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            child: Container(
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
                      onPressed: () =>
                          Provider.of<KiBoardManager>(context, listen: false)
                              .current
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
