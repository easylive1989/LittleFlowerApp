import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:little_flower_app/controller/ki_board_controller.dart';
import 'package:little_flower_app/generated/l10n.dart';
import 'package:little_flower_app/helper/translate_helper.dart';
import 'package:provider/provider.dart';

class ResultArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var controller = context.watch<KiBoardController>();
    return Container(
      height: 180,
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 30),
      child: Visibility(
        visible: controller.board.isGameOver(),
        child: Column(
          children: [
            Text(
              S.of(context).text_ki_wins(
                  TranslateHelper.getKi(context, controller.board.winner)),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 5,
            ),
            TextButton(
              onPressed: () async =>
                  await context.read<KiBoardController>().createBoard(),
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
    );
  }
}
