import 'package:flutter/material.dart';
import 'package:little_flower_app/model/game_visibility.dart';
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
    var kiBoardManager = context.watch<KiBoardManager>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 150,
          height: _isListOpen ? 352 : 52,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Column(
            children: [
              _buildBoardId(context, kiBoardManager),
              _isListOpen
                  ? _buildBoardIdList(context, kiBoardManager)
                  : Container(),
            ],
          ),
        ),
        SizedBox(width: 10),
        _buildRefreshIcon(context),
        _buildShareIcon(context, kiBoardManager),
        _buildDeleteIcon(context),
      ],
    );
  }

  IconButton _buildShareIcon(
      BuildContext context, KiBoardManager kiBoardManager) {
    return IconButton(
      onPressed: () {
        context.read<KiBoardManager>().enablePublic();
      },
      icon: Icon(Icons.share_rounded),
      iconSize: 30,
      color: kiBoardManager.visibility.isPublic() ? Colors.blue : Colors.grey,
    );
  }

  IconButton _buildRefreshIcon(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.read<KiBoardManager>().resetKiBoard();
      },
      iconSize: 30,
      icon: Icon(
        Icons.refresh_rounded,
        color: Colors.blue,
      ),
    );
  }

  Widget _buildDeleteIcon(BuildContext context) {
    return GestureDetector(
      child: IconButton(
        onPressed: () {
          context.read<KiBoardManager>().removeCurrentBoard();
        },
        iconSize: 30,
        icon: Icon(
          Icons.delete_rounded,
          color: Colors.red,
        ),
      ),
    );
  }

  Widget _buildBoardIdList(
      BuildContext context, KiBoardManager kiBoardManager) {
    var allBoardIds = kiBoardManager.allBoardIds;
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
              context
                  .read<KiBoardManager>()
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

  Widget _buildBoardId(BuildContext context, KiBoardManager kiBoardManager) {
    return Container(
      height: 50,
      child: Stack(
        children: [
          TextFormField(
            key: ValueKey(kiBoardManager.boardId),
            decoration: InputDecoration(border: InputBorder.none),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
            initialValue: kiBoardManager.boardId,
            onTap: () {
              setState(() {
                _isListOpen = false;
              });
            },
            onFieldSubmitted: (text) async => await context
                .read<KiBoardManager>()
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
