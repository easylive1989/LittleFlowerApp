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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          onPressed: () {
            Provider.of<KiBoardManager>(context, listen: false).resetKiBoard();
          },
          iconSize: 30,
          icon: Icon(Icons.refresh_rounded),
        ),
        SizedBox(
          width: 10,
        ),
        Container(
          width: 150,
          height: _isListOpen ? 352 : 52,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Column(
            children: [
              _buildBoardId(context),
              _isListOpen ? _buildBoardIdList() : Container(),
            ],
          ),
        ),
        SizedBox(width: 10),
        _buildDeleteIcon(),
      ],
    );
  }

  Widget _buildDeleteIcon() {
    return GestureDetector(
      child: IconButton(
        onPressed: () {
          Provider.of<KiBoardManager>(context, listen: false)
              .removeCurrentBoard();
        },
        iconSize: 30,
        icon: Icon(
          Icons.delete_rounded,
          size: 30,
        ),
      ),
    );
  }

  Widget _buildBoardIdList() {
    var allBoardIds = Provider.of<KiBoardManager>(context).allBoardIds;
    return Container(
      height: 300,
      color: Colors.white,
      child: ListView.builder(
        padding: EdgeInsets.all(0),
        itemCount: allBoardIds.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _isListOpen = false;
              });
              Provider.of<KiBoardManager>(context, listen: false)
                  .resetKiBoard(boardId: allBoardIds[index]);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Text(
                allBoardIds[index],
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBoardId(BuildContext context) {
    return Container(
      height: 50,
      child: Stack(
        children: [
          TextFormField(
            key: ValueKey(Provider.of<KiBoardManager>(context).boardId),
            decoration: InputDecoration(border: InputBorder.none),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
            initialValue: Provider.of<KiBoardManager>(context).boardId,
            onTap: () {
              setState(() {
                _isListOpen = false;
              });
            },
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
                  FocusScope.of(context).requestFocus(new FocusNode());
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
