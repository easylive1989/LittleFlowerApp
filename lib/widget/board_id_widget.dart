import 'package:flutter/material.dart';
import 'package:little_flower_app/controller/ki_board_controller.dart';
import 'package:little_flower_app/service/ki_board_service.dart';
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
    var kiBoardController = context.watch<KiBoardController>();
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
              _buildBoardId(context, kiBoardController.boardId),
              _isListOpen
                  ? _buildBoardIdList(context, kiBoardController.allBoardId)
                  : Container(),
            ],
          ),
        ),
        SizedBox(width: 10),
        _buildRefreshIcon(context),
        _buildDeleteIcon(context, kiBoardController.boardId),
      ],
    );
  }

  IconButton _buildRefreshIcon(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.read<KiBoardController>().resetKiBoard();
      },
      iconSize: 30,
      icon: Icon(
        Icons.refresh_rounded,
        color: Colors.blue,
      ),
    );
  }

  Widget _buildDeleteIcon(BuildContext context, String boardId) {
    return GestureDetector(
      child: IconButton(
        onPressed: () {
          context.read<KiBoardController>().removeCurrentBoard(boardId);
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
      BuildContext context, Future<List<String>> getBoardIdFuture) {
    return FutureBuilder<List<String>>(
        future: getBoardIdFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var allBoardIds = snapshot.data!;
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
                          .read<KiBoardController>()
                          .changeKiBoard(allBoardIds[index]);
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
          } else {
            return Container();
          }
        });
  }

  Widget _buildBoardId(BuildContext context, String boardId) {
    return Container(
      height: 50,
      child: Stack(
        children: [
          TextFormField(
            key: ValueKey(boardId),
            decoration: InputDecoration(border: InputBorder.none),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
            initialValue: boardId,
            onTap: () {
              setState(() {
                _isListOpen = false;
              });
            },
            onFieldSubmitted: (text) async =>
                await context.read<KiBoardService>().changeKiBoard(text),
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
