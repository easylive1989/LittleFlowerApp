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

  late KiBoard _board;
  late String _boardId;
  GameVisibility _visibility;

  KiBoardRepositoryFactory _kiBoardRepositoryFactory;
  KiBoardRepository _kiBoardRepository;
  StreamSubscription? _kiBoardSubscription;

  KiBoardManager(KiBoardRepositoryFactory kiBoardRepositoryFactory)
      : _visibility = GameVisibility.private,
        _kiBoardRepositoryFactory = kiBoardRepositoryFactory,
        _kiBoardRepository =
            kiBoardRepositoryFactory.get(GameVisibility.private);

  Future resetKiBoard({boardId}) async {
    _boardId = boardId ?? getBoardId();
    _board = await _kiBoardRepository.getKiBoard(_boardId) ?? KiBoard();
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
