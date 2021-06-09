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

  KiBoardRepositoryFactory _kiBoardRepositoryFactory;
  KiBoardRepository _kiBoardRepository;
  StreamSubscription? _kiBoardSubscription;

  KiBoardManager(KiBoardRepositoryFactory kiBoardRepositoryFactory)
      : _kiBoardRepositoryFactory = kiBoardRepositoryFactory,
        _kiBoardRepository =
            kiBoardRepositoryFactory.get(GameVisibility.private);

  Future loadBoardIds() async {
    _allBoardIds = await _kiBoardRepository.getBoardIds();
  }

  Future resetKiBoard({boardId}) async {
    _boardId = boardId ?? getBoardId();
    var board = await _kiBoardRepository.getKiBoard(_boardId);
    if (board == null) {
      _board = KiBoard();
      _kiBoardRepository.saveKiBoard(_boardId, _board);
      _allBoardIds.add(_boardId);
    } else {
      _board = board;
    }
    notifyListeners();
  }

  Future addKi(Point<int> point) async {
    _board.addKi(point);
    await _kiBoardRepository.saveKiBoard(boardId, _board);
    notifyListeners();
  }

  void enablePublic(bool enable) {
    _visibility = enable ? GameVisibility.public : GameVisibility.private;
    _kiBoardRepository = _kiBoardRepositoryFactory.get(visibility);
    if (enable) {
      listenToRemoteChange();
    }
    notifyListeners();
  }

  void listenToRemoteChange() {
    _kiBoardSubscription?.cancel();
    _kiBoardRepository.saveKiBoard(boardId, _board);
    _kiBoardSubscription =
        _kiBoardRepository.onValue(boardId).listen(_onBoardUpdate);
  }

  void _onBoardUpdate(KiBoard board) {
    _board = board;
    notifyListeners();
  }

  String getBoardId() {
    return randomAlpha(5);
  }
}
