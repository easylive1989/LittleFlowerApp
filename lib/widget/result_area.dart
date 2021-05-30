import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:little_flower_app/model/ki_board_manager.dart';
import 'package:provider/provider.dart';

class ResultArea extends StatelessWidget {
  final KiBoardManager _kiBoardManager;
  const ResultArea(this._kiBoardManager);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 30),
        child: Visibility(
          visible: _kiBoardManager.board.isGameOver,
          child: Column(
            children: [
              Text(
                "${_kiBoardManager.board.winner} Wins",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 5,
              ),
              TextButton(
                onPressed: () async =>
                    await Provider.of<KiBoardManager>(context, listen: false)
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
      ),
    );
  }
}
