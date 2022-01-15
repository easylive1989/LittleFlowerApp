import 'package:flutter/material.dart';
import 'package:little_flower_app/controller/ki_board_controller.dart';
import 'package:little_flower_app/widget/board_selector.dart';
import 'package:little_flower_app/widget/delete_button.dart';
import 'package:little_flower_app/widget/refresh_button.dart';
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
          child: _buildBoardSelector(context, kiBoardController.allBoardId),
        ),
        SizedBox(width: 10),
        RefreshButton(onTap: () {
          context.read<KiBoardController>().resetKiBoard();
        }),
        DeleteButton(onTap: () {
          context
              .read<KiBoardController>()
              .removeCurrentBoard(kiBoardController.boardId);
        }),
      ],
    );
  }

  Widget _buildBoardSelector(
    BuildContext context,
    Future<List<String>> getBoardIdFuture,
  ) {
    return FutureBuilder<List<String>>(
      future: getBoardIdFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          var allBoardIds = snapshot.data!;
          return BoardSelector(allBoardIds: allBoardIds);
        } else {
          return Container();
        }
      },
    );
  }
}
