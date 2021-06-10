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
class KiBoardManager extends ChangeNotifier {
  KiBoard get board => _board;

  String get boardId => _boardId;

  GameVisibility get visibility => _visibility;

  List<String> get allBoardIds =>
      _allBoardIds.where((id) => id != _boardId).toList();

  List<String> _allBoardIds = [];
  KiBoard _board = KiBoard();
  String _boardId = "";
  GameVisibility _visibility = GameVisibility.private;

  KiBoardRepository _localRepository;
  KiBoardRepository _remoteRepository;
  StreamSubscription? _kiBoardSubscription;

  KiBoardManager(KiBoardRepositoryFactory kiBoardRepositoryFactory)
      : _localRepository = kiBoardRepositoryFactory.local(),
        _remoteRepository = kiBoardRepositoryFactory.remote();

  Future loadBoardIds() async {
    _allBoardIds = await _localRepository.getBoardIds();
  }

  Future resetKiBoard({boardId}) async {
    _boardId = boardId ?? getBoardId();
    var board = await _localRepository.getKiBoard(_boardId);
    if (board == null) {
      _board = KiBoard();
      _saveBoard(_boardId, _board);
      _allBoardIds.add(_boardId);
    } else {
      _board = board;
    }
    notifyListeners();
  }

  Future addKi(Point<int> point) async {
    _board.addKi(point);
    await _saveBoard(_boardId, _board);
    notifyListeners();
  }

  Future<void> _saveBoard(String boardId, KiBoard kiBoard) async {
    await _localRepository.saveKiBoard(boardId, kiBoard);
    if (_visibility == GameVisibility.public) {
      _remoteRepository.saveKiBoard(boardId, kiBoard);
    }
  }

  void enablePublic(bool enable) {
    _visibility = enable ? GameVisibility.public : GameVisibility.private;
    if (enable) {
      _kiBoardSubscription =
          _remoteRepository.onValue(boardId).listen(_onBoardUpdate);
    } else {
      _kiBoardSubscription?.cancel();
    }
    notifyListeners();
  }

  void listenToRemoteChange() {
    _kiBoardSubscription =
        _remoteRepository.onValue(boardId).listen(_onBoardUpdate);
  }

  Future _onBoardUpdate(KiBoard board) async {
    _board = board;
    await _localRepository.saveKiBoard(boardId, _board);
    notifyListeners();
  }

  String getBoardId() {
    return randomAlpha(5);
  }

  Future removeCurrentBoard() async {
    await _localRepository.remove(_boardId);
    _allBoardIds.remove(_boardId);
    await resetKiBoard(
        boardId: _allBoardIds.isNotEmpty ? _allBoardIds.first : null);
  }
}
