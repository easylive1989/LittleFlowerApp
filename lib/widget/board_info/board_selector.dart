import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:little_flower_app/providers/boards_provider.dart';
import 'package:little_flower_app/providers/current_board_provider.dart';

class BoardSelector extends ConsumerWidget {
  const BoardSelector({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var currentBoard = ref.watch(currentBoardProvider);
    var boards = ref.watch(kiBoardsProvider);
    if (boards.isEmpty) {
      return SizedBox();
    }
    return DropdownButton<String>(
        underline: SizedBox(),
        isExpanded: true,
        onChanged: (id) {
          ref.read(currentBoardProvider.notifier).changeBoard(id!);
        },
        value: currentBoard.boardId,
        items: boards
            .map((board) => DropdownMenuItem(
                value: board.boardId,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    board.boardId,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                )))
            .toList());
  }
}
