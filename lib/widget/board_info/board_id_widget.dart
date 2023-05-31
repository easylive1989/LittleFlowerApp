import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:little_flower_app/providers/board_ids_provider.dart';
import 'package:little_flower_app/providers/current_board_provider.dart';
import 'package:little_flower_app/widget/board_info/add_button.dart';
import 'package:little_flower_app/widget/board_info/board_selector.dart';
import 'package:little_flower_app/widget/board_info/delete_button.dart';
import 'package:little_flower_app/widget/board_info/refresh_button.dart';

class BoardIdWidget extends ConsumerWidget {
  const BoardIdWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 150,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: BoardSelector(),
        ),
        SizedBox(width: 10),
        AddButton(onTap: () async {
          var id = await ref.read(boardIdsProvider.notifier).createBoard();
          ref.read(currentBoardProvider.notifier).changeBoard(id);
        }),
        RefreshButton(onTap: () {
          ref.read(currentBoardProvider.notifier).resetBoard();
          ref.read(boardIdsProvider.notifier).loadBoards();
        }),
        DeleteButton(onTap: () {
          var currentBoard = ref.read(currentBoardProvider).kiBoard;
          ref.read(boardIdsProvider.notifier).removeCurrentBoard(
                currentBoard.boardId,
              );
        }),
      ],
    );
  }
}
