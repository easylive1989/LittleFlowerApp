import 'package:flutter/material.dart';
import 'package:little_flower_app/model/ki_board_manager.dart';
import 'package:provider/provider.dart';

class BoardIdWidget extends StatelessWidget {
  final KiBoardManager _kiBoardManager;

  const BoardIdWidget(this._kiBoardManager);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      alignment: Alignment.center,
      child: TextFormField(
        key: ValueKey(_kiBoardManager.boardId),
        textAlign: TextAlign.center,
        initialValue: _kiBoardManager.boardId,
        onFieldSubmitted: (text) async =>
            await Provider.of<KiBoardManager>(context, listen: false)
                .resetKiBoard(boardId: text),
      ),
    );
  }
}
