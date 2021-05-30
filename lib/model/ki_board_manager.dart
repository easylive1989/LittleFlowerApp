import 'package:flutter/material.dart';
import 'package:little_flower_app/model/game_visibility.dart';
import 'package:little_flower_app/model/ki_board.dart';
import 'package:little_flower_app/repo/ki_board_repository.dart';
import 'package:little_flower_app/repo/ki_board_repository_factory.dart';
import 'package:random_string/random_string.dart';

class KiBoardManager extends ChangeNotifier {
  KiBoard get board => _board;
  String get boardId => _boardId;
  GameVisibility get visibility => _visibility;

  KiBoard _board;
  late String _boardId;
  GameVisibility _visibility;

  KiBoardRepositoryFactory _kiBoardRepositoryFactory;
  KiBoardRepository _kiBoardRepository;

  KiBoardManager(KiBoardRepositoryFactory kiBoardRepositoryFactory)
      : _kiBoardRepository =
            kiBoardRepositoryFactory.get(GameVisibility.private),
        _board = KiBoard(),
        _visibility = GameVisibility.private,
        _kiBoardRepositoryFactory = kiBoardRepositoryFactory;

  Future resetKiBoard({boardId}) async {
    _boardId = boardId ?? getBoardId();
    _updateKiBoard(await _kiBoardRepository.getKiBoard(_boardId));
    notify();
  }

  void _updateKiBoard(KiBoard kiBoard) {
    _board.removeListener(notify);
    _board = kiBoard;
    _board.addListener(notify);
  }

  void notify() {
    _kiBoardRepository.saveKiBoard(boardId, _board);
    notifyListeners();
  }

  void enablePublic(bool enable) {
    _visibility = enable ? GameVisibility.public : GameVisibility.private;
    _kiBoardRepository = _kiBoardRepositoryFactory.get(visibility);
    notifyListeners();
  }

  String getBoardId() {
    return randomAlpha(5);
  }
}
