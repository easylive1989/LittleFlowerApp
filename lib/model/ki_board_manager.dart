import 'package:flutter/material.dart';
import 'package:little_flower_app/model/game_visibility.dart';
import 'package:little_flower_app/model/ki_board.dart';
import 'package:little_flower_app/repo/ki_board_repository.dart';
import 'package:little_flower_app/repo/ki_board_repository_factory.dart';
import 'package:random_string/random_string.dart';

class KiBoardManager extends ChangeNotifier {
  late KiBoard _current;

  KiBoard get current => _current;

  late String _boardId;

  String get boardId => _boardId;

  GameVisibility visibility;

  KiBoardRepositoryFactory _kiBoardRepositoryFactory;
  KiBoardRepository _kiBoardRepository;

  KiBoardManager(KiBoardRepositoryFactory kiBoardRepositoryFactory)
      : _kiBoardRepository =
            kiBoardRepositoryFactory.get(GameVisibility.private),
        _current = KiBoard(),
        visibility = GameVisibility.private,
        _kiBoardRepositoryFactory = kiBoardRepositoryFactory;

  Future resetKiBoard({boardId}) async {
    _boardId = boardId ?? getBoardId();
    _updateKiBoard(await _kiBoardRepository.getKiBoard(_boardId));
    notify();
  }

  void _updateKiBoard(KiBoard kiBoard) {
    _current.removeListener(notify);
    _current = kiBoard;
    _current.addListener(notify);
  }

  void notify() {
    _kiBoardRepository.saveKiBoard(boardId, _current);
    notifyListeners();
  }

  void enablePublic(bool enable) {
    visibility = enable ? GameVisibility.public : GameVisibility.private;
    _kiBoardRepository = _kiBoardRepositoryFactory.get(visibility);
    notifyListeners();
  }

  String getBoardId() {
    return randomAlpha(5);
  }
}
