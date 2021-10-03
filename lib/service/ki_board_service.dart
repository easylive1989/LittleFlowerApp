import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:little_flower_app/model/game_visibility.dart';
import 'package:little_flower_app/model/ki_board.dart';
import 'package:little_flower_app/repository/ki_board_repository.dart';
import 'package:little_flower_app/repository/ki_board_repository_factory.dart';
import 'package:random_string/random_string.dart';

@Injectable()
class KiBoardService extends ChangeNotifier {
  KiBoard get board => _board;

  List<String> get allOtherBoardIds =>
      _allBoardIds.where((id) => id != _board.boardId).toList();
  List<String> get allBoardIds => _allBoardIds;

  List<String> _allBoardIds = [];
  late KiBoard _board = KiBoard(boardId: "not exist");

  KiBoardRepository _localRepository;
  KiBoardRepository _remoteRepository;
  StreamSubscription? _kiBoardSubscription;

  KiBoardService(KiBoardRepositoryFactory kiBoardRepositoryFactory)
      : _localRepository = kiBoardRepositoryFactory.local(),
        _remoteRepository = kiBoardRepositoryFactory.remote();

  Future loadBoardIds() async {
    _allBoardIds = await _localRepository.getBoardIds();
  }

  Future resetKiBoard({boardId}) async {
    _kiBoardSubscription?.cancel();
    if (boardId == null) {
      _createNewBoard(boardId);
      notifyListeners();
      return;
    }
    var board = await _localRepository.getKiBoard(boardId);
    var remoteBoard = await _remoteRepository.getKiBoard(boardId);
    if (board == null && remoteBoard == null) {
      _createNewBoard(boardId);
    } else if (board == null && remoteBoard != null) {
      _board = remoteBoard;
      _saveBoard(_board.boardId, _board);
      _allBoardIds.insert(0, _board.boardId);
      listenToRemote(_board.boardId);
    } else if (board != null) {
      _board = board;
    }
    notifyListeners();
  }

  void _createNewBoard(boardId) {
    _board = KiBoard(boardId: boardId ?? getBoardId());
    _saveBoard(_board.boardId, _board);
    _allBoardIds.insert(0, _board.boardId);
  }

  Future addKi(Point<int> point) async {
    _board.addKi(point);
    await _saveBoard(_board.boardId, _board);
    notifyListeners();
  }

  Future _saveBoard(String boardId, KiBoard kiBoard) async {
    await _localRepository.saveKiBoard(boardId, kiBoard);
    if (board.gameVisibility == GameVisibility.public) {
      _remoteRepository.saveKiBoard(boardId, kiBoard);
    }
  }

  void enablePublic() {
    if (board.gameVisibility == GameVisibility.private) {
      listenToRemote(_board.boardId);
    }
    _board.gameVisibility = GameVisibility.public;
    notifyListeners();
  }

  void listenToRemote(String boardId) {
    _kiBoardSubscription =
        _remoteRepository.onValue(boardId).listen(_onBoardUpdate);
  }

  Future _onBoardUpdate(KiBoard board) async {
    _board = board;
    await _localRepository.saveKiBoard(_board.boardId, _board);
    notifyListeners();
  }

  String getBoardId() {
    return randomAlpha(5);
  }

  Future removeCurrentBoard() async {
    await _localRepository.remove(_board.boardId);
    _allBoardIds.remove(_board.boardId);
    if (board.gameVisibility == GameVisibility.public) {
      _kiBoardSubscription?.cancel();
    }
    await resetKiBoard(
        boardId: _allBoardIds.isNotEmpty ? _allBoardIds.first : null);
  }
}
