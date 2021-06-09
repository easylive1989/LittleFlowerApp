import 'package:flutter/material.dart';
import 'package:little_flower_app/model/ki_board_manager.dart';
import 'package:provider/provider.dart';

class BoardIdWidget extends StatelessWidget {
  const BoardIdWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 50,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Icon(
              Icons.arrow_drop_down_rounded,
              size: 40,
            ),
          ),
          TextFormField(
            key: ValueKey(Provider.of<KiBoardManager>(context).boardId),
            textAlign: TextAlign.center,
            initialValue: Provider.of<KiBoardManager>(context).boardId,
            onFieldSubmitted: (text) async =>
                await Provider.of<KiBoardManager>(context, listen: false)
                    .resetKiBoard(boardId: text),
          ),
        ],
      ),
    );
  }
}
