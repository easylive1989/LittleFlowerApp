import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:little_flower_app/ki_board_model.dart';
import 'package:little_flower_app/ki_board_painter.dart';
import 'package:little_flower_app/ki_boards_database_api.dart';
import 'package:provider/provider.dart';

class KiBoard extends StatelessWidget {
  final Function(int x, int y) onTap;
  final KiBoardsDatabaseApi kiBoardsDatabaseApi;

  KiBoard({this.onTap, this.kiBoardsDatabaseApi});

  @override
  Widget build(BuildContext context) {
    return Consumer<KiBoardModel>(builder: (context, model, child) {
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
                row: KiBoardModel.row,
                column: KiBoardModel.column,
                blackKiList: model.blackKiList,
                whiteKiList: model.whiteKiList,
                onTap: (x, y) {
                  Provider.of<KiBoardModel>(context, listen: false)
                      .addKi(Point(x, y));
                  kiBoardsDatabaseApi?.update(
                      model.boardId, jsonEncode(model.toJson()));
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
                      "${model.winnerKi} Wins",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextButton(
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
    });
  }
}
