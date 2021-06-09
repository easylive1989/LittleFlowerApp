import 'package:flutter/material.dart';
import 'package:little_flower_app/generated/l10n.dart';
import 'package:little_flower_app/model/game_visibility.dart';
import 'package:little_flower_app/model/ki_board_manager.dart';
import 'package:little_flower_app/widget/board_id_widget.dart';

class BoardInfoArea extends StatelessWidget {
  final KiBoardManager _kiBoardManager;

  const BoardInfoArea(this._kiBoardManager);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Align(
          alignment: Alignment.topRight,
          child: _buildShareSwitch(context),
        ),
        Padding(
          padding: EdgeInsets.only(top: 80),
          child: BoardIdWidget(),
        ),
      ],
    );
  }

  Padding _buildShareSwitch(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 10, 15, 0),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        direction: Axis.horizontal,
        children: [
          Text(S.of(context).switch_public),
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
}
