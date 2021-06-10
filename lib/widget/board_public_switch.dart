import 'package:flutter/material.dart';
import 'package:little_flower_app/generated/l10n.dart';
import 'package:little_flower_app/model/game_visibility.dart';
import 'package:little_flower_app/model/ki_board_manager.dart';
import 'package:provider/provider.dart';

class BoardPublicSwitch extends StatelessWidget {
  const BoardPublicSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 10, 15, 0),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        direction: Axis.horizontal,
        children: [
          Text(S.of(context).switch_public),
          Switch(
            value: context.read<KiBoardManager>().visibility.isPublic(),
            onChanged: (value) {
              context.read<KiBoardManager>().enablePublic(value);
            },
          ),
        ],
      ),
    );
  }
}
