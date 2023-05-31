import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:little_flower_app/model/ki_board.dart';
import 'package:little_flower_app/providers/board_ids_provider.dart';
import 'package:little_flower_app/providers/current_board_provider.dart';

class BoardSelector extends ConsumerWidget {
  const BoardSelector({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var currentBoard = ref.watch(currentBoardProvider).kiBoard;
    var boardIds = ref.watch(boardIdsProvider);
    if (boardIds.isEmpty || currentBoard == KiBoard.empty()) {
      return SizedBox();
    }
    return DropdownButton<String>(
        underline: SizedBox(),
        isExpanded: true,
        onChanged: (id) {
          ref.read(currentBoardProvider.notifier).changeBoard(id!);
        },
        value: currentBoard.boardId,
        items: boardIds
            .map((boardId) => DropdownMenuItem(
                value: boardId,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    boardId,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                )))
            .toList());
  }
}
