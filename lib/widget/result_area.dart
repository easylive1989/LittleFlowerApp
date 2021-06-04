import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:little_flower_app/generated/l10n.dart';
import 'package:little_flower_app/helper/translate_helper.dart';
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
                S.of(context).text_ki_wins(TranslateHelper.getKi(
                    context, _kiBoardManager.board.winner)),
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
                  child: Text(S.of(context).button_play_again),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
