import 'package:flutter/material.dart';
import 'package:little_flower_app/widget/board_id_widget.dart';
import 'package:little_flower_app/widget/board_public_switch.dart';

class BoardInfoArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Align(
          alignment: Alignment.topRight,
          child: BoardPublicSwitch(),
        ),
        Padding(
          padding: EdgeInsets.only(top: 80),
          child: BoardIdWidget(),
        ),
      ],
    );
  }
}
