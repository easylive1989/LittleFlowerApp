import 'package:flutter/material.dart';
import 'package:little_flower_app/model/game_visibility.dart';
import 'package:little_flower_app/model/ki_board_manager.dart';
import 'package:provider/provider.dart';

class BoardInfoArea extends StatelessWidget {
  final KiBoardManager _kiBoardManager;

  const BoardInfoArea(this._kiBoardManager);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Align(
          alignment: Alignment.topRight,
          child: _buildShareSwitch(),
        ),
        _buildBoardId(context),
      ],
    );
  }

  Padding _buildShareSwitch() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 10, 15, 0),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        direction: Axis.horizontal,
        children: [
          Text("Public"),
          Switch(
            value: _kiBoardManager.visibility.isPublic(),
            onChanged: (value) {
              _kiBoardManager.enablePublic(value);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBoardId(BuildContext context) {
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
