import 'package:flutter/material.dart';
import 'package:little_flower_app/model/ki_board_manager.dart';
import 'package:provider/provider.dart';

class BoardIdWidget extends StatefulWidget {
  const BoardIdWidget({Key? key}) : super(key: key);

  @override
  _BoardIdWidgetState createState() => _BoardIdWidgetState();
}

class _BoardIdWidgetState extends State<BoardIdWidget> {
  bool _isListOpen = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      child: Column(
        children: [
          _buildBoardId(context),
          Visibility(
            visible: _isListOpen,
            child: Container(
              color: Colors.white,
              child: _buildBoardIdList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBoardIdList() {
    var list = [
      "abc",
      "def",
      "ghi",
      "jkl",
      "mno",
      "abc",
      "def",
      "ghi",
      "jkl",
      "mno",
      "abc",
      "def",
      "ghi",
      "jkl",
      "mno",
      "abc",
      "def",
      "ghi",
      "jkl",
      "mno",
      "abc",
      "def",
      "ghi",
      "jkl",
      "mno",
      "abc",
      "def",
      "ghi",
      "jkl",
      "mno"
    ];
    return LimitedBox(
      maxHeight: 300,
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Text(
            list[index],
          );
        },
      ),
    );
  }

  Widget _buildBoardId(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(5.0),
      ),
      height: 50,
      child: Stack(
        children: [
          TextFormField(
            key: ValueKey(Provider.of<KiBoardManager>(context).boardId),
            decoration: InputDecoration(border: InputBorder.none),
            textAlign: TextAlign.center,
            initialValue: Provider.of<KiBoardManager>(context).boardId,
            onFieldSubmitted: (text) async =>
                await Provider.of<KiBoardManager>(context, listen: false)
                    .resetKiBoard(boardId: text),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isListOpen = !_isListOpen;
                  print("abc");
                });
              },
              child: Icon(
                Icons.arrow_drop_down_rounded,
                size: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
