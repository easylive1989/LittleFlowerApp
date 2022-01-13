import 'package:flutter/material.dart';
import 'package:little_flower_app/widget/board_id_widget.dart';

class BoardInfoArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 80),
      child: BoardIdWidget(),
    );
  }
}
