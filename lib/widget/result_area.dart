import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:little_flower_app/generated/l10n.dart';
import 'package:little_flower_app/helper/translate_helper.dart';
import 'package:little_flower_app/providers/boards_provider.dart';
import 'package:little_flower_app/providers/current_board_provider.dart';

class ResultArea extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // var controller = context.watch<KiBoardController>();
    var currentBoard = ref.watch(currentBoardProvider);
    return Container(
      height: 180,
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 30),
      child: Visibility(
        visible: currentBoard.isGameOver(),
        child: Column(
          children: [
            Text(
              S.of(context).text_ki_wins(
                  TranslateHelper.getKi(context, currentBoard.winner)),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 5,
            ),
            TextButton(
              onPressed: () async {
                ref.read(kiBoardsProvider.notifier).createBoard();
              },
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
