import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:little_flower_app/model/ki_board.dart';
import 'package:little_flower_app/providers/board_ids_provider.dart';
import 'package:little_flower_app/repository/ki_board_repository.dart';

final currentBoardProvider =
    ChangeNotifierProvider<CurrentBoardState>((ref) {
  var boardIds = ref.watch(boardIdsProvider);
  return CurrentBoardState(boardIds, ref);
});

class CurrentBoardState extends ChangeNotifier {
  final Ref ref;
  KiBoard kiBoard = KiBoard.empty();

  CurrentBoardState(List<String> boardIds, this.ref) : super() {
    _loadFirstBoard(boardIds);
  }

  Future<void> changeBoard(String id) async {
    kiBoard = (await _repository.getKiBoard(id))!;
    notifyListeners();
  }

  Future<void> resetBoard() async {
    kiBoard = KiBoard(boardId: kiBoard.boardId);
    await _repository.saveKiBoard(kiBoard.boardId, kiBoard);
    notifyListeners();
  }

  Future<void> addKi(Point<int> point) async {
    kiBoard.addKi(point);
    await _repository.saveKiBoard(kiBoard.boardId, kiBoard);
    notifyListeners();
  }

  void _loadFirstBoard(List<String> boardIds) async {
    if (boardIds.isNotEmpty) {
      var id = ref.read(boardIdsProvider).first;
      await changeBoard(id);
    }
  }

  KiBoardRepository get _repository => ref.read(kiBoardRepositoryProvider);
}
