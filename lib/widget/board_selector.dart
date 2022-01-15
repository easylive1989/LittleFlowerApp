import 'package:flutter/material.dart';
import 'package:little_flower_app/controller/ki_board_controller.dart';
import 'package:provider/provider.dart';

class BoardSelector extends StatelessWidget {
  const BoardSelector({
    Key? key,
    required this.allBoardIds,
  }) : super(key: key);

  final List<String> allBoardIds;

  @override
  Widget build(BuildContext context) {
    var boardId2 = context.read<KiBoardController>().boardId;
    print(boardId2);
    return DropdownButton<String>(
        underline: SizedBox(),
        isExpanded: true,
        onChanged: (value) {
          context.read<KiBoardController>().changeKiBoard(value!);
        },
        value: boardId2,
        items: allBoardIds
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
