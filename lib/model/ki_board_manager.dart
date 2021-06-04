import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:little_flower_app/model/game_visibility.dart';
import 'package:little_flower_app/model/ki_board.dart';
import 'package:little_flower_app/repository/ki_board_repository.dart';
import 'package:little_flower_app/repository/ki_board_repository_factory.dart';
import 'package:random_string/random_string.dart';

class KiBoardManager extends ChangeNotifier {
  KiBoard get board => _board;

  String get boardId => _boardId;

  GameVisibility get visibility => _visibility;

  late KiBoard _board;
  late String _boardId;
  GameVisibility _visibility;

  KiBoardRepositoryFactory _kiBoardRepositoryFactory;
  KiBoardRepository _kiBoardRepository;
  late StreamSubscription _kiBoardSubscription;

  KiBoardManager(this._kiBoardRepositoryFactory)
      : _visibility = GameVisibility.private,
        _kiBoardRepository =
            _kiBoardRepositoryFactory.get(GameVisibility.private);

  Future resetKiBoard({boardId}) async {
    _boardId = boardId ?? getBoardId();
    _board = await _kiBoardRepository.getKiBoard(_boardId);
    _kiBoardRepository.saveKiBoard(_boardId, _board);
    _kiBoardSubscription =
        _kiBoardRepository.onValue(_boardId).listen(_onBoardUpdate);
    notifyListeners();
  }

  Future addKi(Point<int> point) async {
    _board.addKi(point);
    await _kiBoardRepository.saveKiBoard(boardId, _board);
  }

  void enablePublic(bool enable) {
    _visibility = enable ? GameVisibility.public : GameVisibility.private;
    _kiBoardSubscription.cancel();
    _kiBoardRepository = _kiBoardRepositoryFactory.get(visibility);
    _kiBoardRepository.saveKiBoard(_boardId, _board);
    _kiBoardSubscription =
        _kiBoardRepository.onValue(_boardId).listen(_onBoardUpdate);
    notifyListeners();
  }

  void _onBoardUpdate(KiBoard board) {
    _board = board;
    notifyListeners();
  }

  String getBoardId() {
    return randomAlpha(5);
  }
}
