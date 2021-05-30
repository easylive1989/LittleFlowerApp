import 'package:flutter/material.dart';
import 'package:little_flower_app/model/game_visibility.dart';
import 'package:little_flower_app/model/ki_board.dart';
import 'package:little_flower_app/repo/ki_board_repository.dart';
import 'package:little_flower_app/repo/ki_board_repository_factory.dart';
import 'package:random_string/random_string.dart';

class KiBoardManager extends ChangeNotifier {
  KiBoard get current => _current;
  String get boardId => _boardId;
  GameVisibility get visibility => _visibility;

  KiBoard _current;
  late String _boardId;
  GameVisibility _visibility;

  KiBoardRepositoryFactory _kiBoardRepositoryFactory;
  KiBoardRepository _kiBoardRepository;

  KiBoardManager(KiBoardRepositoryFactory kiBoardRepositoryFactory)
      : _kiBoardRepository =
            kiBoardRepositoryFactory.get(GameVisibility.private),
        _current = KiBoard(),
        _visibility = GameVisibility.private,
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
    _visibility = enable ? GameVisibility.public : GameVisibility.private;
    _kiBoardRepository = _kiBoardRepositoryFactory.get(visibility);
    notifyListeners();
  }

  String getBoardId() {
    return randomAlpha(5);
  }
}
