import 'package:flutter/material.dart';
import 'package:little_flower_app/controller/ki_board_controller.dart';
import 'package:little_flower_app/widget/board_info/add_button.dart';
import 'package:little_flower_app/widget/board_info/board_selector.dart';
import 'package:little_flower_app/widget/board_info/delete_button.dart';
import 'package:little_flower_app/widget/board_info/refresh_button.dart';
import 'package:provider/provider.dart';

class BoardIdWidget extends StatelessWidget {
  const BoardIdWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var kiBoardController = context.watch<KiBoardController>();
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
          child: BoardSelector(allBoardIds: kiBoardController.boardIds),
        ),
        SizedBox(width: 10),
        AddButton(onTap: () {
          context.read<KiBoardController>().createBoard();
        }),
        RefreshButton(onTap: () {
          context.read<KiBoardController>().resetKiBoard();
        }),
        DeleteButton(onTap: () {
          context.read<KiBoardController>().removeCurrentBoard();
        }),
      ],
    );
  }
}
